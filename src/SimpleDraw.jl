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
get_i_extrema(x) = (get_i_min(x), get_i_max(x))

get_j_min(image::AbstractMatrix) = firstindex(image, 2)
get_j_max(image::AbstractMatrix) = lastindex(image, 2)
get_j_extrema(x) = (get_j_min(x), get_j_max(x))

function is_outbounds(shape::AbstractShape, image::AbstractMatrix)
    i_min_shape, i_max_shape = get_i_extrema(shape)
    i_min_image, i_max_image = get_i_extrema(image)

    j_min_shape, j_max_shape = get_j_extrema(shape)
    j_min_image, j_max_image = get_j_extrema(image)

    return i_max_shape < i_min_image || i_min_shape > i_max_image || j_max_shape < j_min_image || j_min_shape > j_max_image
end

function is_inbounds(shape::AbstractShape, image::AbstractMatrix)
    i_min_shape, i_max_shape = get_i_extrema(shape)
    i_min_image, i_max_image = get_i_extrema(image)

    j_min_shape, j_max_shape = get_j_extrema(shape)
    j_min_image, j_max_image = get_j_extrema(image)

    return i_min_shape >= i_min_image && i_max_shape <= i_max_image && j_min_shape >= j_min_image && j_max_shape <= j_max_image
end

function draw!(image::AbstractMatrix, shape::AbstractShape, color)
    @assert is_valid(shape) "Cannot draw invalid shape $(shape)"

    if is_outbounds(shape, image)
        return nothing
    end

    if is_inbounds(shape, image)
        draw!(put_pixel_unchecked!, image, shape, color)
    else
        draw!(put_pixel!, image, shape, color)
    end

    return nothing
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
