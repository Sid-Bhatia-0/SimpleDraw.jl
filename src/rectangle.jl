mutable struct Rectangle{I <: Integer} <: AbstractShape
    top_left::Point{I}
    height::I
    width::I
end

mutable struct ThickRectangle{I <: Integer} <: AbstractShape
    top_left::Point{I}
    height::I
    width::I
    thickness::I
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

    if checkbounds(Bool, image, i_top_left, j_top_left) && checkbounds(Bool, image, i_bottom_right, j_bottom_right)
        draw_inbounds!(image, shape, color)
        return nothing
    end

    draw!(image, VerticalLine(i_top_left, i_bottom_right, j_top_left), color)
    draw!(image, HorizontalLine(i_top_left, j_top_left, j_bottom_right), color)
    draw!(image, HorizontalLine(i_bottom_right, j_top_left, j_bottom_right), color)
    draw!(image, VerticalLine(i_top_left, i_bottom_right, j_bottom_right), color)

    return nothing
end

function draw_inbounds!(image::AbstractMatrix, shape::Rectangle, color)
    i_top_left = shape.top_left.i
    j_top_left = shape.top_left.j
    i_bottom_right = i_top_left + shape.height - 1
    j_bottom_right = j_top_left + shape.width - 1

    draw_inbounds!(image, VerticalLine(i_top_left, i_bottom_right, j_top_left), color)
    draw_inbounds!(image, HorizontalLine(i_top_left, j_top_left, j_bottom_right), color)
    draw_inbounds!(image, HorizontalLine(i_bottom_right, j_top_left, j_bottom_right), color)
    draw_inbounds!(image, VerticalLine(i_top_left, i_bottom_right, j_bottom_right), color)

    return nothing
end

function draw!(image::AbstractMatrix, shape::ThickRectangle, color)
    top_left = shape.top_left
    height = shape.height
    width = shape.width
    thickness = shape.thickness
    i_top_left = top_left.i
    j_top_left = top_left.j
    i_bottom_right = i_top_left + height - 1
    j_bottom_right = j_top_left + width - 1

    draw!(image, FilledRectangle(top_left, height, thickness), color)
    draw!(image, FilledRectangle(Point(i_top_left, j_top_left + thickness), thickness, width - 2 * thickness), color)
    draw!(image, FilledRectangle(Point(i_top_left + height - thickness, j_top_left + thickness), thickness, width - 2 * thickness), color)
    draw!(image, FilledRectangle(Point(i_top_left, j_top_left + width - thickness), height, thickness), color)

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
