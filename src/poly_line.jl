mutable struct PolyLine{I <: Integer} <: AbstractShape
    points::Vector{Point{I}}
end

function draw!(image::AbstractMatrix, shape::PolyLine, color)
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
