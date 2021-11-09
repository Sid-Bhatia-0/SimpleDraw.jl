struct Rectangle{I <: Integer} <: AbstractShape
    origin::Point{I}
    height::I
    width::I
end

struct ThickRectangle{I <: Integer} <: AbstractShape
    origin::Point{I}
    height::I
    width::I
    thickness::I
end

struct FilledRectangle{I <: Integer} <: AbstractShape
    origin::Point{I}
    height::I
    width::I
end

function draw!(image::AbstractMatrix, shape::Rectangle, color)
    i_min = shape.origin.i
    j_min = shape.origin.j
    i_max = i_min + shape.height - 1
    j_max = j_min + shape.width - 1

    if checkbounds(Bool, image, i_min, j_min) && checkbounds(Bool, image, i_max, j_max)
        draw_unchecked!(image, shape, color)
        return nothing
    end

    draw!(image, VerticalLine(i_min, i_max, j_min), color)
    draw!(image, HorizontalLine(i_min, j_min, j_max), color)
    draw!(image, HorizontalLine(i_max, j_min, j_max), color)
    draw!(image, VerticalLine(i_min, i_max, j_max), color)

    return nothing
end

function draw_unchecked!(image::AbstractMatrix, shape::Rectangle, color)
    i_min = shape.origin.i
    j_min = shape.origin.j
    i_max = i_min + shape.height - 1
    j_max = j_min + shape.width - 1

    draw_unchecked!(image, VerticalLine(i_min, i_max, j_min), color)
    draw_unchecked!(image, HorizontalLine(i_min, j_min, j_max), color)
    draw_unchecked!(image, HorizontalLine(i_max, j_min, j_max), color)
    draw_unchecked!(image, VerticalLine(i_min, i_max, j_max), color)

    return nothing
end

function draw!(image::AbstractMatrix, shape::ThickRectangle, color)
    origin = shape.origin
    height = shape.height
    width = shape.width
    thickness = shape.thickness

    i_min = origin.i
    j_min = origin.j
    i_max = i_min + height - 1
    j_max = j_min + width - 1

    if checkbounds(Bool, image, i_min, j_min) && checkbounds(Bool, image, i_max, j_max)
        draw_unchecked!(image, shape, color)
        return nothing
    end

    draw!(image, FilledRectangle(origin, height, thickness), color)
    draw!(image, FilledRectangle(Point(i_min, j_min + thickness), thickness, width - 2 * thickness), color)
    draw!(image, FilledRectangle(Point(i_min + height - thickness, j_min + thickness), thickness, width - 2 * thickness), color)
    draw!(image, FilledRectangle(Point(i_min, j_min + width - thickness), height, thickness), color)

    return nothing
end

function draw_unchecked!(image::AbstractMatrix, shape::ThickRectangle, color)
    origin = shape.origin
    height = shape.height
    width = shape.width
    thickness = shape.thickness
    i_min = origin.i
    j_min = origin.j
    i_max = i_min + height - 1
    j_max = j_min + width - 1

    draw_unchecked!(image, FilledRectangle(origin, height, thickness), color)
    draw_unchecked!(image, FilledRectangle(Point(i_min, j_min + thickness), thickness, width - 2 * thickness), color)
    draw_unchecked!(image, FilledRectangle(Point(i_min + height - thickness, j_min + thickness), thickness, width - 2 * thickness), color)
    draw_unchecked!(image, FilledRectangle(Point(i_min, j_min + width - thickness), height, thickness), color)

    return nothing
end

function draw!(image::AbstractMatrix, shape::FilledRectangle, color)
    i_min = shape.origin.i
    j_min = shape.origin.j
    i_max = i_min + shape.height - 1
    j_max = j_min + shape.width - 1

    i_min_image = firstindex(image, 1)
    i_max_image = lastindex(image, 1)

    j_min_image = firstindex(image, 2)
    j_max_image = lastindex(image, 2)

    if i_min > i_max_image
        return nothing
    elseif i_min < i_min_image
        i_min = i_min_image
    end

    if i_max < i_min_image
        return nothing
    elseif i_max > i_max_image
        i_max = i_max_image
    end

    if j_min > j_max_image
        return nothing
    elseif j_min < j_min_image
        j_min = j_min_image
    end

    if j_max < j_min_image
        return nothing
    elseif j_max > j_max_image
        j_max = j_max_image
    end

    @inbounds image[i_min:i_max, j_min:j_max] .= color

    return nothing
end

function draw_unchecked!(image::AbstractMatrix, shape::FilledRectangle, color)
    i_min = shape.origin.i
    j_min = shape.origin.j
    i_max = i_min + shape.height - 1
    j_max = j_min + shape.width - 1

    @inbounds image[i_min:i_max, j_min:j_max] .= color

    return nothing
end

get_bounding_box(shape::Rectangle) = shape
get_bounding_box(shape::ThickRectangle) = Rectangle(shape.origin, shape.height, shape.width)
get_bounding_box(shape::FilledRectangle) = Rectangle(shape.origin, shape.height, shape.width)
