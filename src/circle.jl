struct Circle{I <: Integer} <: AbstractShape
    i_center::I
    j_center::I
    radius::I
end

struct FilledCircle{I <: Integer} <: AbstractShape
    circle::Circle{I}
end

@inline function draw_vertical_strip_reflections!(image::AbstractMatrix, i_center::Integer, j_center::Integer, i::Integer, j::Integer, color)
    image[i_center - i : i_center + i, j_center - j] .= color
    image[i_center - j : i_center + j, j_center - i] .= color
    image[i_center - j : i_center + j, j_center + i] .= color
    image[i_center - i : i_center + i, j_center + j] .= color

    return nothing
end

@inline function draw_octant_reflections!(image::AbstractMatrix, i_center::Integer, j_center::Integer, i::Integer, j::Integer, color)
    image[i_center + i, j_center + j] = color
    image[i_center - i, j_center + j] = color
    image[i_center + i, j_center - j] = color
    image[i_center - i, j_center - j] = color
    image[i_center + j, j_center + i] = color
    image[i_center - j, j_center + i] = color
    image[i_center + j, j_center - i] = color
    image[i_center - j, j_center - i] = color

    return nothing
end

"""
Draw a circle. Ref: https://en.wikipedia.org/wiki/Midpoint_circle_algorithm variant with integer-based arithmetic
"""
function draw!(image::AbstractMatrix, shape::Circle{I}, color) where {I}
    i_center = shape.i_center
    j_center = shape.j_center
    radius = shape.radius

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

function draw!(image::AbstractMatrix, shape::FilledCircle{I}, color) where {I}
    i_center = shape.circle.i_center
    j_center = shape.circle.j_center
    radius = shape.circle.radius

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
