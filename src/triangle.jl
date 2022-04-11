abstract type AbstractTriangle <: AbstractShape end

struct VerticalBaseTriangle{I <: Integer} <: AbstractTriangle
    vertical_line::VerticalLine{I}
    point::Point{I}
end

is_valid(shape::VerticalBaseTriangle) = is_valid(shape.vertical_line)

get_i_min(shape::VerticalBaseTriangle) = min(shape.vertical_line.i_min, shape.point.i)
get_i_max(shape::VerticalBaseTriangle) = max(shape.vertical_line.i_max, shape.point.i)

get_j_min(shape::VerticalBaseTriangle) = min(shape.vertical_line.j, shape.point.j)
get_j_max(shape::VerticalBaseTriangle) = max(shape.vertical_line.j, shape.point.j)

get_drawing_optimization_style(::VerticalBaseTriangle) = CHECK_BOUNDS

function draw!(f::F, image::AbstractMatrix, shape::VerticalBaseTriangle, color) where {F <: Function}
    @assert is_valid(shape) "Cannot draw invalid shape $(shape)"

    i1 = shape.vertical_line.i_min
    i3 = shape.vertical_line.i_max
    i2 = shape.point.i
    j2 = shape.point.j
    j = shape.vertical_line.j

    point1 = Point(i1, j)
    point2 = shape.point
    point3 = Point(i3, j)

    I = typeof(i1)

    di1 = abs(i2 - i1)
    di3 = abs(i2 - i3)
    dj = -abs(j2 - j)

    si1 = i1 < i2 ? one(I) : -one(I)
    si3 = i3 < i2 ? one(I) : -one(I)
    sj = j < j2 ? one(I) : -one(I)

    err1 = di1 + dj
    err3 = di3 + dj

    should_increment_j1 = false
    should_increment_j3 = false

    while true
        draw!(f, image, VerticalLine(i1, i3, j), color)

        while true
            if (i1 == i2 && j == j2)
                break
            end

            e1 = convert(I, 2) * err1

            if (e1 >= dj)
                err1 += dj
                i1 += si1
            end

            if (e1 <= di1)
                should_increment_j1 = true
                break
            end
        end

        while true
            if (i3 == i2 && j == j2)
                break
            end

            e3 = convert(I, 2) * err3

            if (e3 >= dj)
                err3 += dj
                i3 += si3
            end

            if (e3 <= di3)
                should_increment_j3 = true
                break
            end
        end

        if should_increment_j1 && should_increment_j3
            err1 += di1
            err3 += di3
            j += sj
            should_increment_j1 = false
            should_increment_j3 = false
        end

        if (i1 == i2 && j == j2)
            break
        end
    end

    draw!(f, image, Line(point3, point2), color)

    return nothing
end
