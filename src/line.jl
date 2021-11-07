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
    radius::I
end

function draw!(image::AbstractMatrix, shape::VerticalLine, color)
    i_min = shape.i_min
    i_max = shape.i_max
    j = shape.j

    i_min_image = firstindex(image, 1)
    i_max_image = lastindex(image, 1)

    j_min_image = firstindex(image, 2)
    j_max_image = lastindex(image, 2)

    if i_max < i_min_image || i_min > i_max_image || j < j_min_image || j > j_max_image
        return nothing
    else
        if i_min < i_min_image
            i_min = i_min_image
        end

        if i_max > i_max_image
            i_max = i_max_image
        end

        draw_unchecked!(image, VerticalLine(i_min, i_max, j), color)

        return nothing
    end
end

@inline function draw_unchecked!(image::AbstractMatrix, shape::VerticalLine, color)
    @inbounds image[shape.i_min:shape.i_max, shape.j] .= color
    return nothing
end

function draw!(image::AbstractMatrix, shape::HorizontalLine, color)
    i = shape.i
    j_min = shape.j_min
    j_max = shape.j_max

    i_min_image = firstindex(image, 1)
    i_max_image = lastindex(image, 1)

    j_min_image = firstindex(image, 2)
    j_max_image = lastindex(image, 2)

    if i < i_min_image || i > i_max_image || j_max < j_min_image || j_min > j_max_image
        return nothing
    else
        if j_min < j_min_image
            j_min = j_min_image
        end

        if j_max > j_max_image
            j_max = j_max_image
        end

        draw_unchecked!(image, HorizontalLine(i, j_min, j_max), color)

        return nothing
    end
end

@inline function draw_unchecked!(image::AbstractMatrix, shape::HorizontalLine, color)
    @inbounds image[shape.i, shape.j_min:shape.j_max] .= color
    return nothing
end

"""
Draw a line. Ref: https://en.wikipedia.org/wiki/Bresenham%27s_line_algorithm
"""
function draw!(image::AbstractMatrix, shape::Line, color)
    i1 = shape.point1.i
    j1 = shape.point1.j
    i2 = shape.point2.i
    j2 = shape.point2.j

    if i1 == i2
        j1, j2 = minmax(j1, j2)
        draw!(image, HorizontalLine(i1, j1, j2), color)
        return nothing
    elseif j1 == j2
        i1, i2 = minmax(i1, i2)
        draw!(image, VerticalLine(i1, i2, j1), color)
        return nothing
    end

    if checkbounds(Bool, image, i1, j1) && checkbounds(Bool, image, i2, j2)
        draw_unchecked!(image, shape, color)
        return nothing
    end

    di = abs(i2 - i1)
    dj = -abs(j2 - j1)
    si = i1 < i2 ? 1 : -1
    sj = j1 < j2 ? 1 : -1
    err = di + dj

    while true
        put_pixel!(image, i1, j1, color)

        if (i1 == i2 && j1 == j2)
            break
        end

        e2 = 2 * err

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

function draw_unchecked!(image::AbstractMatrix, shape::Line, color)
    i1 = shape.point1.i
    j1 = shape.point1.j
    i2 = shape.point2.i
    j2 = shape.point2.j

    di = abs(i2 - i1)
    dj = -abs(j2 - j1)
    si = i1 < i2 ? 1 : -1
    sj = j1 < j2 ? 1 : -1
    err = di + dj

    while true
        put_pixel_unchecked!(image, i1, j1, color)

        if (i1 == i2 && j1 == j2)
            break
        end

        e2 = 2 * err

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

function draw!(image::AbstractMatrix, shape::ThickLine, color)
    i1 = shape.point1.i
    j1 = shape.point1.j
    i2 = shape.point2.i
    j2 = shape.point2.j
    radius = shape.radius

    if checkbounds(Bool, image, i1 - radius, j1 - radius) && checkbounds(Bool, image, i1 + radius, j1 + radius) && checkbounds(Bool, image, i2 - radius, j2 - radius) && checkbounds(Bool, image, i2 + radius, j2 + radius)
        draw_unchecked!(image, shape, color)
        return nothing
    end

    di = abs(i2 - i1)
    dj = -abs(j2 - j1)
    si = i1 < i2 ? 1 : -1
    sj = j1 < j2 ? 1 : -1
    err = di + dj

    while true
        draw!(image, FilledCircle(Point(i1, j1), radius), color)

        if (i1 == i2 && j1 == j2)
            break
        end

        e2 = 2 * err

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

function draw_unchecked!(image::AbstractMatrix, shape::ThickLine, color)
    i1 = shape.point1.i
    j1 = shape.point1.j
    i2 = shape.point2.i
    j2 = shape.point2.j
    radius = shape.radius

    di = abs(i2 - i1)
    dj = -abs(j2 - j1)
    si = i1 < i2 ? 1 : -1
    sj = j1 < j2 ? 1 : -1
    err = di + dj

    while true
        draw_unchecked!(image, FilledCircle(Point(i1, j1), radius), color)

        if (i1 == i2 && j1 == j2)
            break
        end

        e2 = 2 * err

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
    radius = shape.radius
    radius2 = 2 * radius
    i1 = point1.i
    j1 = point1.j
    i2 = point2.i
    j2 = point2.j

    if i1 < i2
        i_min = i1 - radius
        height = i2 - i1 + one(I)
    else
        i_min = i2 - radius
        height = i1 - i2 + one(I)
    end

    if j1 < j2
        j_min = j1 - radius
        width = j2 - j1 + one(I)
    else
        j_min = j2 - radius
        width = j1 - j2 + one(I)
    end

    return Rectangle(Point(i_min, j_min), height + radius2, width + radius2)
end
