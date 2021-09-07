mutable struct Cross{I <: Integer, C} <: AbstractDrawable
    i_center::I
    j_center::I
    radius::I
    color::C
end

mutable struct HollowCross{I <: Integer, C} <: AbstractDrawable
    i_center::I
    j_center::I
    radius::I
    color::C
end

function draw!(image::AbstractMatrix, drawable::Cross)
    height, width = size(image)

    i_center = drawable.i_center
    j_center = drawable.j_center
    radius = drawable.radius
    color = drawable.color

    for j in j_center - radius : j_center + radius
        put_pixel!(image, i_center, j, color)
    end

    for i in i_center - radius : i_center + radius
        put_pixel!(image, i, j_center, color)
    end

    return nothing
end

function draw!(image::AbstractMatrix, drawable::HollowCross)
    height, width = size(image)

    i_center = drawable.i_center
    j_center = drawable.j_center
    radius = drawable.radius
    color = drawable.color

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
