struct Point{I <: Integer} <: AbstractShape
    i::I
    j::I
end

@inline function draw!(image::AbstractMatrix, shape::Point, color)
    put_pixel!(image, shape.i, shape.j, color)
    return nothing
end

@inline function draw_inbounds!(image::AbstractMatrix, shape::Point, color)
    put_pixel_inbounds!(image, shape.i, shape.j, color)
    return nothing
end
