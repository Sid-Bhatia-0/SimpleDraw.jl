struct Point{I <: Integer} <: AbstractShape
    i::I
    j::I
end

@inline function draw!(image::AbstractMatrix, shape::Point, color)
    put_pixel!(image, shape.i, shape.j, color)
    return nothing
end

@inline function _draw!(image::AbstractMatrix, shape::Point, color)
    put_pixel_unchecked!(image, shape.i, shape.j, color)
    return nothing
end

get_bounding_box(shape::Point) = Rectangle(shape, one(shape.i), one(shape.i))
