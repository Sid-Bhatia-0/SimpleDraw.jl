mutable struct Point{I <: Integer} <: AbstractShape
    i::I
    j::I
end

function draw!(image::AbstractMatrix, shape::Point, color)
    put_pixel!(image, shape.i, shape.j, color)
    return nothing
end
