struct Point{I <: Integer} <: AbstractShape
    i::I
    j::I
end

draw!(image::AbstractMatrix, shape::Point, color) = draw!(put_pixel!, image, shape, color)

function draw!(f::Function, image::AbstractMatrix, shape::Point, color)
    f(image, shape.i, shape.j, color)
    return nothing
end
