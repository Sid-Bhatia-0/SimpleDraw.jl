struct Point{I <: Integer} <: AbstractShape
    i::I
    j::I
end

draw!(image::AbstractMatrix, shape::Point, color) = _draw!(put_pixel!, image, shape, color)

function _draw!(f::Function, image::AbstractMatrix, shape::Point, color)
    f(image, shape.i, shape.j, color)
    return nothing
end

get_bounding_box(shape::Point) = Rectangle(shape, one(shape.i), one(shape.i))
