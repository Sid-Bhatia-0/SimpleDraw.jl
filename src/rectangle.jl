struct Rectangle{I <: Integer} <: AbstractShape
    i_top_left::I
    j_top_left::I
    height::I
    width::I
end

struct FilledRectangle{I <: Integer} <: AbstractShape
    i_top_left::I
    j_top_left::I
    height::I
    width::I
end

function draw!(image::AbstractMatrix, shape::Rectangle, color)
    i_top_left = shape.i_top_left
    j_top_left = shape.j_top_left
    i_bottom_right = i_top_left + shape.height - 1
    j_bottom_right = j_top_left + shape.width - 1

    image[i_top_left:i_bottom_right, j_top_left] .= color
    image[i_top_left:i_bottom_right, j_bottom_right] .= color
    image[i_top_left, j_top_left:j_bottom_right] .= color
    image[i_bottom_right, j_top_left:j_bottom_right] .= color

    return nothing
end

function draw!(image::AbstractMatrix, shape::FilledRectangle, color)
    i_top_left = shape.i_top_left
    j_top_left = shape.j_top_left
    i_bottom_right = i_top_left + shape.height - 1
    j_bottom_right = j_top_left + shape.width - 1

    image[i_top_left:i_bottom_right, j_top_left:j_bottom_right] .= color

    return nothing
end
