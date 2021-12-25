abstract type AbstractRectangle <: AbstractShape end

struct Rectangle{I <: Integer} <: AbstractRectangle
    position::Point{I}
    height::I
    width::I
end

struct FilledRectangle{I <: Integer} <: AbstractRectangle
    position::Point{I}
    height::I
    width::I
end

struct ThickRectangle{I <: Integer} <: AbstractRectangle
    position::Point{I}
    height::I
    width::I
    thickness::I
end

#####
##### AbstractRectangle
#####

is_valid(shape::AbstractRectangle) = shape.height > zero(shape.height) && shape.width > zero(shape.width)

get_i_min(shape::AbstractRectangle) = shape.position.i
get_i_max(shape::AbstractRectangle) = shape.position.i + shape.height - one(shape.height)

get_j_min(shape::AbstractRectangle) = shape.position.j
get_j_max(shape::AbstractRectangle) = shape.position.j + shape.width - one(shape.width)

get_drawing_optimization_style(::AbstractRectangle) = CHECK_BOUNDS

#####
##### Rectangle
#####

function draw!(f::Function, image::AbstractMatrix, shape::Rectangle, color)
    @assert is_valid(shape) "Cannot draw invalid shape $(shape)"

    i_min, i_max = get_i_extrema(shape)
    j_min, j_max = get_j_extrema(shape)

    draw!(f, image, VerticalLine(i_min, i_max, j_min), color)
    draw!(f, image, HorizontalLine(i_min, j_min, j_max), color)
    draw!(f, image, HorizontalLine(i_max, j_min, j_max), color)
    draw!(f, image, VerticalLine(i_min, i_max, j_max), color)

    return nothing
end

#####
##### FilledRectangle
#####

function clip(shape::FilledRectangle, image::AbstractMatrix)
    i_min_shape, i_max_shape = get_i_extrema(shape)
    i_min_image, i_max_image = get_i_extrema(image)

    I = typeof(i_min_shape)

    j_min_shape, j_max_shape = get_j_extrema(shape)
    j_min_image, j_max_image = get_j_extrema(image)

    i_min = max(i_min_shape, i_min_image)
    i_max = min(i_max_shape, i_max_image)

    j_min = max(j_min_shape, j_min_image)
    j_max = min(j_max_shape, j_max_image)

    return FilledRectangle(Point(i_min, j_min), i_max - i_min + one(I), j_max - j_min + one(I))
end

get_drawing_optimization_style(::FilledRectangle) = CLIP

function draw!(f::Function, image::AbstractMatrix, shape::FilledRectangle, color)
    @assert is_valid(shape) "Cannot draw invalid shape $(shape)"

    i_min, i_max = get_i_extrema(shape)
    j_min, j_max = get_j_extrema(shape)

    for j in j_min:j_max
        for i in i_min:i_max
            f(image, i, j, color)
        end
    end

    return nothing
end

#####
##### ThickRectangle
#####

function is_valid(shape::ThickRectangle)
    height = shape.height
    width = shape.width
    thickness = shape.thickness

    I = typeof(height)

    return height > zero(I) && width > zero(I) && thickness > zero(I) && thickness <= min(height, width)
end

function draw!(f::Function, image::AbstractMatrix, shape::ThickRectangle, color)
    @assert is_valid(shape) "Cannot draw invalid shape $(shape)"

    position = shape.position
    height = shape.height
    width = shape.width
    thickness = shape.thickness

    i_min = position.i
    j_min = position.j

    draw!(f, image, FilledRectangle(position, height, thickness), color)
    draw!(f, image, FilledRectangle(position, thickness, width), color)
    draw!(f, image, FilledRectangle(Point(i_min + height - thickness, j_min), thickness, width), color)
    draw!(f, image, FilledRectangle(Point(i_min, j_min + width - thickness), height, thickness), color)

    return nothing
end
