struct Cross{I <: Integer} <: AbstractShape
    position::Point{I}
    diameter::I
end

struct HollowCross{I <: Integer} <: AbstractShape
    position::Point{I}
    diameter::I
end

#####
##### Cross
#####

is_valid(shape::Union{Cross, HollowCross}) = shape.diameter > convert(typeof(shape.diameter), 3)

function is_outbounds(shape::Union{Cross, HollowCross}, image::AbstractMatrix)
    position = shape.position
    diameter = shape.diameter

    one_value = one(shape.diameter)

    i_min = position.i
    j_min = position.j

    diameter_minus_1 = diameter - one_value
    i_max = i_min + diameter_minus_1
    j_max = j_min + diameter_minus_1

    i_min_image = firstindex(image, 1)
    i_max_image = lastindex(image, 1)

    j_min_image = firstindex(image, 2)
    j_max_image = lastindex(image, 2)

    return i_max < i_min_image || i_min > i_max_image || j_max < j_min_image || j_min > j_max_image
end

function draw!(image::AbstractMatrix, shape::Cross{I}, color) where {I}
    position = shape.position
    i_position = position.i
    j_position = position.j
    diameter = shape.diameter

    zero_value = zero(I)
    one_value = one(I)

    if !is_valid(shape)
        return nothing
    end

    if is_outbounds(shape, image)
        return nothing
    end

    if diameter == one_value
        draw!(image, position, color)
        return nothing
    end

    i_min = i_position
    j_min = j_position

    diameter_minus_1 = diameter - one_value
    i_max = i_position + diameter_minus_1
    j_max = j_position + diameter_minus_1

    radius = diameter ÷ 2
    i_center = i_position + radius
    j_center = j_position + radius

    draw!(image, HorizontalLine(i_center, j_min, j_max), color)
    draw!(image, VerticalLine(i_min, i_max, j_center), color)

    return nothing
end

function _draw!(image::AbstractMatrix, shape::Cross, color)
    position = shape.position
    i_position = position.i
    j_position = position.j
    diameter = shape.diameter

    radius = diameter ÷ 2
    i_center = i_position + radius
    j_center = j_position + radius

    _draw!(image, HorizontalLine(i_center, j_center - radius, j_center + radius), color)
    _draw!(image, VerticalLine(i_center - radius, i_center + radius, j_center), color)

    return nothing
end

#####
##### Cross
#####

function draw!(image::AbstractMatrix, shape::HollowCross{I}, color) where {I}
    position = shape.position
    i_position = position.i
    j_position = position.j
    diameter = shape.diameter

    zero_value = zero(I)
    one_value = one(I)

    if diameter < one_value
        return nothing
    end

    i_min = i_position
    j_min = j_position

    diameter_minus_1 = diameter - one_value
    i_max = i_position + diameter_minus_1
    j_max = j_position + diameter_minus_1

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

    radius = diameter ÷ 2
    i_center = i_position + radius
    j_center = j_position + radius

    draw!(image, HorizontalLine(i_center, j_min, j_center - one_value), color)
    draw!(image, VerticalLine(i_min, i_center - one_value, j_center), color)
    draw!(image, VerticalLine(i_center + one_value, i_max, j_center), color)
    draw!(image, HorizontalLine(i_center, j_center + one_value, j_max), color)

    return nothing
end

function draw_unchecked!(image::AbstractMatrix, shape::HollowCross{I}, color) where {I}
    position = shape.position
    i_position = position.i
    j_position = position.j
    diameter = shape.diameter
    radius = diameter ÷ 2
    i_center = i_position + radius
    j_center = j_position + radius

    one_value = one(I)

    i_min = i_position
    j_min = j_position

    diameter_minus_1 = diameter - one_value
    i_max = i_position + diameter_minus_1
    j_max = j_position + diameter_minus_1

    _draw!(image, HorizontalLine(i_center, j_min, j_center - one_value), color)
    _draw!(image, VerticalLine(i_min, i_center - one_value, j_center), color)
    _draw!(image, VerticalLine(i_center + one_value, i_max, j_center), color)
    _draw!(image, HorizontalLine(i_center, j_center + one_value, j_max), color)

    return nothing
end

get_bounding_box(shape::Cross) = Rectangle(shape.position, shape.diameter, shape.diameter)

get_bounding_box(shape::HollowCross) = get_bounding_box(Cross(shape.position, shape.diameter))
