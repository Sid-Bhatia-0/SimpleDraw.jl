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

function draw!(image::AbstractMatrix, shape::VerticalLine, color)
    i_min = shape.i_min
    i_max = shape.i_max
    j = shape.j

    if i_min > i_max
        return nothing
    end

    i_min_image = firstindex(image, 1)
    i_max_image = lastindex(image, 1)

    j_min_image = firstindex(image, 2)
    j_max_image = lastindex(image, 2)

    if i_max < i_min_image || i_min > i_max_image || j < j_min_image || j > j_max_image
        return nothing
    end

    if i_min == i_max
        draw!(image, Point(i_min, j), color)
        return nothing
    end

    if i_min < i_min_image
        i_min = i_min_image
    end

    if i_max > i_max_image
        i_max = i_max_image
    end

    draw_unchecked!(image, VerticalLine(i_min, i_max, j), color)

    return nothing
end

@inline function draw_unchecked!(image::AbstractMatrix, shape::VerticalLine, color)
    @inbounds image[shape.i_min:shape.i_max, shape.j] .= color
    return nothing
end

function draw!(image::AbstractMatrix, shape::HorizontalLine, color)
    if !is_valid(shape)
        return nothing
    end

    if is_outbounds(shape, image)
        return nothing
    end

    i = shape.i
    j_min = shape.j_min
    j_max = shape.j_max

    if j_min == j_max
        draw!(image, Point(i, j_min), color)
        return nothing
    end

    draw_unchecked!(image, clip(shape, image), color)

    return nothing
end

@inline function draw_unchecked!(image::AbstractMatrix, shape::HorizontalLine, color)
    @inbounds image[shape.i, shape.j_min:shape.j_max] .= color
    return nothing
end

"""
Draw a line. Ref: https://en.wikipedia.org/wiki/Bresenham%27s_line_algorithm
"""
function draw!(image::AbstractMatrix, shape::Line{I}, color) where {I}
    i1 = shape.point1.i
    j1 = shape.point1.j
    i2 = shape.point2.i
    j2 = shape.point2.j

    one_value = one(I)

    if j1 == j2
        i1, i2 = minmax(i1, i2)
        draw!(image, VerticalLine(i1, i2, j1), color)
        return nothing
    end

    if i1 == i2
        j1, j2 = minmax(j1, j2)
        draw!(image, HorizontalLine(i1, j1, j2), color)
        return nothing
    end

    if checkbounds(Bool, image, i1, j1) && checkbounds(Bool, image, i2, j2)
        draw_unchecked!(image, shape, color)
        return nothing
    end

    di = abs(i2 - i1)
    dj = -abs(j2 - j1)
    si = i1 < i2 ? one_value : -one_value
    sj = j1 < j2 ? one_value : -one_value
    err = di + dj

    while true
        put_pixel!(image, i1, j1, color)

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

function draw_unchecked!(image::AbstractMatrix, shape::Line{I}, color) where {I}
    i1 = shape.point1.i
    j1 = shape.point1.j
    i2 = shape.point2.i
    j2 = shape.point2.j

    one_value = one(I)

    di = abs(i2 - i1)
    dj = -abs(j2 - j1)
    si = i1 < i2 ? one_value : -one_value
    sj = j1 < j2 ? one_value : -one_value
    err = di + dj

    while true
        put_pixel_unchecked!(image, i1, j1, color)

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

function draw!(image::AbstractMatrix, shape::ThickLine{I}, color) where {I}
    i1 = shape.point1.i
    j1 = shape.point1.j
    i2 = shape.point2.i
    j2 = shape.point2.j
    diameter = shape.diameter
    radius = diameter ÷ 2

    one_value = one(I)

    if checkbounds(Bool, image, i1 - radius, j1 - radius) && checkbounds(Bool, image, i1 + radius - one_value, j1 + radius - one_value) && checkbounds(Bool, image, i2 - radius, j2 - radius) && checkbounds(Bool, image, i2 + radius - one_value, j2 + radius - one_value)
        draw_unchecked!(image, shape, color)
        return nothing
    end

    di = abs(i2 - i1)
    dj = -abs(j2 - j1)
    si = i1 < i2 ? one_value : -one_value
    sj = j1 < j2 ? one_value : -one_value
    err = di + dj

    while true
        draw!(image, FilledCircle(Point(i1 - radius, j1 - radius), diameter), color)

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

function draw_unchecked!(image::AbstractMatrix, shape::ThickLine{I}, color) where {I}
    i1 = shape.point1.i
    j1 = shape.point1.j
    i2 = shape.point2.i
    j2 = shape.point2.j
    diameter = shape.diameter
    radius = diameter ÷ 2

    one_value = one(I)

    di = abs(i2 - i1)
    dj = -abs(j2 - j1)
    si = i1 < i2 ? one_value : -one_value
    sj = j1 < j2 ? one_value : -one_value
    err = di + dj

    while true
        draw!(image, FilledCircle(Point(i1 - radius, j1 - radius), diameter), color)

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

get_bounding_box(shape::VerticalLine{I}) where {I} = Rectangle(Point(shape.i_min, shape.j), shape.i_max - shape.i_min + one(I), one(I))

get_bounding_box(shape::HorizontalLine{I}) where {I} = Rectangle(Point(shape.i, shape.j_min), one(I), shape.j_max - shape.j_min + one(I))

function get_bounding_box(shape::Line{I}) where {I}
    point1 = shape.point1
    point2 = shape.point2
    i1 = point1.i
    j1 = point1.j
    i2 = point2.i
    j2 = point2.j

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

function get_bounding_box(shape::ThickLine{I}) where {I}
    point1 = shape.point1
    point2 = shape.point2
    diameter = shape.diameter
    radius = diameter ÷ convert(I, 2)

    one_value = one(I)

    i1 = point1.i
    j1 = point1.j
    i2 = point2.i
    j2 = point2.j

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
