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

function draw!(image::AbstractMatrix, shape::Rectangle{I}, color) where {I}
    origin = shape.origin
    height = shape.height
    width = shape.width

    one_value = one(I)

    if height < one_value || width < one_value
        return nothing
    end

    i_min = origin.i
    j_min = origin.j

    i_max = i_min + height - one_value
    j_max = j_min + width - one_value

    i_min_image = firstindex(image, 1)
    i_max_image = lastindex(image, 1)

    j_min_image = firstindex(image, 2)
    j_max_image = lastindex(image, 2)

    if i_max < i_min_image || i_min > i_max_image || j_max < j_min_image || j_min > j_max_image
        return nothing
    end

    if i_min >= i_min_image && j_min >= j_min_image && i_max <= i_max_image && j_max <= j_max_image
        draw_unchecked!(image, shape, color)
        return nothing
    end

    j_min_plus_1 = j_min + one_value
    j_max_minus_1 = j_max - one_value

    draw!(image, VerticalLine(i_min, i_max, j_min), color)
    draw!(image, HorizontalLine(i_min, j_min_plus_1, j_max_minus_1), color)
    draw!(image, HorizontalLine(i_max, j_min_plus_1, j_max_minus_1), color)
    draw!(image, VerticalLine(i_min, i_max, j_max), color)

    return nothing
end

function draw_unchecked!(image::AbstractMatrix, shape::Rectangle{I}, color) where {I}
    origin = shape.origin
    height = shape.height
    width = shape.width

    one_value = one(I)

    i_min = origin.i
    j_min = origin.j

    i_max = i_min + height - one_value
    j_max = j_min + width - one_value

    j_min_plus_1 = j_min + one_value
    j_max_minus_1 = j_max - one_value

    draw_unchecked!(image, VerticalLine(i_min, i_max, j_min), color)
    draw_unchecked!(image, HorizontalLine(i_min, j_min_plus_1, j_max_minus_1), color)
    draw_unchecked!(image, HorizontalLine(i_max, j_min_plus_1, j_max_minus_1), color)
    draw_unchecked!(image, VerticalLine(i_min, i_max, j_max), color)

    return nothing
end

function draw!(image::AbstractMatrix, shape::ThickRectangle{I}, color) where {I}
    origin = shape.origin
    height = shape.height
    width = shape.width
    thickness = shape.thickness

    one_value = one(I)

    if height < one_value || width < one_value || thickness < one_value
        return nothing
    end

    i_min = origin.i
    j_min = origin.j

    i_max = i_min + height - one_value
    j_max = j_min + width - one_value

    i_min_image = firstindex(image, 1)
    i_max_image = lastindex(image, 1)

    j_min_image = firstindex(image, 2)
    j_max_image = lastindex(image, 2)

    if i_max < i_min_image || i_min > i_max_image || j_max < j_min_image || j_min > j_max_image
        return nothing
    end

    if i_min >= i_min_image && j_min >= j_min_image && i_max <= i_max_image && j_max <= j_max_image
        draw_unchecked!(image, shape, color)
        return nothing
    end

    j_min_plus_thickness = j_min + thickness
    width_minus_twice_thickness = width - convert(I, 2) * thickness

    draw!(image, FilledRectangle(origin, height, thickness), color)
    draw!(image, FilledRectangle(Point(i_min, j_min_plus_thickness), thickness, width_minus_twice_thickness), color)
    draw!(image, FilledRectangle(Point(i_min + height - thickness, j_min_plus_thickness), thickness, width_minus_twice_thickness), color)
    draw!(image, FilledRectangle(Point(i_min, j_min + width - thickness), height, thickness), color)

    return nothing
end

function draw_unchecked!(image::AbstractMatrix, shape::ThickRectangle{I}, color) where {I}
    origin = shape.origin
    height = shape.height
    width = shape.width
    thickness = shape.thickness

    one_value = one(I)

    i_min = origin.i
    j_min = origin.j

    i_max = i_min + height - one_value
    j_max = j_min + width - one_value

    j_min_plus_thickness = j_min + thickness
    width_minus_twice_thickness = width - convert(I, 2) * thickness

    draw_unchecked!(image, FilledRectangle(origin, height, thickness), color)
    draw_unchecked!(image, FilledRectangle(Point(i_min, j_min_plus_thickness), thickness, width_minus_twice_thickness), color)
    draw_unchecked!(image, FilledRectangle(Point(i_min + height - thickness, j_min_plus_thickness), thickness, width_minus_twice_thickness), color)
    draw_unchecked!(image, FilledRectangle(Point(i_min, j_min + width - thickness), height, thickness), color)

    return nothing
end

function draw!(image::AbstractMatrix, shape::FilledRectangle{I}, color) where {I}
    origin = shape.origin
    height = shape.height
    width = shape.width

    one_value = one(I)

    if height < one_value || width < one_value
        return nothing
    end

    i_min = origin.i
    j_min = origin.j

    i_max = i_min + height - one_value
    j_max = j_min + width - one_value

    i_min_image = firstindex(image, 1)
    i_max_image = lastindex(image, 1)

    j_min_image = firstindex(image, 2)
    j_max_image = lastindex(image, 2)

    if i_max < i_min_image || i_min > i_max_image || j_max < j_min_image || j_min > j_max_image
        return nothing
    end

    if i_min < i_min_image
        i_min = i_min_image
    end

    if i_max > i_max_image
        i_max = i_max_image
    end

    if j_min < j_min_image
        j_min = j_min_image
    end

    if j_max > j_max_image
        j_max = j_max_image
    end

    @inbounds image[i_min:i_max, j_min:j_max] .= color

    return nothing
end

function draw_unchecked!(image::AbstractMatrix, shape::FilledRectangle{I}, color) where {I}
    origin = shape.origin
    height = shape.height
    width = shape.width

    one_value = one(I)

    i_min = origin.i
    j_min = origin.j

    i_max = i_min + height - one_value
    j_max = j_min + width - one_value

    @inbounds image[i_min:i_max, j_min:j_max] .= color

    return nothing
end

get_bounding_box(shape::Rectangle) = shape
get_bounding_box(shape::ThickRectangle) = Rectangle(shape.origin, shape.height, shape.width)
get_bounding_box(shape::FilledRectangle) = Rectangle(shape.origin, shape.height, shape.width)
