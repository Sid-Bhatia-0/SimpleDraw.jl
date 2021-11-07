struct Circle{I <: Integer} <: AbstractShape
    center::Point{I}
    radius::I
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

    if radius <= zero_value
        return nothing
    elseif radius == one_value
        draw!(image, center, color)
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

function draw!(image::AbstractMatrix, shape::FilledCircle{I}, color) where {I}
    center = shape.center
    i_center = center.i
    j_center = center.j
    radius = shape.radius

    zero_value = zero(I)
    one_value = one(I)

    if radius <= zero_value
        return nothing
    elseif radius == one_value
        draw!(image, center, color)
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
    radius_inner = radius_outer - thickness + 1

    if checkbounds(Bool, image, i_center - radius_outer, j_center - radius_outer) && checkbounds(Bool, image, i_center + radius_outer, j_center + radius_outer)
        draw_unchecked!(image, shape, color)
        return nothing
    end

    zero_value = zero(I)

    i_inner = zero_value
    j_inner = radius_inner

    i_outer = zero_value
    j_outer = radius_outer

    draw_octant_reflections_lines!(image, i_center, j_center, i_outer, j_inner, j_outer, color)

    constant_inner = 3 - 2 * radius_inner * radius_inner
    constant_outer = 3 - 2 * radius_outer * radius_outer

    while j_inner >= i_inner
        d_inner = 2 * j_inner * j_inner + 2 * i_inner * i_inner + 4 * i_inner - 2 * j_inner + constant_inner
        d_outer = 2 * j_outer * j_outer + 2 * i_outer * i_outer + 4 * i_outer - 2 * j_outer + constant_outer

        i_inner += 1
        i_outer += 1

        if d_inner > zero_value
            j_inner -= 1
        end

        if d_outer > zero_value
            j_outer -= 1
        end

        draw_octant_reflections_lines!(image, i_center, j_center, i_outer, j_inner, j_outer, color)
    end

    while j_outer >= i_outer
        d_outer = 2 * j_outer * j_outer + 2 * i_outer * i_outer + 4 * i_outer - 2 * j_outer + constant_outer

        i_outer += 1

        if d_outer > zero_value
            j_outer -= 1
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
    radius_inner = radius_outer - thickness + 1

    zero_value = zero(I)

    i_inner = zero_value
    j_inner = radius_inner

    i_outer = zero_value
    j_outer = radius_outer

    draw_octant_reflections_lines_unchecked!(image, i_center, j_center, i_outer, j_inner, j_outer, color)

    constant_inner = 3 - 2 * radius_inner * radius_inner
    constant_outer = 3 - 2 * radius_outer * radius_outer

    while j_inner >= i_inner
        d_inner = 2 * j_inner * j_inner + 2 * i_inner * i_inner + 4 * i_inner - 2 * j_inner + constant_inner
        d_outer = 2 * j_outer * j_outer + 2 * i_outer * i_outer + 4 * i_outer - 2 * j_outer + constant_outer

        i_inner += 1
        i_outer += 1

        if d_inner > zero_value
            j_inner -= 1
        end

        if d_outer > zero_value
            j_outer -= 1
        end

        draw_octant_reflections_lines_unchecked!(image, i_center, j_center, i_outer, j_inner, j_outer, color)
    end

    while j_outer >= i_outer
        d_outer = 2 * j_outer * j_outer + 2 * i_outer * i_outer + 4 * i_outer - 2 * j_outer + constant_outer

        i_outer += 1

        if d_outer > zero_value
            j_outer -= 1
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
