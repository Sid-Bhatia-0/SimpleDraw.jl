mutable struct Rectangle{I <: Integer} <: AbstractShape
    top_left::Point{I}
    height::I
    width::I
end

mutable struct FilledRectangle{I <: Integer} <: AbstractShape
    top_left::Point{I}
    height::I
    width::I
end

function draw!(image::AbstractMatrix, shape::Rectangle, color)
    i_top_left = shape.top_left.i
    j_top_left = shape.top_left.j
    i_bottom_right = i_top_left + shape.height - 1
    j_bottom_right = j_top_left + shape.width - 1

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

function draw!(image::AbstractMatrix, shape::FilledRectangle, color)
    i_top_left = shape.top_left.i
    j_top_left = shape.top_left.j
    i_bottom_right = i_top_left + shape.height - 1
    j_bottom_right = j_top_left + shape.width - 1

    for j in j_top_left:j_bottom_right
        for i in i_top_left:i_bottom_right
            put_pixel!(image, i, j, color)
        end
    end

    return nothing
end
