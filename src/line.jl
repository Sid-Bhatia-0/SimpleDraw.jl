mutable struct Line{I <: Integer, C} <: AbstractDrawable
    i1::I
    j1::I
    i2::I
    j2::I
    color::C
end

"""
Draw a line. Ref: https://en.wikipedia.org/wiki/Bresenham%27s_line_algorithm
"""
function draw!(image::AbstractMatrix, drawable::Line)
    i1 = drawable.i1
    j1 = drawable.j1
    i2 = drawable.i2
    j2 = drawable.j2
    color = drawable.color

    di = abs(i2 - i1)
    dj = -abs(j2 - j1)
    si = i1 < i2 ? 1 : -1
    sj = j1 < j2 ? 1 : -1
    err = di + dj

    while true
        image[i1, j1] = color

        if (i1 == i2 && j1 == j2)
            break
        end

        e2 = 2 * err

        if (e2 >= dj)
            err += dj
            i1 += si
        end

        if (e2 <= di)
            err += di
            j1 += sj
        end
    end

    return nothing
end
