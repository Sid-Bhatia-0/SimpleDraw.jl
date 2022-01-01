#####
##### AbstractShape
#####

abstract type AbstractShape end

is_valid(::AbstractShape) = true

#####
##### functions for identifying where the shape lies with respect to the bounds of the image
#####

get_i_min(image::AbstractMatrix) = firstindex(image, 1)
get_i_max(image::AbstractMatrix) = lastindex(image, 1)
get_i_extrema(x) = (get_i_min(x), get_i_max(x))

get_j_min(image::AbstractMatrix) = firstindex(image, 2)
get_j_max(image::AbstractMatrix) = lastindex(image, 2)
get_j_extrema(x) = (get_j_min(x), get_j_max(x))

function is_outbounds(image::AbstractMatrix, shape::AbstractShape)
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

#####
##### drawing a single pixel on the image
#####

function put_pixel!(image::AbstractMatrix, i, j, color)
    if checkbounds(Bool, image, i, j)
        put_pixel_unchecked!(image, i, j, color)
    end

    return nothing
end

function put_pixel_unchecked!(image::AbstractMatrix, i, j, color)
    @inbounds image[i, j] = color
    return nothing
end

#####
##### DrawingOptimizationStyle to define generic draw! methods with different levels of optimization for drawing shapes
#####

abstract type DrawingOptimizationStyle end

get_drawing_optimization_style(shape) = PUT_PIXEL

draw!(image::AbstractMatrix, shape::AbstractShape, color) = draw!(get_drawing_optimization_style(shape), image, shape, color)

#####
##### PutPixel (least optimized)
#####

struct PutPixel <: DrawingOptimizationStyle end
const PUT_PIXEL = PutPixel()

draw!(::PutPixel, image::AbstractMatrix, shape::AbstractShape, color) = draw!(put_pixel!, image, shape, color)

#####
##### CheckBounds (checks outbounds and inbounds conditions and dispatches accordingly)
#####

struct CheckBounds <: DrawingOptimizationStyle end
const CHECK_BOUNDS = CheckBounds()

function draw!(::CheckBounds, image::AbstractMatrix, shape::AbstractShape, color)
    @assert is_valid(shape) "Cannot draw invalid shape $(shape)"

    if is_outbounds(image, shape)
        return nothing
    end

    if is_inbounds(shape, image)
        draw!(put_pixel_unchecked!, image, shape, color)
    else
        draw!(put_pixel!, image, shape, color)
    end

    return nothing
end

#####
##### Clip (clips the shapes that can be clipped easily and draw them with inbounds optimization)
#####

struct Clip <: DrawingOptimizationStyle end
const CLIP = Clip()

function draw!(::Clip, image::AbstractMatrix, shape::AbstractShape, color)
    @assert is_valid(shape) "Cannot draw invalid shape $(shape)"

    if is_outbounds(image, shape)
        return nothing
    end

    draw!(put_pixel_unchecked!, image, clip(shape, image), color)

    return nothing
end

#####
##### PutPixelUnchecked (directly draw assuming shape is inbounds)
#####

struct PutPixelUnchecked <: DrawingOptimizationStyle end
const PUT_PIXEL_UNCHECKED = PutPixelUnchecked()

draw!(::PutPixelUnchecked, image::AbstractMatrix, shape::AbstractShape, color) = draw!(put_pixel_unchecked!, image, shape, color)
