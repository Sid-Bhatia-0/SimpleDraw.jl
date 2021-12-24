struct Point{I <: Integer} <: AbstractShape
    i::I
    j::I
end

draw!(image::AbstractMatrix, shape::Point, color) = draw!(put_pixel!, image, shape, color)

function draw!(f::Function, image::AbstractMatrix, shape::Point, color)
    f(image, shape.i, shape.j, color)
    return nothing
end

get_i_min(shape::Point) = shape.i
get_i_max(shape::Point) = shape.i

get_j_min(shape::Point) = shape.j
get_j_max(shape::Point) = shape.j
