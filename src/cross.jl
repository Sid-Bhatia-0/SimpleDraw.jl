mutable struct Cross{I <: Integer} <: AbstractShape
    center::Point{I}
    radius::I
end

mutable struct HollowCross{I <: Integer} <: AbstractShape
    center::Point{I}
    radius::I
end

function draw!(image::AbstractMatrix, shape::Cross, color)
    height, width = size(image)

    i_center = shape.center.i
    j_center = shape.center.j
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

    i_center = shape.center.i
    j_center = shape.center.j
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
