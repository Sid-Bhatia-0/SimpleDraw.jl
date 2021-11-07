struct Rectangle{I <: Integer} <: AbstractShape
    top_left::Point{I}
    height::I
    width::I
end

struct ThickRectangle{I <: Integer} <: AbstractShape
    top_left::Point{I}
    height::I
    width::I
    thickness::I
end

struct FilledRectangle{I <: Integer} <: AbstractShape
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
        draw_unchecked!(image, shape, color)
        return nothing
    end

    draw!(image, VerticalLine(i_top_left, i_bottom_right, j_top_left), color)
    draw!(image, HorizontalLine(i_top_left, j_top_left, j_bottom_right), color)
    draw!(image, HorizontalLine(i_bottom_right, j_top_left, j_bottom_right), color)
    draw!(image, VerticalLine(i_top_left, i_bottom_right, j_bottom_right), color)

    return nothing
end

function draw_unchecked!(image::AbstractMatrix, shape::Rectangle, color)
    i_top_left = shape.top_left.i
    j_top_left = shape.top_left.j
    i_bottom_right = i_top_left + shape.height - 1
    j_bottom_right = j_top_left + shape.width - 1

    draw_unchecked!(image, VerticalLine(i_top_left, i_bottom_right, j_top_left), color)
    draw_unchecked!(image, HorizontalLine(i_top_left, j_top_left, j_bottom_right), color)
    draw_unchecked!(image, HorizontalLine(i_bottom_right, j_top_left, j_bottom_right), color)
    draw_unchecked!(image, VerticalLine(i_top_left, i_bottom_right, j_bottom_right), color)

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

    if checkbounds(Bool, image, i_top_left, j_top_left) && checkbounds(Bool, image, i_bottom_right, j_bottom_right)
        draw_unchecked!(image, shape, color)
        return nothing
    end

    draw!(image, FilledRectangle(top_left, height, thickness), color)
    draw!(image, FilledRectangle(Point(i_top_left, j_top_left + thickness), thickness, width - 2 * thickness), color)
    draw!(image, FilledRectangle(Point(i_top_left + height - thickness, j_top_left + thickness), thickness, width - 2 * thickness), color)
    draw!(image, FilledRectangle(Point(i_top_left, j_top_left + width - thickness), height, thickness), color)

    return nothing
end

function draw_unchecked!(image::AbstractMatrix, shape::ThickRectangle, color)
    top_left = shape.top_left
    height = shape.height
    width = shape.width
    thickness = shape.thickness
    i_top_left = top_left.i
    j_top_left = top_left.j
    i_bottom_right = i_top_left + height - 1
    j_bottom_right = j_top_left + width - 1

    draw_unchecked!(image, FilledRectangle(top_left, height, thickness), color)
    draw_unchecked!(image, FilledRectangle(Point(i_top_left, j_top_left + thickness), thickness, width - 2 * thickness), color)
    draw_unchecked!(image, FilledRectangle(Point(i_top_left + height - thickness, j_top_left + thickness), thickness, width - 2 * thickness), color)
    draw_unchecked!(image, FilledRectangle(Point(i_top_left, j_top_left + width - thickness), height, thickness), color)

    return nothing
end

function draw!(image::AbstractMatrix, shape::FilledRectangle, color)
    i_top_left = shape.top_left.i
    j_top_left = shape.top_left.j
    i_bottom_right = i_top_left + shape.height - 1
    j_bottom_right = j_top_left + shape.width - 1

    i_min_image = firstindex(image, 1)
    i_max_image = lastindex(image, 1)

    j_min_image = firstindex(image, 2)
    j_max_image = lastindex(image, 2)

    if i_top_left > i_max_image
        return nothing
    elseif i_top_left < i_min_image
        i_top_left = i_min_image
    end

    if i_bottom_right < i_min_image
        return nothing
    elseif i_bottom_right > i_max_image
        i_bottom_right = i_max_image
    end

    if j_top_left > j_max_image
        return nothing
    elseif j_top_left < j_min_image
        j_top_left = j_min_image
    end

    if j_bottom_right < j_min_image
        return nothing
    elseif j_bottom_right > j_max_image
        j_bottom_right = j_max_image
    end

    @inbounds image[i_top_left:i_bottom_right, j_top_left:j_bottom_right] .= color

    return nothing
end

function draw_unchecked!(image::AbstractMatrix, shape::FilledRectangle, color)
    i_top_left = shape.top_left.i
    j_top_left = shape.top_left.j
    i_bottom_right = i_top_left + shape.height - 1
    j_bottom_right = j_top_left + shape.width - 1

    @inbounds image[i_top_left:i_bottom_right, j_top_left:j_bottom_right] .= color

    return nothing
end

get_bounding_box(shape::Rectangle) = shape
get_bounding_box(shape::ThickRectangle) = Rectangle(shape.top_left, shape.height, shape.width)
get_bounding_box(shape::FilledRectangle) = Rectangle(shape.top_left, shape.height, shape.width)
