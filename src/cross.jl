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

    I = typeof(diameter)
    one_value = one(I)

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

function draw!(image::AbstractMatrix, shape::Cross, color)
    position = shape.position
    i_position = position.i
    j_position = position.j
    diameter = shape.diameter

    I = typeof(i_position)
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

    radius = diameter ÷ convert(I, 2)
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

    I = typeof(i_position)
    radius = diameter ÷ convert(I, 2)
    i_center = i_position + radius
    j_center = j_position + radius

    _draw!(image, HorizontalLine(i_center, j_center - radius, j_center + radius), color)
    _draw!(image, VerticalLine(i_center - radius, i_center + radius, j_center), color)

    return nothing
end

get_bounding_box(shape::Union{Cross, HollowCross}) = Rectangle(shape.position, shape.diameter, shape.diameter)

#####
##### HollowCross
#####

function draw!(image::AbstractMatrix, shape::HollowCross, color)
    position = shape.position
    i_position = position.i
    j_position = position.j
    diameter = shape.diameter

    I = typeof(i_position)
    zero_value = zero(I)
    one_value = one(I)

    if !is_valid(shape)
        return nothing
    end

    if is_outbounds(shape, image)
        return nothing
    end

    i_min = i_position
    j_min = j_position

    diameter_minus_1 = diameter - one_value
    i_max = i_min + diameter_minus_1
    j_max = j_min + diameter_minus_1

    radius = diameter ÷ convert(I, 2)
    i_center = i_min + radius
    j_center = j_min + radius

    draw!(image, HorizontalLine(i_center, j_min, j_center - one_value), color)
    draw!(image, VerticalLine(i_min, i_center - one_value, j_center), color)
    draw!(image, VerticalLine(i_center + one_value, i_max, j_center), color)
    draw!(image, HorizontalLine(i_center, j_center + one_value, j_max), color)

    return nothing
end

function _draw!(image::AbstractMatrix, shape::HollowCross, color)
    position = shape.position
    i_position = position.i
    j_position = position.j
    diameter = shape.diameter

    I = typeof(i_position)
    radius = diameter ÷ convert(I, 2)
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
