#####
##### AbstractShape
#####

abstract type AbstractShape end

is_valid(::AbstractShape) = true

#####
##### position related functions
#####

"""
    get_i_min(shape)

Return the minimum index of the bounding box of `shape` along the i-axis (vertical-axis, 1st-axis).

# Examples
```julia-repl
julia> get_i_min(Line(Point(9, 5), Point(24, 28)))
9
```
"""
function get_i_min end

"""
    get_i_max(shape)

Return the maximum index of the bounding box of `shape` along the i-axis (vertical-axis, 1st-axis).

# Examples
```julia-repl
julia> get_i_max(Line(Point(9, 5), Point(24, 28)))
24
```
"""
function get_i_max end

"""
    get_j_min(shape)

Return the minimum index of the bounding box of `shape` along the j-axis (horizontal-axis, 2nd-axis).

# Examples
```julia-repl
julia> get_j_min(Line(Point(9, 5), Point(24, 28)))
5
```
"""
function get_j_min end

"""
    get_j_max(shape)

Return the maximum index of the bounding box of `shape` along the j-axis (horizontal-axis, 2nd-axis).

# Examples
```julia-repl
julia> get_j_max(Line(Point(9, 5), Point(24, 28)))
28
```
"""
function get_j_max end

"""
    get_i_min(image::AbstractMatrix)

Return the first index of `image` along the i-axis (vertical-axis, 1st-axis).

# Examples
```julia-repl
julia> get_i_min(falses(32, 64))
1
```
"""
get_i_min(image::AbstractMatrix) = firstindex(image, 1)

"""
    get_i_max(image::AbstractMatrix)

Return the last index of `image` along the i-axis (vertical-axis, 1st-axis).

# Examples
```julia-repl
julia> get_i_max(falses(32, 64))
32
```
"""
get_i_max(image::AbstractMatrix) = lastindex(image, 1)

"""
    get_j_min(image::AbstractMatrix)

Return the first index of `image` along the j-axis (horizontal-axis, 2nd-axis).

# Examples
```julia-repl
julia> get_j_min(falses(32, 64))
1
```
"""
get_j_min(image::AbstractMatrix) = firstindex(image, 2)

"""
    get_j_max(image::AbstractMatrix)

Return the last index of `image` along the j-axis (horizontal-axis, 2nd-axis).

# Examples
```julia-repl
julia> get_j_max(falses(32, 64))
64
```
"""
get_j_max(image::AbstractMatrix) = lastindex(image, 2)

"""
    get_i_extrema(x)

Return the minimum and maximum index of `x` (a shape or an image) along the i-axis (vertical-axis, 1st-axis).

# Examples
```julia-repl
julia> get_i_extrema(Line(Point(9, 5), Point(24, 28)))
(9, 24)

julia> get_i_extrema(falses(32, 64))
(1, 32)
```
"""
get_i_extrema(x) = (get_i_min(x), get_i_max(x))

"""
    get_j_extrema(x)

Return the minimum and maximum index of `x` (a shape or an image) along the j-axis (horizontal-axis, 2nd-axis).

# Examples
```julia-repl
julia> get_j_extrema(Line(Point(9, 5), Point(24, 28)))
(5, 28)

julia> get_j_extrema(falses(32, 64))
(1, 64)
```
"""
get_j_extrema(x) = (get_j_min(x), get_j_max(x))

"""
    get_height(x)

Return the height of `x` (a shape or an image) along the i-axis (vertical-axis, 1st-axis).

# Examples
```julia-repl
julia> get_height(Line(Point(9, 5), Point(24, 28)))
16

julia> get_height(falses(32, 64))
32
```
"""
function get_height(shape)
    i_min, i_max = get_i_extrema(shape)
    return i_max - i_min + one(i_min)
end

"""
    get_width(x)

Return the width of `x` (a shape or an image) along the j-axis (horizontal-axis, 2nd-axis).

# Examples
```julia-repl
julia> get_width(Line(Point(9, 5), Point(24, 28)))
24

julia> get_width(falses(32, 64))
64
```
"""
function get_width(shape)
    j_min, j_max = get_j_extrema(shape)
    return j_max - j_min + one(j_min)
end

"""
    get_position(x)

Return a `Point` corresponding to the position of the top-left corner of `x` (a shape or an image).

# Examples
```julia-repl
julia> get_position(Line(Point(9, 5), Point(24, 28)))
Point{Int64}(9, 5)

julia> get_position(falses(32, 64))
Point{Int64}(1, 1)
```
"""
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

"""
    move_i(shape, i)

Return the shape obtained by translating `shape` by `i` pixels along the i-axis (vertical-axis).

# Examples
```julia-repl
julia> move_i(Line(Point(9, 5), Point(24, 28)), 2)
Line{Int64}(Point{Int64}(11, 5), Point{Int64}(26, 28))
```
"""
function move_i end

"""
    move_j(shape, j)

Return the shape obtained by translating `shape` by `j` pixels along the j-axis (horizontal-axis).

# Examples
```julia-repl
julia> move_j(Line(Point(9, 5), Point(24, 28)), 3)
Line{Int64}(Point{Int64}(9, 8), Point{Int64}(24, 31))
```
"""
function move_j end

"""
    move(shape::AbstractShape, i, j)

Return the shape obtained by translating `shape` by `i` pixels along the i-axis (vertical-axis) and `j` pixels along the j-axis (horizontal-axis).

# Examples
```julia-repl
julia> move(Line(Point(9, 5), Point(24, 28)), 2, 3)
Line{Int64}(Point{Int64}(11, 8), Point{Int64}(26, 31))
```
"""
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
