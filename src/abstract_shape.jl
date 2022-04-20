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

function get_height(shape)
    i_min, i_max = get_i_extrema(shape)
    return i_max - i_min + one(i_min)
end

get_j_min(image::AbstractMatrix) = firstindex(image, 2)
get_j_max(image::AbstractMatrix) = lastindex(image, 2)
get_j_extrema(x) = (get_j_min(x), get_j_max(x))

function get_width(shape)
    j_min, j_max = get_j_extrema(shape)
    return j_max - j_min + one(j_min)
end

get_position(shape) = Point(get_i_min(shape), get_j_min(shape))

function is_outbounds(image::AbstractMatrix, shape::AbstractShape)
    i_min_shape, i_max_shape = get_i_extrema(shape)
    i_min_image, i_max_image = get_i_extrema(image)

    j_min_shape, j_max_shape = get_j_extrema(shape)
    j_min_image, j_max_image = get_j_extrema(image)

    return i_max_shape < i_min_image || i_min_shape > i_max_image || j_max_shape < j_min_image || j_min_shape > j_max_image
end

function is_inbounds(image::AbstractMatrix, shape::AbstractShape)
    i_min_shape, i_max_shape = get_i_extrema(shape)
    i_min_image, i_max_image = get_i_extrema(image)

    j_min_shape, j_max_shape = get_j_extrema(shape)
    j_min_image, j_max_image = get_j_extrema(image)

    return i_min_shape >= i_min_image && i_max_shape <= i_max_image && j_min_shape >= j_min_image && j_max_shape <= j_max_image
end

#####
##### move shape
#####

move(shape::AbstractShape, i, j) = move_j(move_i(shape, i), j)

#####
##### drawing a single pixel on the image
#####

function put_pixel!(image::AbstractMatrix, i, j, color)
    if checkbounds(Bool, image, i, j)
        put_pixel_inbounds!(image, i, j, color)
    end

    return nothing
end

function put_pixel_inbounds!(image::AbstractMatrix, i, j, color)
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

    if is_inbounds(image, shape)
        draw!(put_pixel_inbounds!, image, shape, color)
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

    draw!(put_pixel_inbounds!, image, clip(image, shape), color)

    return nothing
end

#####
##### PutPixelInbounds (directly draw assuming shape is inbounds)
#####

struct PutPixelInbounds <: DrawingOptimizationStyle end
const PUT_PIXEL_INBOUNDS = PutPixelInbounds()

draw!(::PutPixelInbounds, image::AbstractMatrix, shape::AbstractShape, color) = draw!(put_pixel_inbounds!, image, shape, color)
