abstract type AbstractLine <: AbstractShape end

struct VerticalLine{I <: Integer} <: AbstractLine
    i_min::I
    i_max::I
    j::I
end

struct HorizontalLine{I <: Integer} <: AbstractLine
    i::I
    j_min::I
    j_max::I
end

struct Line{I <: Integer} <: AbstractLine
    point1::Point{I}
    point2::Point{I}
end

struct ThickLine{I <: Integer} <: AbstractLine
    point1::Point{I}
    point2::Point{I}
    diameter::I
end

#####
##### VerticalLine
#####

is_valid(shape::VerticalLine) = shape.i_min <= shape.i_max

get_i_min(shape::VerticalLine) = shape.i_min
get_i_max(shape::VerticalLine) = shape.i_max

get_j_min(shape::VerticalLine) = shape.j
get_j_max(shape::VerticalLine) = shape.j

clip(shape::VerticalLine, image::AbstractMatrix) = VerticalLine(max(get_i_min(shape), get_i_min(image)), min(get_i_max(shape), get_i_max(image)), shape.j)

function draw!(image::AbstractMatrix, shape::VerticalLine, color)
    @assert is_valid(shape) "Cannot draw invalid shape $(shape)"

    if is_outbounds(shape, image)
        return nothing
    end

    draw!(put_pixel_unchecked!, image, clip(shape, image), color)

    return nothing
end

function draw!(f::Function, image::AbstractMatrix, shape::VerticalLine, color)
    @assert is_valid(shape) "Cannot draw invalid shape $(shape)"

    i_min = shape.i_min
    i_max = shape.i_max
    j = shape.j

    for i in i_min:i_max
        f(image, i, j, color)
    end

    return nothing
end

get_bounding_box(shape::VerticalLine) = Rectangle(Point(shape.i_min, shape.j), shape.i_max - shape.i_min + one(shape.i_min), one(shape.i_min))

#####
##### HorizontalLine
#####

is_valid(shape::HorizontalLine) = shape.j_min <= shape.j_max

get_i_min(shape::HorizontalLine) = shape.i
get_i_max(shape::HorizontalLine) = shape.i

get_j_min(shape::HorizontalLine) = shape.j_min
get_j_max(shape::HorizontalLine) = shape.j_max

clip(shape::HorizontalLine, image::AbstractMatrix) = HorizontalLine(shape.i, max(get_j_min(shape), get_j_min(image)), min(get_j_max(shape), get_j_max(image)))

function draw!(image::AbstractMatrix, shape::HorizontalLine, color)
    @assert is_valid(shape) "Cannot draw invalid shape $(shape)"

    if is_outbounds(shape, image)
        return nothing
    end

    draw!(put_pixel_unchecked!, image, clip(shape, image), color)

    return nothing
end

function draw!(f::Function, image::AbstractMatrix, shape::HorizontalLine, color)
    @assert is_valid(shape) "Cannot draw invalid shape $(shape)"

    i = shape.i
    j_min = shape.j_min
    j_max = shape.j_max

    for j in j_min:j_max
        f(image, i, j, color)
    end

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
        draw!(put_pixel_unchecked!, image, shape, color)
    else
        draw!(put_pixel!, image, shape, color)
    end

    return nothing
end

function draw!(f::Function, image::AbstractMatrix, shape::Line, color)
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

    if is_inbounds(shape, image)
        draw!(put_pixel_unchecked!, image, shape, color)
    else
        draw!(put_pixel!, image, shape, color)
    end

    return nothing
end

function draw!(f::Function, image::AbstractMatrix, shape::ThickLine, color)
    @assert is_valid(shape) "Cannot draw invalid shape $(shape)"

    point1 = shape.point1
    point2 = shape.point2
    diameter = shape.diameter

    I = typeof(diameter)

    radius = diameter ÷ convert(I, 2)

    draw!(image, Line(point1, point2), color) do image, i, j, color
        draw!(f, image, FilledCircle(Point(i - radius, j - radius), diameter), color)
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
