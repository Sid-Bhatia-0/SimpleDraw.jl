struct Circle{I <: Integer} <: AbstractShape
    center::Point{I}
    radius::I
end

struct EvenCircle{I <: Integer} <: AbstractShape
    position::Point{I}
    diameter::I
end

struct FilledCircle{I <: Integer} <: AbstractShape
    center::Point{I}
    radius::I
end

struct ThickCircle{I <: Integer} <: AbstractShape
    center::Point{I}
    radius::I
    thickness::I
end

@inline function draw_vertical_strip_reflections!(image::AbstractMatrix, i_center::Integer, j_center::Integer, i::Integer, j::Integer, color)
    draw!(image, VerticalLine(i_center - i, i_center + i, j_center - j), color)
    draw!(image, VerticalLine(i_center - j, i_center + j, j_center - i), color)
    draw!(image, VerticalLine(i_center - j, i_center + j, j_center + i), color)
    draw!(image, VerticalLine(i_center - i, i_center + i, j_center + j), color)

    return nothing
end

@inline function draw_vertical_strip_reflections_unchecked!(image::AbstractMatrix, i_center::Integer, j_center::Integer, i::Integer, j::Integer, color)
    draw_unchecked!(image, VerticalLine(i_center - i, i_center + i, j_center - j), color)
    draw_unchecked!(image, VerticalLine(i_center - j, i_center + j, j_center - i), color)
    draw_unchecked!(image, VerticalLine(i_center - j, i_center + j, j_center + i), color)
    draw_unchecked!(image, VerticalLine(i_center - i, i_center + i, j_center + j), color)

    return nothing
end

@inline function draw_octant_reflections!(image::AbstractMatrix, i_center::Integer, j_center::Integer, i::Integer, j::Integer, color)
    put_pixel!(image, i_center - i, j_center - j, color)
    put_pixel!(image, i_center + i, j_center - j, color)
    put_pixel!(image, i_center - j, j_center - i, color)
    put_pixel!(image, i_center + j, j_center - i, color)
    put_pixel!(image, i_center - j, j_center + i, color)
    put_pixel!(image, i_center + j, j_center + i, color)
    put_pixel!(image, i_center - i, j_center + j, color)
    put_pixel!(image, i_center + i, j_center + j, color)

    return nothing
end

@inline function draw_octant_reflections_even!(image::AbstractMatrix, i_center::Integer, j_center::Integer, i::Integer, j::Integer, color)
    one_value = one(i_center)
    put_pixel!(image, i_center - i, j_center - j, color)
    put_pixel!(image, i_center + i - one_value, j_center - j, color)
    put_pixel!(image, i_center - j, j_center - i, color)
    put_pixel!(image, i_center + j - one_value, j_center - i, color)
    put_pixel!(image, i_center - j, j_center + i - one_value, color)
    put_pixel!(image, i_center + j - one_value, j_center + i - one_value, color)
    put_pixel!(image, i_center - i, j_center + j - one_value, color)
    put_pixel!(image, i_center + i - one_value, j_center + j - one_value, color)

    return nothing
end

@inline function draw_octant_reflections_even_unchecked!(image::AbstractMatrix, i_center::Integer, j_center::Integer, i::Integer, j::Integer, color)
    one_value = one(i_center)
    put_pixel_unchecked!(image, i_center - i, j_center - j, color)
    put_pixel_unchecked!(image, i_center + i - one_value, j_center - j, color)
    put_pixel_unchecked!(image, i_center - j, j_center - i, color)
    put_pixel_unchecked!(image, i_center + j - one_value, j_center - i, color)
    put_pixel_unchecked!(image, i_center - j, j_center + i - one_value, color)
    put_pixel_unchecked!(image, i_center + j - one_value, j_center + i - one_value, color)
    put_pixel_unchecked!(image, i_center - i, j_center + j - one_value, color)
    put_pixel_unchecked!(image, i_center + i - one_value, j_center + j - one_value, color)

    return nothing
end

@inline function draw_octant_reflections_unchecked!(image::AbstractMatrix, i_center, j_center, i, j, color)
    put_pixel_unchecked!(image, i_center - i, j_center - j, color)
    put_pixel_unchecked!(image, i_center + i, j_center - j, color)
    put_pixel_unchecked!(image, i_center - j, j_center - i, color)
    put_pixel_unchecked!(image, i_center + j, j_center - i, color)
    put_pixel_unchecked!(image, i_center - j, j_center + i, color)
    put_pixel_unchecked!(image, i_center + j, j_center + i, color)
    put_pixel_unchecked!(image, i_center - i, j_center + j, color)
    put_pixel_unchecked!(image, i_center + i, j_center + j, color)

    return nothing
end

@inline function draw_octant_reflections_lines!(image::AbstractMatrix, i_center, j_center, i, j_inner, j_outer, color)
    draw!(image, HorizontalLine(i_center - i, j_center - j_outer, j_center - j_inner), color)
    draw!(image, HorizontalLine(i_center + i, j_center - j_outer, j_center - j_inner), color)
    draw!(image, VerticalLine(i_center - j_outer, i_center - j_inner, j_center - i), color)
    draw!(image, VerticalLine(i_center + j_inner, i_center + j_outer, j_center - i), color)
    draw!(image, VerticalLine(i_center - j_outer, i_center - j_inner, j_center + i), color)
    draw!(image, VerticalLine(i_center + j_inner, i_center + j_outer, j_center + i), color)
    draw!(image, HorizontalLine(i_center - i, j_center + j_inner, j_center + j_outer), color)
    draw!(image, HorizontalLine(i_center + i, j_center + j_inner, j_center + j_outer), color)

    return nothing
end

@inline function draw_octant_reflections_lines_unchecked!(image::AbstractMatrix, i_center, j_center, i, j_inner, j_outer, color)
    draw_unchecked!(image, HorizontalLine(i_center - i, j_center - j_outer, j_center - j_inner), color)
    draw_unchecked!(image, HorizontalLine(i_center + i, j_center - j_outer, j_center - j_inner), color)
    draw_unchecked!(image, VerticalLine(i_center - j_outer, i_center - j_inner, j_center - i), color)
    draw_unchecked!(image, VerticalLine(i_center + j_inner, i_center + j_outer, j_center - i), color)
    draw_unchecked!(image, VerticalLine(i_center - j_outer, i_center - j_inner, j_center + i), color)
    draw_unchecked!(image, VerticalLine(i_center + j_inner, i_center + j_outer, j_center + i), color)
    draw_unchecked!(image, HorizontalLine(i_center - i, j_center + j_inner, j_center + j_outer), color)
    draw_unchecked!(image, HorizontalLine(i_center + i, j_center + j_inner, j_center + j_outer), color)

    return nothing
end

"""
Draw a circle. Ref: https://en.wikipedia.org/wiki/Midpoint_circle_algorithm variant with integer-based arithmetic
"""
function draw!(image::AbstractMatrix, shape::Circle{I}, color) where {I}
    center = shape.center
    i_center = center.i
    j_center = center.j
    radius = shape.radius

    zero_value = zero(I)
    one_value = one(I)

    if radius < zero_value
        return nothing
    end

    i_min = i_center - radius
    j_min = j_center - radius

    i_max = i_center + radius
    j_max = j_center + radius

    i_min_image = firstindex(image, 1)
    i_max_image = lastindex(image, 1)

    j_min_image = firstindex(image, 2)
    j_max_image = lastindex(image, 2)

    if i_max < i_min_image || i_min > i_max_image || j_max < j_min_image || j_min > j_max_image
        return nothing
    end

    if radius == zero_value
        draw!(image, center, color)
        return nothing
    end

    if i_min >= i_min_image && j_min >= j_min_image && i_max <= i_max_image && j_max <= j_max_image
        draw_unchecked!(image, shape, color)
        return nothing
    end

    i = zero_value
    j = radius

    draw_octant_reflections!(image, i_center, j_center, i, j, color)

    constant = convert(I, 3) - convert(I, 2) * radius * radius

    while j >= i
        d = convert(I, 2) * j * j + convert(I, 2) * i * i + convert(I, 4) * i - convert(I, 2) * j + constant

        i += one_value

        if d > zero_value
            j -= one_value
        end

        draw_octant_reflections!(image, i_center, j_center, i, j, color)
    end

    return nothing
end

function draw_unchecked!(image::AbstractMatrix, shape::Circle{I}, color) where {I}
    i_center = shape.center.i
    j_center = shape.center.j
    radius = shape.radius

    zero_value = zero(I)
    one_value = one(I)

    i = zero_value
    j = radius

    draw_octant_reflections_unchecked!(image, i_center, j_center, i, j, color)

    constant = convert(I, 3) - convert(I, 2) * radius * radius

    while j >= i
        d = convert(I, 2) * j * j + convert(I, 2) * i * i + convert(I, 4) * i - convert(I, 2) * j + constant

        i += one_value

        if d > zero_value
            j -= one_value
        end

        draw_octant_reflections_unchecked!(image, i_center, j_center, i, j, color)
    end

    return nothing
end

function draw!(image::AbstractMatrix, shape::EvenCircle{I}, color) where {I}
    position = shape.position
    i_position = position.i
    j_position = position.j
    diameter = shape.diameter

    zero_value = zero(I)
    one_value = one(I)

    @assert iseven(diameter) "diameter must be an even number"
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

    if diameter == one_value
        draw!(image, position, color)
        return nothing
    end

    if diameter == convert(I, 2)
        i_position_plus_1 = i_position + one_value
        j_position_plus_1 = j_position + one_value
        draw!(image, position, color)
        draw!(image, Point(i_position_plus_1, j_position), color)
        draw!(image, Point(i_position, j_position_plus_1), color)
        draw!(image, Point(i_position_plus_1, j_position_plus_1), color)
        return nothing
    end

    if i_min >= i_min_image && j_min >= j_min_image && i_max <= i_max_image && j_max <= j_max_image
        draw_unchecked!(image, shape, color)
        return nothing
    end

    radius = diameter ÷ 2 # d = 1 and d = 2 cases have been take care of above
    i = zero_value
    j = radius
    i_center = i_position + radius
    j_center = j_position + radius

    draw_octant_reflections_even!(image, i_center, j_center, i, j, color)

    constant = convert(I, 3) - convert(I, 2) * radius * radius

    while j >= i
        d = convert(I, 2) * j * j + convert(I, 2) * i * i + convert(I, 4) * i - convert(I, 2) * j + constant

        i += one_value

        if d > zero_value
            j -= one_value
        end

        draw_octant_reflections_even!(image, i_center, j_center, i, j, color)
    end

    return nothing
end

function draw_unchecked!(image::AbstractMatrix, shape::EvenCircle{I}, color) where {I}
    position = shape.position
    i_position = position.i
    j_position = position.j
    diameter = shape.diameter

    zero_value = zero(I)
    one_value = one(I)

    radius = diameter ÷ 2
    i = zero_value
    j = radius
    i_center = i_position + radius
    j_center = j_position + radius

    draw_octant_reflections_even_unchecked!(image, i_center, j_center, i, j, color)

    constant = convert(I, 3) - convert(I, 2) * radius * radius

    while j >= i
        d = convert(I, 2) * j * j + convert(I, 2) * i * i + convert(I, 4) * i - convert(I, 2) * j + constant

        i += one_value

        if d > zero_value
            j -= one_value
        end

        draw_octant_reflections_even_unchecked!(image, i_center, j_center, i, j, color)
    end

    return nothing
end

function draw!(image::AbstractMatrix, shape::FilledCircle{I}, color) where {I}
    center = shape.center
    i_center = center.i
    j_center = center.j
    radius = shape.radius

    zero_value = zero(I)
    one_value = one(I)

    if radius < zero_value
        return nothing
    end

    i_min = i_center - radius
    j_min = j_center - radius

    i_max = i_center + radius
    j_max = j_center + radius

    i_min_image = firstindex(image, 1)
    i_max_image = lastindex(image, 1)

    j_min_image = firstindex(image, 2)
    j_max_image = lastindex(image, 2)

    if i_max < i_min_image || i_min > i_max_image || j_max < j_min_image || j_min > j_max_image
        return nothing
    end

    if radius == zero_value
        draw!(image, center, color)
        return nothing
    end

    if i_min >= i_min_image && j_min >= j_min_image && i_max <= i_max_image && j_max <= j_max_image
        draw_unchecked!(image, shape, color)
        return nothing
    end

    i = zero_value
    j = radius

    draw_vertical_strip_reflections!(image, i_center, j_center, i, j, color)

    constant = convert(I, 3) - convert(I, 2) * radius * radius

    while j >= i
        d = convert(I, 2) * j * j + convert(I, 2) * i * i + convert(I, 4) * i - convert(I, 2) * j + constant

        i += one_value

        if d > zero_value
            j -= one_value
        end

        draw_vertical_strip_reflections!(image, i_center, j_center, i, j, color)
    end

    return nothing
end

function draw_unchecked!(image::AbstractMatrix, shape::FilledCircle{I}, color) where {I}
    i_center = shape.center.i
    j_center = shape.center.j
    radius = shape.radius

    zero_value = zero(I)
    one_value = one(I)

    i = zero_value
    j = radius

    draw_vertical_strip_reflections_unchecked!(image, i_center, j_center, i, j, color)

    constant = convert(I, 3) - convert(I, 2) * radius * radius

    while j >= i
        d = convert(I, 2) * j * j + convert(I, 2) * i * i + convert(I, 4) * i - convert(I, 2) * j + constant

        i += one_value

        if d > zero_value
            j -= one_value
        end

        draw_vertical_strip_reflections_unchecked!(image, i_center, j_center, i, j, color)
    end

    return nothing
end

function draw!(image::AbstractMatrix, shape::ThickCircle{I}, color) where {I}
    center = shape.center
    i_center = center.i
    j_center = center.j
    radius_outer = shape.radius
    thickness = shape.thickness

    zero_value = zero(I)
    one_value = one(I)

    if thickness < one_value || thickness > radius_outer || radius_outer < zero_value
        return nothing
    end

    i_min = i_center - radius_outer
    j_min = j_center - radius_outer

    i_max = i_center + radius_outer
    j_max = j_center + radius_outer

    i_min_image = firstindex(image, 1)
    i_max_image = lastindex(image, 1)

    j_min_image = firstindex(image, 2)
    j_max_image = lastindex(image, 2)

    if i_max < i_min_image || i_min > i_max_image || j_max < j_min_image || j_min > j_max_image
        return nothing
    end

    if radius_outer == zero_value
        draw!(image, center, color)
        return nothing
    end

    if thickness == one_value
        draw!(image, Circle(center, radius_outer), color)
        return nothing
    end

    if thickness == radius_outer
        draw!(image, FilledCircle(center, radius_outer), color)
        return nothing
    end

    if i_min >= i_min_image && j_min >= j_min_image && i_max <= i_max_image && j_max <= j_max_image
        draw_unchecked!(image, shape, color)
        return nothing
    end

    radius_inner = radius_outer - thickness + one_value

    i_inner = zero_value
    j_inner = radius_inner

    i_outer = zero_value
    j_outer = radius_outer

    draw_octant_reflections_lines!(image, i_center, j_center, i_outer, j_inner, j_outer, color)

    constant_inner = convert(I, 3) - convert(I, 2) * radius_inner * radius_inner
    constant_outer = convert(I, 3) - convert(I, 2) * radius_outer * radius_outer

    while j_inner >= i_inner
        d_inner = convert(I, 2) * j_inner * j_inner + convert(I, 2) * i_inner * i_inner + convert(I, 4) * i_inner - convert(I, 2) * j_inner + constant_inner
        d_outer = convert(I, 2) * j_outer * j_outer + convert(I, 2) * i_outer * i_outer + convert(I, 4) * i_outer - convert(I, 2) * j_outer + constant_outer

        i_inner += one_value
        i_outer += one_value

        if d_inner > zero_value
            j_inner -= one_value
        end

        if d_outer > zero_value
            j_outer -= one_value
        end

        draw_octant_reflections_lines!(image, i_center, j_center, i_outer, j_inner, j_outer, color)
    end

    while j_outer >= i_outer
        d_outer = convert(I, 2) * j_outer * j_outer + convert(I, 2) * i_outer * i_outer + convert(I, 4) * i_outer - convert(I, 2) * j_outer + constant_outer

        i_outer += one_value

        if d_outer > zero_value
            j_outer -= one_value
        end

        i = min(i_outer, j_outer)

        draw_octant_reflections_lines!(image, i_center, j_center, i, i_outer, j_outer, color)
    end

    return nothing
end

function draw_unchecked!(image::AbstractMatrix, shape::ThickCircle{I}, color) where {I}
    center = shape.center
    i_center = center.i
    j_center = center.j
    radius_outer = shape.radius
    thickness = shape.thickness

    zero_value = zero(I)
    one_value = one(I)

    radius_inner = radius_outer - thickness + one_value

    i_inner = zero_value
    j_inner = radius_inner

    i_outer = zero_value
    j_outer = radius_outer

    draw_octant_reflections_lines_unchecked!(image, i_center, j_center, i_outer, j_inner, j_outer, color)

    constant_inner = convert(I, 3) - convert(I, 2) * radius_inner * radius_inner
    constant_outer = convert(I, 3) - convert(I, 2) * radius_outer * radius_outer

    while j_inner >= i_inner
        d_inner = convert(I, 2) * j_inner * j_inner + convert(I, 2) * i_inner * i_inner + convert(I, 4) * i_inner - convert(I, 2) * j_inner + constant_inner
        d_outer = convert(I, 2) * j_outer * j_outer + convert(I, 2) * i_outer * i_outer + convert(I, 4) * i_outer - convert(I, 2) * j_outer + constant_outer

        i_inner += one_value
        i_outer += one_value

        if d_inner > zero_value
            j_inner -= one_value
        end

        if d_outer > zero_value
            j_outer -= one_value
        end

        draw_octant_reflections_lines_unchecked!(image, i_center, j_center, i_outer, j_inner, j_outer, color)
    end

    while j_outer >= i_outer
        d_outer = convert(I, 2) * j_outer * j_outer + convert(I, 2) * i_outer * i_outer + convert(I, 4) * i_outer - convert(I, 2) * j_outer + constant_outer

        i_outer += one_value

        if d_outer > zero_value
            j_outer -= one_value
        end

        i = min(i_outer, j_outer)

        draw_octant_reflections_lines_unchecked!(image, i_center, j_center, i, i_outer, j_outer, color)
    end

    return nothing
end

function get_bounding_box(shape::Circle)
    center = shape.center
    radius = shape.radius
    i = center.i
    j = center.j
    side = 2 * radius + 1

    return Rectangle(Point(i - radius, j - radius), side, side)
end

get_bounding_box(shape::ThickCircle) = get_bounding_box(Circle(shape.center, shape.radius))

get_bounding_box(shape::FilledCircle) = get_bounding_box(Circle(shape.center, shape.radius))
