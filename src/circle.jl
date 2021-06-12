struct Circle{I <: Integer} <: AbstractShape
    i_center::I
    j_center::I
    radius::I
end

function draw_octant_reflections!(image::AbstractMatrix, i_center::Integer, j_center::Integer, i::Integer, j::Integer, color)
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
Draw a circle. Ref: https://www.geeksforgeeks.org/bresenhams-circle-drawing-algorithm/
"""
function draw!(image::AbstractMatrix, shape::Circle{I}, color) where {I}
    i_center = shape.i_center
    j_center = shape.j_center
    radius = shape.radius

    i = zero(I)
    j = radius
    d = 3 - 2 * radius

    draw_octant_reflections!(image, i_center, j_center, i, j, color)

    while j >= i
        i += 1

        if d > zero(d)
            j -= 1
            d = d + 4 * (i - j) + 10
        else
            d = d + 4 * i + 6
        end

        draw_octant_reflections!(image, i_center, j_center, i, j, color)
    end

    return nothing
end
