module SimpleDraw

abstract type AbstractShape end

@inline function put_pixel!(image, i, j, color)
    if checkbounds(Bool, image, i, j)
        put_pixel_unchecked!(image, i, j, color)
    end

    return nothing
end

@inline function put_pixel_unchecked!(image, i, j, color)
    @inbounds image[i, j] = color
    return nothing
end

is_valid(::AbstractShape) = true

get_i_min(image::AbstractMatrix) = firstindex(image, 1)
get_i_max(image::AbstractMatrix) = lastindex(image, 1)

get_j_min(image::AbstractMatrix) = firstindex(image, 2)
get_j_max(image::AbstractMatrix) = lastindex(image, 2)

function is_outbounds(shape::AbstractShape, image::AbstractMatrix)
    i_min_shape = get_i_min(shape)
    j_min_shape = get_j_min(shape)

    i_max_shape = get_i_max(shape)
    j_max_shape = get_j_max(shape)

    i_min_image = get_i_min(image)
    j_min_image = get_j_min(image)

    i_max_image = get_i_max(image)
    j_max_image = get_j_max(image)

    return i_max_shape < i_min_image || i_min_shape > i_max_image || j_max_shape < j_min_image || j_min_shape > j_max_image
end

function is_inbounds(shape::AbstractShape, image::AbstractMatrix)
    i_min_shape = get_i_min(shape)
    j_min_shape = get_j_min(shape)

    i_max_shape = get_i_max(shape)
    j_max_shape = get_j_max(shape)

    i_min_image = get_i_min(image)
    j_min_image = get_j_min(image)

    i_max_image = get_i_max(image)
    j_max_image = get_j_max(image)

    return i_min_shape >= i_min_image && i_max_shape <= i_max_image && j_min_shape >= j_min_image && j_max_shape <= j_max_image
end

include("point.jl")
include("background.jl")
include("line.jl")
include("symmetry.jl")
include("circle.jl")
include("rectangle.jl")
include("bitmap.jl")
include("character.jl")
include("text.jl")
include("visualize.jl")

end
