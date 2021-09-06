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

    for i in i_top_left:i_bottom_right
        put_pixel!(image, i, j_top_left, color)
    end

    for i in i_top_left:i_bottom_right
        put_pixel!(image, i, j_bottom_right, color)
    end

    for j in j_top_left:j_bottom_right
        put_pixel!(image, i_top_left, j, color)
    end

    for j in j_top_left:j_bottom_right
        put_pixel!(image, i_bottom_right, j, color)
    end

    return nothing
end

function draw!(image::AbstractMatrix, drawable::FilledRectangle)
    i_top_left = drawable.i_top_left
    j_top_left = drawable.j_top_left
    i_bottom_right = i_top_left + drawable.height - 1
    j_bottom_right = j_top_left + drawable.width - 1
    color = drawable.color

    for j in j_top_left:j_bottom_right
        for i in i_top_left:i_bottom_right
            put_pixel!(image, i, j, color)
        end
    end

    return nothing
end
