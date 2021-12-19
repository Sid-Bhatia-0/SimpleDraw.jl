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

function is_outbounds(shape::AbstractRectangle, image::AbstractMatrix)
    position = shape.position
    height = shape.height
    width = shape.width

    I = typeof(height)

    i_min = position.i
    j_min = position.j

    i_max = i_min + height - one(I)
    j_max = j_min + width - one(I)

    i_min_image = firstindex(image, 1)
    i_max_image = lastindex(image, 1)

    j_min_image = firstindex(image, 2)
    j_max_image = lastindex(image, 2)

    return i_max < i_min_image || i_min > i_max_image || j_max < j_min_image || j_min > j_max_image
end

function is_inbounds(shape::AbstractRectangle, image::AbstractMatrix)
    position = shape.position
    height = shape.height
    width = shape.width

    I = typeof(height)

    i_min = position.i
    j_min = position.j

    i_max = i_min + height - one(I)
    j_max = j_min + width - one(I)

    i_min_image = firstindex(image, 1)
    i_max_image = lastindex(image, 1)

    j_min_image = firstindex(image, 2)
    j_max_image = lastindex(image, 2)

    return i_min >= i_min_image && j_min >= j_min_image && i_max <= i_max_image && j_max <= j_max_image
end

get_bounding_box(shape::AbstractRectangle) = Rectangle(shape.position, shape.height, shape.width)

#####
##### Rectangle
#####

function draw!(image::AbstractMatrix, shape::Rectangle, color)
    @assert is_valid(shape) "Cannot draw invalid shape $(shape)"

    if is_inbounds(shape, image)
        _draw!(put_pixel_unchecked!, image, shape, color)
    else
        _draw!(put_pixel!, image, shape, color)
    end

    return nothing
end

function _draw!(f::Function, image::AbstractMatrix, shape::Rectangle, color)
    position = shape.position
    height = shape.height
    width = shape.width

    I = typeof(height)

    i_min = position.i
    j_min = position.j

    i_max = i_min + height - one(I)
    j_max = j_min + width - one(I)

    j_min_plus_1 = j_min + one(I)
    j_max_minus_1 = j_max - one(I)

    _draw!(f, image, VerticalLine(i_min, i_max, j_min), color)
    _draw!(f, image, HorizontalLine(i_min, j_min_plus_1, j_max_minus_1), color)
    _draw!(f, image, HorizontalLine(i_max, j_min_plus_1, j_max_minus_1), color)
    _draw!(f, image, VerticalLine(i_min, i_max, j_max), color)

    return nothing
end

get_bounding_box(shape::Rectangle) = shape

#####
##### FilledRectangle
#####

function clip(shape::FilledRectangle, image::AbstractMatrix)
    position = shape.position
    height = shape.height
    width = shape.width

    I = typeof(height)

    i_min = position.i
    j_min = position.j

    i_max = i_min + height - one(I)
    j_max = j_min + width - one(I)

    i_min_image = firstindex(image, 1)
    i_max_image = lastindex(image, 1)

    j_min_image = firstindex(image, 2)
    j_max_image = lastindex(image, 2)

    if i_min < i_min_image
        i_min = i_min_image
    end

    if i_max > i_max_image
        i_max = i_max_image
    end

    if j_min < j_min_image
        j_min = j_min_image
    end

    if j_max > j_max_image
        j_max = j_max_image
    end

    return FilledRectangle(Point(i_min, j_min), i_max - i_min + one(I), j_max - j_min + one(I))
end

function draw!(image::AbstractMatrix, shape::FilledRectangle, color)
    @assert is_valid(shape) "Cannot draw invalid shape $(shape)"

    if is_outbounds(shape, image)
        return nothing
    end

    _draw!(put_pixel_unchecked!, image, clip(shape, image), color)

    return nothing
end

function _draw!(f::Function, image::AbstractMatrix, shape::FilledRectangle, color)
    position = shape.position
    height = shape.height
    width = shape.width

    I = typeof(height)

    i_min = position.i
    j_min = position.j

    i_max = i_min + height - one(I)
    j_max = j_min + width - one(I)

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

function draw!(image::AbstractMatrix, shape::ThickRectangle, color)
    @assert is_valid(shape) "Cannot draw invalid shape $(shape)"

    if is_inbounds(shape, image)
        _draw!(put_pixel_unchecked!, image, shape, color)
    else
        _draw!(put_pixel!, image, shape, color)
    end

    return nothing
end

function _draw!(f::Function, image::AbstractMatrix, shape::ThickRectangle, color)
    position = shape.position
    height = shape.height
    width = shape.width
    thickness = shape.thickness

    I = typeof(height)

    i_min = position.i
    j_min = position.j

    i_max = i_min + height - one(I)
    j_max = j_min + width - one(I)

    j_min_plus_thickness = j_min + thickness
    width_minus_twice_thickness = width - convert(I, 2) * thickness

    _draw!(f, image, FilledRectangle(position, height, thickness), color)
    _draw!(f, image, FilledRectangle(Point(i_min, j_min_plus_thickness), thickness, width_minus_twice_thickness), color)
    _draw!(f, image, FilledRectangle(Point(i_min + height - thickness, j_min_plus_thickness), thickness, width_minus_twice_thickness), color)
    _draw!(f, image, FilledRectangle(Point(i_min, j_min + width - thickness), height, thickness), color)

    return nothing
end
