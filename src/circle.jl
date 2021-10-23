mutable struct Circle{I <: Integer} <: AbstractShape
    center::Point{I}
    radius::I
end

mutable struct FilledCircle{I <: Integer} <: AbstractShape
    center::Point{I}
    radius::I
end

mutable struct ThickCircle{I <: Integer} <: AbstractShape
    center::Point{I}
    radius::I
    thickness::I
end

@inline function draw_vertical_strip_reflections!(image::AbstractMatrix, i_center::Integer, j_center::Integer, i::Integer, j::Integer, color)
    for ii in i_center - i : i_center + i
        put_pixel!(image, ii, j_center - j, color)
    end

    for ii in i_center - j : i_center + j
        put_pixel!(image, ii, j_center - i, color)
    end

    for ii in i_center - j : i_center + j
        put_pixel!(image, ii, j_center + i, color)
    end

    for ii in i_center - i : i_center + i
        put_pixel!(image, ii, j_center + j, color)
    end

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

@inline function draw_octant_reflections_inbounds!(image::AbstractMatrix, i_center, j_center, i, j, color)
    put_pixel_inbounds!(image, i_center - i, j_center - j, color)
    put_pixel_inbounds!(image, i_center + i, j_center - j, color)
    put_pixel_inbounds!(image, i_center - j, j_center - i, color)
    put_pixel_inbounds!(image, i_center + j, j_center - i, color)
    put_pixel_inbounds!(image, i_center - j, j_center + i, color)
    put_pixel_inbounds!(image, i_center + j, j_center + i, color)
    put_pixel_inbounds!(image, i_center - i, j_center + j, color)
    put_pixel_inbounds!(image, i_center + i, j_center + j, color)

    return nothing
end

@inline function draw_octant_reflections_lines!(image::AbstractMatrix, i_center, j_center, i_inner, j_inner, i_outer, j_outer, color)
    draw!(image, Line(Point(i_center - i_outer, j_center - j_outer), Point(i_center - i_inner, j_center - j_inner)), color)
    draw!(image, Line(Point(i_center + i_outer, j_center - j_outer), Point(i_center + i_inner, j_center - j_inner)), color)
    draw!(image, Line(Point(i_center - j_outer, j_center - i_outer), Point(i_center - j_inner, j_center - i_inner)), color)
    draw!(image, Line(Point(i_center + j_outer, j_center - i_outer), Point(i_center + j_inner, j_center - i_inner)), color)
    draw!(image, Line(Point(i_center - j_outer, j_center + i_outer), Point(i_center - j_inner, j_center + i_inner)), color)
    draw!(image, Line(Point(i_center + j_outer, j_center + i_outer), Point(i_center + j_inner, j_center + i_inner)), color)
    draw!(image, Line(Point(i_center - i_outer, j_center + j_outer), Point(i_center - i_inner, j_center + j_inner)), color)
    draw!(image, Line(Point(i_center + i_outer, j_center + j_outer), Point(i_center + i_inner, j_center + j_inner)), color)

    return nothing
end

"""
Draw a circle. Ref: https://en.wikipedia.org/wiki/Midpoint_circle_algorithm variant with integer-based arithmetic
"""
function draw!(image::AbstractMatrix, shape::Circle{I}, color) where {I}
    i_center = shape.center.i
    j_center = shape.center.j
    radius = shape.radius

    if checkbounds(Bool, image, i_center - radius, j_center - radius) && checkbounds(Bool, image, i_center + radius, j_center + radius)
        draw_inbounds!(image, shape, color)
        return nothing
    end

    zero_value = zero(I)

    i = zero_value
    j = radius

    draw_octant_reflections!(image, i_center, j_center, i, j, color)

    constant = 3 - 2 * radius * radius

    while j >= i
        d = 2 * j * j + 2 * i * i + 4 * i - 2 * j + constant

        i += 1

        if d > zero_value
            j -= 1
        end

        draw_octant_reflections!(image, i_center, j_center, i, j, color)
    end

    return nothing
end

function draw_inbounds!(image::AbstractMatrix, shape::Circle{I}, color) where {I}
    i_center = shape.center.i
    j_center = shape.center.j
    radius = shape.radius

    zero_value = zero(I)

    i = zero_value
    j = radius

    draw_octant_reflections_inbounds!(image, i_center, j_center, i, j, color)

    constant = 3 - 2 * radius * radius

    while j >= i
        d = 2 * j * j + 2 * i * i + 4 * i - 2 * j + constant

        i += 1

        if d > zero_value
            j -= 1
        end

        draw_octant_reflections_inbounds!(image, i_center, j_center, i, j, color)
    end

    return nothing
end

function draw!(image::AbstractMatrix, shape::FilledCircle{I}, color) where {I}
    i_center = shape.center.i
    j_center = shape.center.j
    radius = shape.radius

    zero_value = zero(I)

    i = zero_value
    j = radius

    draw_vertical_strip_reflections!(image, i_center, j_center, i, j, color)

    constant = 3 - 2 * radius * radius

    while j >= i
        d = 2 * j * j + 2 * i * i + 4 * i - 2 * j + constant

        i += 1

        if d > zero_value
            j -= 1
        end

        draw_vertical_strip_reflections!(image, i_center, j_center, i, j, color)
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

    zero_value = zero(I)

    i_inner = zero_value
    j_inner = radius_inner

    i_outer = zero_value
    j_outer = radius_outer

    draw_octant_reflections_lines!(image, i_center, j_center, i_inner, j_inner, i_outer, j_outer, color)

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

        draw_octant_reflections_lines!(image, i_center, j_center, i_inner, j_inner, i_outer, j_outer, color)
    end

    while j_outer >= i_outer
        d_outer = 2 * j_outer * j_outer + 2 * i_outer * i_outer + 4 * i_outer - 2 * j_outer + constant_outer

        i_outer += 1

        if d_outer > zero_value
            j_outer -= 1
        end

        t = min(i_outer, j_outer)

        draw_octant_reflections_lines!(image, i_center, j_center, t, t, i_outer, j_outer, color)
    end

    return nothing
end
