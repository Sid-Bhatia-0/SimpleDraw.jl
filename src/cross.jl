abstract type AbstractCross <: AbstractShape end

struct Cross{I <: Integer} <: AbstractCross
    position::Point{I}
    diameter::I
end

struct HollowCross{I <: Integer} <: AbstractCross
    position::Point{I}
    diameter::I
end

#####
##### AbstractCross
#####

is_valid(shape::AbstractCross) = shape.diameter > convert(typeof(shape.diameter), 3)

function is_outbounds(shape::AbstractCross, image::AbstractMatrix)
    position = shape.position
    diameter = shape.diameter

    I = typeof(diameter)

    i_min = position.i
    j_min = position.j

    diameter_minus_1 = diameter - one(I)
    i_max = i_min + diameter_minus_1
    j_max = j_min + diameter_minus_1

    i_min_image = firstindex(image, 1)
    i_max_image = lastindex(image, 1)

    j_min_image = firstindex(image, 2)
    j_max_image = lastindex(image, 2)

    return i_max < i_min_image || i_min > i_max_image || j_max < j_min_image || j_min > j_max_image
end

get_bounding_box(shape::AbstractCross) = Rectangle(shape.position, shape.diameter, shape.diameter)

#####
##### Cross
#####

function draw!(image::AbstractMatrix, shape::Cross, color)
    @assert is_valid(shape) "Cannot draw invalid shape $(shape)"

    if is_outbounds(shape, image)
        return nothing
    end

    position = shape.position
    diameter = shape.diameter

    I = typeof(diameter)

    if diameter == one(I)
        draw!(image, position, color)
        return nothing
    end

    i_position = position.i
    j_position = position.j

    i_min = i_position
    j_min = j_position

    diameter_minus_1 = diameter - one(I)
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
    diameter = shape.diameter

    I = typeof(diameter)

    i_position = position.i
    j_position = position.j

    radius = diameter ÷ convert(I, 2)
    i_center = i_position + radius
    j_center = j_position + radius

    _draw!(image, HorizontalLine(i_center, j_center - radius, j_center + radius), color)
    _draw!(image, VerticalLine(i_center - radius, i_center + radius, j_center), color)

    return nothing
end

#####
##### HollowCross
#####

function draw!(image::AbstractMatrix, shape::HollowCross, color)
    @assert is_valid(shape) "Cannot draw invalid shape $(shape)"

    if is_outbounds(shape, image)
        return nothing
    end

    position = shape.position
    diameter = shape.diameter

    I = typeof(diameter)

    i_min = position.i
    j_min = position.j

    diameter_minus_1 = diameter - one(I)
    i_max = i_min + diameter_minus_1
    j_max = j_min + diameter_minus_1

    radius = diameter ÷ convert(I, 2)
    i_center = i_min + radius
    j_center = j_min + radius

    draw!(image, HorizontalLine(i_center, j_min, j_center - one(I)), color)
    draw!(image, VerticalLine(i_min, i_center - one(I), j_center), color)
    draw!(image, VerticalLine(i_center + one(I), i_max, j_center), color)
    draw!(image, HorizontalLine(i_center, j_center + one(I), j_max), color)

    return nothing
end

function _draw!(image::AbstractMatrix, shape::HollowCross, color)
    position = shape.position
    diameter = shape.diameter

    I = typeof(diameter)

    i_min = position.i
    j_min = position.j

    diameter_minus_1 = diameter - one(I)
    i_max = i_position + diameter_minus_1
    j_max = j_position + diameter_minus_1

    radius = diameter ÷ convert(I, 2)
    i_center = i_min + radius
    j_center = j_min + radius

    _draw!(image, HorizontalLine(i_center, j_min, j_center - one(I)), color)
    _draw!(image, VerticalLine(i_min, i_center - one(I), j_center), color)
    _draw!(image, VerticalLine(i_center + one(I), i_max, j_center), color)
    _draw!(image, HorizontalLine(i_center, j_center + one(I), j_max), color)

    return nothing
end
