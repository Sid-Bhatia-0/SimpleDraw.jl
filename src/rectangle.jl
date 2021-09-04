mutable struct Rectangle{I <: Integer, C} <: AbstractDrawable
    i_top_left::I
    j_top_left::I
    height::I
    width::I
    color::C
end

mutable struct FilledRectangle{I <: Integer, C} <: AbstractDrawable
    i_top_left::I
    j_top_left::I
    height::I
    width::I
    color::C
end

function draw!(image::AbstractMatrix, drawable::Rectangle)
    i_top_left = drawable.i_top_left
    j_top_left = drawable.j_top_left
    i_bottom_right = i_top_left + drawable.height - 1
    j_bottom_right = j_top_left + drawable.width - 1
    color = drawable.color

    image[i_top_left:i_bottom_right, j_top_left] .= color
    image[i_top_left:i_bottom_right, j_bottom_right] .= color
    image[i_top_left, j_top_left:j_bottom_right] .= color
    image[i_bottom_right, j_top_left:j_bottom_right] .= color

    return nothing
end

function draw!(image::AbstractMatrix, drawable::FilledRectangle)
    i_top_left = drawable.i_top_left
    j_top_left = drawable.j_top_left
    i_bottom_right = i_top_left + drawable.height - 1
    j_bottom_right = j_top_left + drawable.width - 1
    color = drawable.color

    image[i_top_left:i_bottom_right, j_top_left:j_bottom_right] .= color

    return nothing
end
