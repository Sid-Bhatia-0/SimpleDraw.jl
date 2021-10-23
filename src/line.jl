mutable struct VerticalLine{I <: Integer} <: AbstractShape
    i_start::I
    i_end::I
    j::I
end

mutable struct HorizontalLine{I <: Integer} <: AbstractShape
    i::I
    j_start::I
    j_end::I
end

mutable struct Line{I <: Integer} <: AbstractShape
    point1::Point{I}
    point2::Point{I}
end

mutable struct ThickLine{I <: Integer} <: AbstractShape
    point1::Point{I}
    point2::Point{I}
    brush_radius::I
end

function draw!(image::AbstractMatrix, shape::VerticalLine, color)
    i_start = shape.i_start
    i_end = shape.i_end
    j = shape.j

    i_low = firstindex(image, 1)
    i_high = lastindex(image, 1)

    j_low = firstindex(image, 2)
    j_high = lastindex(image, 2)

    if i_end < i_low || i_start > i_high || j < j_low || j > j_high
        return nothing
    else
        if i_start < i_low
            i_start = i_low
        end

        if i_end > i_high
            i_end = i_high
        end

        draw_inbounds!(image, VerticalLine(i_start, i_end, j), color)

        return nothing
    end
end

@inline function draw_inbounds!(image::AbstractMatrix, shape::VerticalLine, color)
    @inbounds image[shape.i_start:shape.i_end, shape.j] .= color
    return nothing
end

function draw!(image::AbstractMatrix, shape::HorizontalLine, color)
    i = shape.i
    j_start = shape.j_start
    j_end = shape.j_end

    i_low = firstindex(image, 1)
    i_high = lastindex(image, 1)

    j_low = firstindex(image, 2)
    j_high = lastindex(image, 2)

    if i < i_low || i > i_high || j_end < j_low || j_start > j_high
        return nothing
    else
        if j_start < j_low
            j_start = j_low
        end

        if j_end > j_high
            j_end = j_high
        end

        image[i, j_start:j_end] .= color

        return nothing
    end
end

"""
Draw a line. Ref: https://en.wikipedia.org/wiki/Bresenham%27s_line_algorithm
"""
function draw!(image::AbstractMatrix, shape::Line, color)
    i1 = shape.point1.i
    j1 = shape.point1.j
    i2 = shape.point2.i
    j2 = shape.point2.j

    if checkbounds(Bool, image, i1, j1) && checkbounds(Bool, image, i2, j2)
        draw_inbounds!(image, shape, color)
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

function draw_inbounds!(image::AbstractMatrix, shape::Line, color)
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
        put_pixel_inbounds!(image, i1, j1, color)

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
    low_i = firstindex(image, 1)
    high_i = lastindex(image, 1)
    low_j = firstindex(image, 2)
    high_j = lastindex(image, 2)

    i1 = clamp(shape.point1.i, low_i, high_i)
    j1 = clamp(shape.point1.j, low_j, high_j)
    i2 = clamp(shape.point2.i, low_i, high_i)
    j2 = clamp(shape.point2.j, low_j, high_j)
    brush_radius = shape.brush_radius

    di = abs(i2 - i1)
    dj = -abs(j2 - j1)
    si = i1 < i2 ? 1 : -1
    sj = j1 < j2 ? 1 : -1
    err = di + dj

    while true
        draw!(image, FilledCircle(Point(i1, j1), brush_radius), color)
        # image[i1, j1] = color

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
