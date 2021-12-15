struct VerticalLine{I <: Integer} <: AbstractShape
    i_min::I
    i_max::I
    j::I
end

struct HorizontalLine{I <: Integer} <: AbstractShape
    i::I
    j_min::I
    j_max::I
end

struct Line{I <: Integer} <: AbstractShape
    point1::Point{I}
    point2::Point{I}
end

struct ThickLine{I <: Integer} <: AbstractShape
    point1::Point{I}
    point2::Point{I}
    diameter::I
end

#####
##### VerticalLine
#####

is_valid(shape::VerticalLine) = shape.i_min <= shape.i_max

function is_outbounds(shape::VerticalLine, image::AbstractMatrix)
    i_min = shape.i_min
    i_max = shape.i_max
    j = shape.j

    i_min_image = firstindex(image, 1)
    i_max_image = lastindex(image, 1)

    j_min_image = firstindex(image, 2)
    j_max_image = lastindex(image, 2)

    return i_max < i_min_image || i_min > i_max_image || j < j_min_image || j > j_max_image
end

function clip(shape::VerticalLine, image::AbstractMatrix)
    i_min = shape.i_min
    i_max = shape.i_max
    j = shape.j

    i_min_image = firstindex(image, 1)
    i_max_image = lastindex(image, 1)

    j_min_image = firstindex(image, 2)
    j_max_image = lastindex(image, 2)

    if i_min < i_min_image
        i_min = i_min_image
    end

    if i_max > i_max_image
        i_max = i_max_image
    end

    return VerticalLine(i_min, i_max, j)
end

function draw!(image::AbstractMatrix, shape::VerticalLine, color)
    @assert is_valid(shape) "Cannot draw invalid shape $(shape)"

    if is_outbounds(shape, image)
        return nothing
    end

    _draw!(image, clip(shape, image), color)

    return nothing
end

@inline function _draw!(image::AbstractMatrix, shape::VerticalLine, color)
    @inbounds image[shape.i_min:shape.i_max, shape.j] .= color
    return nothing
end

get_bounding_box(shape::VerticalLine) = Rectangle(Point(shape.i_min, shape.j), shape.i_max - shape.i_min + one(shape.i_min), one(shape.i_min))

#####
##### HorizontalLine
#####

is_valid(shape::HorizontalLine) = shape.j_min <= shape.j_max

function is_outbounds(shape::HorizontalLine, image::AbstractMatrix)
    i = shape.i
    j_min = shape.j_min
    j_max = shape.j_max

    i_min_image = firstindex(image, 1)
    i_max_image = lastindex(image, 1)

    j_min_image = firstindex(image, 2)
    j_max_image = lastindex(image, 2)

    return i < i_min_image || i > i_max_image || j_max < j_min_image || j_min > j_max_image
end

function clip(shape::HorizontalLine, image::AbstractMatrix)
    i = shape.i
    j_min = shape.j_min
    j_max = shape.j_max

    i_min_image = firstindex(image, 1)
    i_max_image = lastindex(image, 1)

    j_min_image = firstindex(image, 2)
    j_max_image = lastindex(image, 2)

    if j_min < j_min_image
        j_min = j_min_image
    end

    if j_max > j_max_image
        j_max = j_max_image
    end

    return HorizontalLine(i, j_min, j_max)
end

function draw!(image::AbstractMatrix, shape::HorizontalLine, color)
    @assert is_valid(shape) "Cannot draw invalid shape $(shape)"

    if is_outbounds(shape, image)
        return nothing
    end

    _draw!(image, clip(shape, image), color)

    return nothing
end

@inline function _draw!(image::AbstractMatrix, shape::HorizontalLine, color)
    @inbounds image[shape.i, shape.j_min:shape.j_max] .= color
    return nothing
end

get_bounding_box(shape::HorizontalLine) = Rectangle(Point(shape.i, shape.j_min), one(shape.i), shape.j_max - shape.j_min + one(shape.i))

#####
##### Line
#####

function is_inbounds(shape::Line, image::AbstractMatrix)
    point1 = shape.point1
    point2 = shape.point2

    i1 = point1.i
    j1 = point1.j
    i2 = point2.i
    j2 = point2.j

    i_min, i_max = minmax(i1, i2)
    j_min, j_max = minmax(j1, j2)

    i_min_image = firstindex(image, 1)
    i_max_image = lastindex(image, 1)

    j_min_image = firstindex(image, 2)
    j_max_image = lastindex(image, 2)

    return i_min >= i_min_image && j_min >= j_min_image && i_max <= i_max_image && j_max <= j_max_image
end

"""
Draw a line. Ref: https://en.wikipedia.org/wiki/Bresenham%27s_line_algorithm
"""
function draw!(image::AbstractMatrix, shape::Line, color)
    point1 = shape.point1
    point2 = shape.point2

    i1 = point1.i
    j1 = point1.j
    i2 = point2.i
    j2 = point2.j

    if j1 == j2
        i_min, i_max = minmax(i1, i2)
        draw!(image, VerticalLine(i_min, i_max, j1), color)
        return nothing
    end

    if i1 == i2
        j_min, j_max = minmax(j1, j2)
        draw!(image, HorizontalLine(i1, j_min, j_max), color)
        return nothing
    end

    if is_inbounds(shape, image)
        _draw!(put_pixel_unchecked!, image, shape, color)
    else
        _draw!(put_pixel!, image, shape, color)
    end

    return nothing
end

_draw!(image::AbstractMatrix, shape::Line, color) = _draw!(put_pixel_unchecked!, image, shape, color)

function _draw!(f::Function, image::AbstractMatrix, shape::Line, color)
    point1 = shape.point1
    point2 = shape.point2

    i1 = point1.i
    j1 = point1.j
    i2 = point2.i
    j2 = point2.j

    I = typeof(i1)

    di = abs(i2 - i1)
    dj = -abs(j2 - j1)
    si = i1 < i2 ? one(I) : -one(I)
    sj = j1 < j2 ? one(I) : -one(I)
    err = di + dj

    while true
        f(image, i1, j1, color)

        if (i1 == i2 && j1 == j2)
            break
        end

        e2 = convert(I, 2) * err

        if (e2 >= dj)
            err += dj
            i1 += si
        end

        if (e2 <= di)
            err += di
            j1 += sj
        end
    end

    return nothing
end

function get_bounding_box(shape::Line)
    point1 = shape.point1
    point2 = shape.point2

    i1 = point1.i
    j1 = point1.j
    i2 = point2.i
    j2 = point2.j

    I = typeof(i1)

    if i1 < i2
        i_min = i1
        height = i2 - i1 + one(I)
    else
        i_min = i2
        height = i1 - i2 + one(I)
    end

    if j1 < j2
        j_min = j1
        width = j2 - j1 + one(I)
    else
        j_min = j2
        width = j1 - j2 + one(I)
    end

    return Rectangle(Point(i_min, j_min), height, width)
end

#####
##### ThickLine
#####

is_valid(shape::ThickLine) = shape.diameter > zero(shape.diameter)

function is_inbounds(shape::ThickLine, image::AbstractMatrix)
    bounding_box = get_bounding_box(shape)
    i_min = bounding_box.position.i
    j_min = bounding_box.position.j

    I = typeof(i_min)

    i_max = i_min + bounding_box.height - one(I)
    j_max = j_min + bounding_box.width - one(I)

    i_min_image = firstindex(image, 1)
    i_max_image = lastindex(image, 1)

    j_min_image = firstindex(image, 2)
    j_max_image = lastindex(image, 2)

    return i_min >= i_min_image && j_min >= j_min_image && i_max <= i_max_image && j_max <= j_max_image
end

function draw!(image::AbstractMatrix, shape::ThickLine, color)
    @assert is_valid(shape) "Cannot draw invalid shape $(shape)"

    point1 = shape.point1
    point2 = shape.point2
    diameter = shape.diameter

    I = typeof(diameter)

    radius = diameter ÷ convert(I, 2)

    if is_inbounds(shape, image)
        _draw!(image, Line(point1, point2), color) do image, i, j, color
            _draw!(image, FilledCircle(Point(i - radius, j - radius), diameter), color)
        end
    else
        _draw!(image, Line(point1, point2), color) do image, i, j, color
            draw!(image, FilledCircle(Point(i - radius, j - radius), diameter), color)
        end
    end

    return nothing
end

function _draw!(image::AbstractMatrix, shape::ThickLine, color)
    point1 = shape.point1
    point2 = shape.point2
    diameter = shape.diameter

    I = typeof(diameter)

    radius = diameter ÷ convert(I, 2)

    _draw!(image, Line(point1, point2), color) do image, i, j, color
        _draw!(image, FilledCircle(Point(i - radius, j - radius), diameter), color)
    end

    return nothing
end

function get_bounding_box(shape::ThickLine)
    point1 = shape.point1
    point2 = shape.point2
    diameter = shape.diameter

    i1 = point1.i
    j1 = point1.j
    i2 = point2.i
    j2 = point2.j

    I = typeof(i1)
    radius = diameter ÷ convert(I, 2)

    if i1 < i2
        i_min = i1 - radius
        i_diff = i2 - i1
    else
        i_min = i2 - radius
        i_diff = i1 - i2
    end

    if j1 < j2
        j_min = j1 - radius
        j_diff = j2 - j1
    else
        j_min = j2 - radius
        j_diff = j1 - j2
    end

    return Rectangle(Point(i_min, j_min), i_diff + diameter, j_diff + diameter)
end
