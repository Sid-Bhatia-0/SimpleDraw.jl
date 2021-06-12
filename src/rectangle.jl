struct Rectangle{I <: Integer} <: AbstractShape
    i1::I
    j1::I
    i2::I
    j2::I
end

function draw!(image::AbstractMatrix, shape::Rectangle, color)
    i1 = shape.i1
    j1 = shape.j1
    i2 = shape.i2
    j2 = shape.j2

    image[i1:i2, j1] .= color
    image[i1:i2, j2] .= color
    image[i1, j1:j2] .= color
    image[i2, j1:j2] .= color

    return nothing
end
