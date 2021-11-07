struct Polyline{I <: Integer} <: AbstractShape
    points::Vector{Point{I}}
end

function draw!(image::AbstractMatrix, shape::Polyline, color)
    points = shape.points
    num_points = length(points)

    if num_points == 0
        return nothing
    elseif num_points == 1
        draw!(image, first(points), color)
        return nothing
    else
        for i in 1 : num_points - 1
            draw!(image, Line(points[i], points[i + 1]), color)
        end

        return nothing
    end
end

function draw_inbounds!(image::AbstractMatrix, shape::Polyline, color)
    points = shape.points
    num_points = length(points)

    if num_points == 0
        return nothing
    elseif num_points == 1
        draw_inbounds!(image, first(points), color)
        return nothing
    else
        for i in 1 : num_points - 1
            draw_inbounds!(image, Line(points[i], points[i + 1]), color)
        end

        return nothing
    end
end

function get_bounding_box(shape::Polyline{I}) where {I}
    points = shape.points
    num_points = length(points)

    @assert num_points > 0

    first_point = first(points)

    if num_points == 1
        return get_bounding_box(first_point)
    else
        i_min = first_point.i
        j_min = first_point.j
        i_max = first_point.i
        j_max = first_point.j

        for k in 2 : num_points
            point = points[k]
            i = point.i
            j = point.j

            if i < i_min
                i_min = i
            elseif i > i_max
                i_max = i
            end

            if j < j_min
                j_min = j
            elseif j > j_max
                j_max = j
            end
        end

        return Rectangle(Point(i_min, j_min), i_max - i_min + one(I), j_max - j_min + one(I))
    end
end
