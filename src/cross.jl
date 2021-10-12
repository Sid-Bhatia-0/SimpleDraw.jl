mutable struct Cross{I <: Integer} <: AbstractShape
    i_center::I
    j_center::I
    radius::I
end

mutable struct HollowCross{I <: Integer} <: AbstractShape
    i_center::I
    j_center::I
    radius::I
end

function draw!(image::AbstractMatrix, shape::Cross, color)
    height, width = size(image)

    i_center = shape.i_center
    j_center = shape.j_center
    radius = shape.radius

    for j in j_center - radius : j_center + radius
        put_pixel!(image, i_center, j, color)
    end

    for i in i_center - radius : i_center + radius
        put_pixel!(image, i, j_center, color)
    end

    return nothing
end

function draw!(image::AbstractMatrix, shape::HollowCross, color)
    height, width = size(image)

    i_center = shape.i_center
    j_center = shape.j_center
    radius = shape.radius

    for j in j_center - radius : j_center + radius
        if j == j_center
            continue
        else
            put_pixel!(image, i_center, j, color)
        end
    end

    for i in i_center - radius : i_center + radius
        if i == i_center
            continue
        else
            put_pixel!(image, i, j_center, color)
        end
    end

    return nothing
end
