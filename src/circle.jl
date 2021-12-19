abstract type AbstractCircle <: AbstractShape end

struct OddSymmetricPoints8{I <: Integer} <: AbstractShape
    center::Point{I}
    point::Point{I}
end

struct EvenSymmetricPoints8{I <: Integer} <: AbstractShape
    center::Point{I}
    point::Point{I}
end

struct OddSymmetricVerticalLines4{I <: Integer} <: AbstractShape
    center::Point{I}
    point::Point{I}
end

struct EvenSymmetricVerticalLines4{I <: Integer} <: AbstractShape
    center::Point{I}
    point::Point{I}
end

struct OddSymmetricLines8{I <: Integer} <: AbstractShape
    center::Point{I}
    i_inner::I
    i_outer::I
    j::I
end

struct EvenSymmetricLines8{I <: Integer} <: AbstractShape
    center::Point{I}
    i_inner::I
    i_outer::I
    j::I
end

struct CircleOctant{I <: Integer} <: AbstractShape
    center::Point{I}
    radius::I
end

struct OddCircle{I <: Integer} <: AbstractCircle
    position::Point{I}
    diameter::I
end

struct EvenCircle{I <: Integer} <: AbstractCircle
    position::Point{I}
    diameter::I
end

struct Circle{I <: Integer} <: AbstractCircle
    position::Point{I}
    diameter::I
end

struct OddFilledCircle{I <: Integer} <: AbstractCircle
    position::Point{I}
    diameter::I
end

struct EvenFilledCircle{I <: Integer} <: AbstractCircle
    position::Point{I}
    diameter::I
end

struct FilledCircle{I <: Integer} <: AbstractCircle
    position::Point{I}
    diameter::I
end

struct ThickCircleOctant{I <: Integer} <: AbstractShape
    center::Point{I}
    radius::I
    thickness::I
end

struct OddThickCircle{I <: Integer} <: AbstractCircle
    position::Point{I}
    diameter::I
    thickness::I
end

struct EvenThickCircle{I <: Integer} <: AbstractCircle
    position::Point{I}
    diameter::I
    thickness::I
end

struct ThickCircle{I <: Integer} <: AbstractCircle
    position::Point{I}
    diameter::I
    thickness::I
end

#####
##### OddSymmetricPoints8
#####

draw!(image::AbstractMatrix, shape::OddSymmetricPoints8, color) = _draw!(put_pixel!, image, shape, color)

function _draw!(f::Function, image::AbstractMatrix, shape::OddSymmetricPoints8, color)
    center = shape.center
    point = shape.point

    i_center = center.i
    j_center = center.j
    i = point.i
    j = point.j

    i_diff = i - i_center
    j_diff = j - j_center

    f(image, i_center - j_diff, j_center - i_diff, color)
    f(image, i_center + j_diff, j_center - i_diff, color)
    f(image, i_center - i_diff, j_center - j_diff, color)
    f(image, i_center + i_diff, j_center - j_diff, color)
    f(image, i_center - i_diff, j_center + j_diff, color)
    f(image, i, j, color)
    f(image, i_center - j_diff, j_center + i_diff, color)
    f(image, i_center + j_diff, j_center + i_diff, color)

    return nothing
end

#####
##### EvenSymmetricPoints8
#####

draw!(image::AbstractMatrix, shape::EvenSymmetricPoints8, color) = _draw!(put_pixel!, image, shape, color)

function _draw!(f::Function, image::AbstractMatrix, shape::EvenSymmetricPoints8, color)
    center = shape.center
    point = shape.point

    i_center = center.i
    j_center = center.j
    i = point.i
    j = point.j

    I = typeof(i_center)
    i_diff = i - i_center
    j_diff = j - j_center

    f(image, i_center - j_diff, j_center - i_diff, color)
    f(image, i_center + j_diff - one(I), j_center - i_diff, color)
    f(image, i_center - i_diff, j_center - j_diff, color)
    f(image, i_center + i_diff - one(I), j_center - j_diff, color)
    f(image, i_center - i_diff, j_center + j_diff - one(I), color)
    f(image, i - one(I), j - one(I), color)
    f(image, i_center - j_diff, j_center + i_diff - one(I), color)
    f(image, i_center + j_diff - one(I), j_center + i_diff - one(I), color)

    return nothing
end

#####
##### OddSymmetricVerticalLines4
#####

draw!(image::AbstractMatrix, shape::OddSymmetricVerticalLines4, color) = _draw!(put_pixel!, image, shape, color)

function _draw!(f::Function, image::AbstractMatrix, shape::OddSymmetricVerticalLines4, color)
    center = shape.center
    point = shape.point

    i_center = center.i
    j_center = center.j
    i = point.i
    j = point.j

    i_diff = i - i_center
    j_diff = j - j_center

    _draw!(f, image, VerticalLine(i_center - j_diff, i_center + j_diff, j_center - i_diff), color)
    _draw!(f, image, VerticalLine(i_center - i_diff, i_center + i_diff, j_center - j_diff), color)
    _draw!(f, image, VerticalLine(i_center - i_diff, i_center + i_diff, j_center + j_diff), color)
    _draw!(f, image, VerticalLine(i_center - j_diff, i_center + j_diff, j_center + i_diff), color)

    return nothing
end

#####
##### EvenSymmetricVerticalLines4
#####

draw!(image::AbstractMatrix, shape::EvenSymmetricVerticalLines4, color) = _draw!(put_pixel!, image, shape, color)

function _draw!(f::Function, image::AbstractMatrix, shape::EvenSymmetricVerticalLines4, color)
    center = shape.center
    point = shape.point

    i_center = center.i
    j_center = center.j
    i = point.i
    j = point.j

    I = typeof(i_center)

    i_diff = i - i_center
    j_diff = j - j_center

    _draw!(f, image, VerticalLine(i_center - j_diff, i_center + j_diff - one(I), j_center - i_diff), color)
    _draw!(f, image, VerticalLine(i_center - i_diff, i_center + i_diff - one(I), j_center - j_diff), color)
    _draw!(f, image, VerticalLine(i_center - i_diff, i_center + i_diff - one(I), j_center + j_diff - one(I)), color)
    _draw!(f, image, VerticalLine(i_center - j_diff, i_center + j_diff - one(I), j_center + i_diff - one(I)), color)

    return nothing
end

#####
##### OddSymmetricLines8
#####

draw!(image::AbstractMatrix, shape::OddSymmetricLines8, color) = _draw!(put_pixel!, image, shape, color)

function _draw!(f::Function, image::AbstractMatrix, shape::OddSymmetricLines8, color)
    center = shape.center
    i_inner = shape.i_inner
    i_outer = shape.i_outer
    j = shape.j

    i_center = center.i
    j_center = center.j

    i_inner_relative = i_inner - i_center
    i_outer_relative = i_outer - i_center
    j_relative = j - j_center

    _draw!(f, image, HorizontalLine(i_center - j_relative, j_center - i_outer_relative, j_center - i_inner_relative), color)
    _draw!(f, image, HorizontalLine(i_center + j_relative, j_center - i_outer_relative, j_center - i_inner_relative), color)
    _draw!(f, image, VerticalLine(i_center - i_outer_relative, i_center - i_inner_relative, j_center - j_relative), color)
    _draw!(f, image, VerticalLine(i_center + i_inner_relative, i_center + i_outer_relative, j_center - j_relative), color)
    _draw!(f, image, VerticalLine(i_center - i_outer_relative, i_center - i_inner_relative, j_center + j_relative), color)
    _draw!(f, image, VerticalLine(i_center + i_inner_relative, i_center + i_outer_relative, j_center + j_relative), color)
    _draw!(f, image, HorizontalLine(i_center - j_relative, j_center + i_inner_relative, j_center + i_outer_relative), color)
    _draw!(f, image, HorizontalLine(i_center + j_relative, j_center + i_inner_relative, j_center + i_outer_relative), color)

    return nothing
end

#####
##### EvenSymmetricLines8
#####

draw!(image::AbstractMatrix, shape::EvenSymmetricLines8, color) = _draw!(put_pixel!, image, shape, color)

function _draw!(f::Function, image::AbstractMatrix, shape::EvenSymmetricLines8, color)
    center = shape.center
    i_inner = shape.i_inner
    i_outer = shape.i_outer
    j = shape.j

    I = typeof(i_inner)

    i_center = center.i
    j_center = center.j

    i_inner_relative = i_inner - i_center
    i_outer_relative = i_outer - i_center
    j_relative = j - j_center

    _draw!(f, image, HorizontalLine(i_center - j_relative, j_center - i_outer_relative, j_center - i_inner_relative), color)
    _draw!(f, image, HorizontalLine(i_center + j_relative - one(I), j_center - i_outer_relative, j_center - i_inner_relative), color)
    _draw!(f, image, VerticalLine(i_center - i_outer_relative, i_center - i_inner_relative, j_center - j_relative), color)
    _draw!(f, image, VerticalLine(i_center + i_inner_relative - one(I), i_center + i_outer_relative - one(I), j_center - j_relative), color)
    _draw!(f, image, VerticalLine(i_center - i_outer_relative, i_center - i_inner_relative, j_center + j_relative - one(I)), color)
    _draw!(f, image, VerticalLine(i_center + i_inner_relative - one(I), i_center + i_outer_relative - one(I), j_center + j_relative - one(I)), color)
    _draw!(f, image, HorizontalLine(i_center - j_relative, j_center + i_inner_relative - one(I), j_center + i_outer_relative - one(I)), color)
    _draw!(f, image, HorizontalLine(i_center + j_relative - one(I), j_center + i_inner_relative - one(I), j_center + i_outer_relative - one(I)), color)

    return nothing
end

#####
##### AbstractCircle
#####

get_radius(shape::AbstractCircle) = shape.diameter ÷ oftype(shape.diameter, 2)

function get_center(shape::AbstractCircle, radius)
    i_position = shape.position.i
    j_position = shape.position.j
    return Point(i_position + radius, j_position + radius)
end

get_center(shape::AbstractCircle) = get_center(shape, get_radius(shape))

function get_center_radius(shape::AbstractCircle)
    radius = get_radius(shape)
    center = get_center(shape, radius)
    return (center, radius)
end

is_valid(shape::AbstractCircle) = shape.diameter > zero(shape.diameter)

function is_outbounds(shape::AbstractCircle, image::AbstractMatrix)
    position = shape.position
    diameter = shape.diameter

    I = typeof(diameter)

    i_min = position.i
    j_min = position.j

    diameter_minus_1 = diameter - one(I)
    i_max = i_min + diameter_minus_1
    j_max = j_min + diameter_minus_1

    i_min_image = firstindex(image, 1)
    i_max_image = lastindex(image, 1)

    j_min_image = firstindex(image, 2)
    j_max_image = lastindex(image, 2)

    return i_max < i_min_image || i_min > i_max_image || j_max < j_min_image || j_min > j_max_image
end

function is_inbounds(shape::AbstractCircle, image::AbstractMatrix)
    position = shape.position
    diameter = shape.diameter

    I = typeof(diameter)

    i_min = position.i
    j_min = position.j

    diameter_minus_1 = diameter - one(I)
    i_max = i_min + diameter_minus_1
    j_max = j_min + diameter_minus_1

    i_min_image = firstindex(image, 1)
    i_max_image = lastindex(image, 1)

    j_min_image = firstindex(image, 2)
    j_max_image = lastindex(image, 2)

    return i_min >= i_min_image && j_min >= j_min_image && i_max <= i_max_image && j_max <= j_max_image
end

get_bounding_box(shape::AbstractCircle) = Rectangle(shape.position, shape.diameter, shape.diameter)

#####
##### CircleOctant
#####

draw!(image::AbstractMatrix, shape::CircleOctant, color) = _draw!(put_pixel!, image, shape, color)

function _draw!(f::Function, image::AbstractMatrix, shape::CircleOctant, color)
    center = shape.center
    radius = shape.radius

    I = typeof(radius)

    i_center = center.i
    j_center = center.j

    i = radius
    j = zero(I)

    f(image, i_center + i, j_center + j, color)

    constant = convert(I, 3) - convert(I, 2) * radius * radius

    while i > j + one(I)
        d = convert(I, 2) * i * i + convert(I, 2) * j * j + convert(I, 4) * j - convert(I, 2) * i + constant

        j += one(I)

        if d > zero(I)
            i -= one(I)
        end

        f(image, i_center + i, j_center + j, color)
    end

    return nothing
end

#####
##### OddCircle
#####

is_valid(shape::OddCircle) = isodd(shape.diameter) && shape.diameter > zero(shape.diameter)

function draw!(image::AbstractMatrix, shape::OddCircle, color)
    @assert is_valid(shape) "Cannot draw invalid shape $(shape)"

    if is_inbounds(shape, image)
        _draw!(put_pixel_unchecked!, image, shape, color)
    else
        _draw!(put_pixel!, image, shape, color)
    end

    return nothing
end

function _draw!(f::Function, image::AbstractMatrix, shape::OddCircle, color)
    position = shape.position
    diameter = shape.diameter

    I = typeof(diameter)

    center, radius = get_center_radius(shape)

    _draw!(image, CircleOctant(center, radius), color) do image, i, j, color
        _draw!(f, image, OddSymmetricPoints8(center, Point(i, j)), color)
    end

    return nothing
end

#####
##### EvenCircle
#####

is_valid(shape::EvenCircle) = iseven(shape.diameter) && shape.diameter > zero(shape.diameter)

function draw!(image::AbstractMatrix, shape::EvenCircle, color)
    @assert is_valid(shape) "Cannot draw invalid shape $(shape)"

    if is_inbounds(shape, image)
        _draw!(put_pixel_unchecked!, image, shape, color)
    else
        _draw!(put_pixel!, image, shape, color)
    end

    return nothing
end

function _draw!(f::Function, image::AbstractMatrix, shape::EvenCircle, color)
    position = shape.position
    diameter = shape.diameter

    I = typeof(diameter)

    center, radius = get_center_radius(shape)

    _draw!(image, CircleOctant(center, radius), color) do image, i, j, color
        _draw!(f, image, EvenSymmetricPoints8(center, Point(i, j)), color)
    end

    return nothing
end

#####
##### Circle
#####

function draw!(image::AbstractMatrix, shape::Circle, color)
    position = shape.position
    diameter = shape.diameter

    if iseven(diameter)
        draw!(image, EvenCircle(position, diameter), color)
    else
        draw!(image, OddCircle(position, diameter), color)
    end

    return nothing
end

function _draw!(f::Function, image::AbstractMatrix, shape::Circle, color)
    position = shape.position
    diameter = shape.diameter

    if iseven(diameter)
        _draw!(f, image, EvenCircle(position, diameter), color)
    else
        _draw!(f, image, OddCircle(position, diameter), color)
    end

    return nothing
end

#####
##### OddFilledCircle
#####

is_valid(shape::OddFilledCircle) = is_valid(OddCircle(shape.position, shape.diameter))

function draw!(image::AbstractMatrix, shape::OddFilledCircle, color)
    @assert is_valid(shape) "Cannot draw invalid shape $(shape)"

    if is_inbounds(shape, image)
        _draw!(put_pixel_unchecked!, image, shape, color)
    else
        _draw!(put_pixel!, image, shape, color)
    end

    return nothing
end

function _draw!(f::Function, image::AbstractMatrix, shape::OddFilledCircle, color)
    position = shape.position
    diameter = shape.diameter

    center, radius = get_center_radius(shape)

    _draw!(image, CircleOctant(center, radius), color) do image, i, j, color
        _draw!(f, image, OddSymmetricVerticalLines4(center, Point(i, j)), color)
    end

    return nothing
end

#####
##### EvenFilledCircle
#####

is_valid(shape::EvenFilledCircle) = is_valid(EvenCircle(shape.position, shape.diameter))

function draw!(image::AbstractMatrix, shape::EvenFilledCircle, color)
    @assert is_valid(shape) "Cannot draw invalid shape $(shape)"

    if is_inbounds(shape, image)
        _draw!(put_pixel_unchecked!, image, shape, color)
    else
        _draw!(put_pixel!, image, shape, color)
    end

    return nothing
end

function _draw!(f::Function, image::AbstractMatrix, shape::EvenFilledCircle, color)
    position = shape.position
    diameter = shape.diameter

    center, radius = get_center_radius(shape)

    _draw!(image, CircleOctant(center, radius), color) do image, i, j, color
        _draw!(f, image, EvenSymmetricVerticalLines4(center, Point(i, j)), color)
    end

    return nothing
end

#####
##### FilledCircle
#####

function draw!(image::AbstractMatrix, shape::FilledCircle, color)
    position = shape.position
    diameter = shape.diameter

    if iseven(diameter)
        draw!(image, EvenFilledCircle(position, diameter), color)
    else
        draw!(image, OddFilledCircle(position, diameter), color)
    end

    return nothing
end

function _draw!(f::Function, image::AbstractMatrix, shape::FilledCircle, color)
    position = shape.position
    diameter = shape.diameter

    if iseven(diameter)
        _draw!(f, image, EvenFilledCircle(position, diameter), color)
    else
        _draw!(f, image, OddFilledCircle(position, diameter), color)
    end

    return nothing
end

#####
##### ThickCircleOctant
#####

function is_valid(shape::ThickCircleOctant)
    center = shape.center
    radius = shape.radius
    thickness = shape.thickness

    I = typeof(radius)

    return radius >= zero(I) && thickness > zero(I) && thickness <= radius + one(I)
end

function draw!(image::AbstractMatrix, shape::ThickCircleOctant, color)
    @assert is_valid(shape) "Cannot draw invalid shape $(shape)"

    if is_inbounds(shape, image)
        _draw!(put_pixel_unchecked!, image, shape, color)
    else
        _draw!(put_pixel!, image, shape, color)
    end

    return nothing
end

function _draw!(f::Function, image::AbstractMatrix, shape::ThickCircleOctant, color)
    center = shape.center
    radius = shape.radius
    thickness = shape.thickness

    I = typeof(radius)

    i_center = center.i
    j_center = center.j

    radius_inner = radius - thickness + one(I)
    radius_outer = radius

    i_inner = radius_inner
    j_inner = zero(I)

    i_outer = radius_outer
    j_outer = zero(I)

    constant_inner = convert(I, 3) - convert(I, 2) * radius_inner * radius_inner
    constant_outer = convert(I, 3) - convert(I, 2) * radius_outer * radius_outer

    f(image, i_center + i_inner, j_center + j_inner, i_center + i_outer, j_center + j_outer, color)

    while i_inner > j_inner + one(I)
        d_inner = convert(I, 2) * i_inner * i_inner + convert(I, 2) * j_inner * j_inner + convert(I, 4) * j_inner - convert(I, 2) * i_inner + constant_inner
        d_outer = convert(I, 2) * i_outer * i_outer + convert(I, 2) * j_outer * j_outer + convert(I, 4) * j_outer - convert(I, 2) * i_outer + constant_outer

        j_inner += one(I)
        j_outer += one(I)

        if d_inner > zero(I)
            i_inner -= one(I)
        end

        if d_outer > zero(I)
            i_outer -= one(I)
        end

        f(image, i_center + i_inner, j_center + j_inner, i_center + i_outer, j_center + j_outer, color)
    end

    while i_outer > j_outer + one(I)
        d_outer = convert(I, 2) * i_outer * i_outer + convert(I, 2) * j_outer * j_outer + convert(I, 4) * j_outer - convert(I, 2) * i_outer + constant_outer

        j_outer += one(I)

        if d_outer > zero(I)
            i_outer -= one(I)
        end

        f(image, i_center + j_outer, j_center + j_outer, i_center + i_outer, j_center + j_outer, color)
    end

    return nothing
end

#####
##### OddThickCircle
#####

function is_valid(shape::OddThickCircle)
    diameter = shape.diameter
    thickness = shape.thickness

    I = typeof(shape.diameter)

    return isodd(diameter) && diameter > zero(I) && thickness > zero(I) && convert(I, 2) * thickness <= diameter + one(I)
end

function draw!(image::AbstractMatrix, shape::OddThickCircle, color)
    @assert is_valid(shape) "Cannot draw invalid shape $(shape)"

    if is_inbounds(shape, image)
        _draw!(put_pixel_unchecked!, image, shape, color)
    else
        _draw!(put_pixel!, image, shape, color)
    end

    return nothing
end

function _draw!(f::Function, image::AbstractMatrix, shape::OddThickCircle, color)
    position = shape.position
    diameter = shape.diameter
    thickness = shape.thickness

    I = typeof(diameter)

    center, radius = get_center_radius(shape)

    _draw!(image, ThickCircleOctant(center, radius, thickness), color) do image, i1, j1, i2, j2, color
        _draw!(f, image, OddSymmetricLines8(center, i1, i2, j1), color)
    end

    return nothing
end

#####
##### EvenThickCircle
#####

function is_valid(shape::EvenThickCircle)
    diameter = shape.diameter
    thickness = shape.thickness

    I = typeof(shape.diameter)

    return iseven(diameter) && diameter > zero(I) && thickness > zero(I) && convert(I, 2) * thickness <= diameter
end

function draw!(image::AbstractMatrix, shape::EvenThickCircle, color)
    @assert is_valid(shape) "Cannot draw invalid shape $(shape)"

    if is_inbounds(shape, image)
        _draw!(put_pixel_unchecked!, image, shape, color)
    else
        _draw!(put_pixel!, image, shape, color)
    end

    return nothing
end

function _draw!(f::Function, image::AbstractMatrix, shape::EvenThickCircle, color)
    position = shape.position
    diameter = shape.diameter
    thickness = shape.thickness

    I = typeof(diameter)

    center, radius = get_center_radius(shape)

    _draw!(image, ThickCircleOctant(center, radius, thickness), color) do image, i1, j1, i2, j2, color
        _draw!(f, image, EvenSymmetricLines8(center, i1, i2, j1), color)
    end

    return nothing
end

#####
##### ThickCircle
#####

function is_valid(shape::ThickCircle)
    position = shape.position
    diameter = shape.diameter
    thickness = shape.thickness

    if iseven(diameter)
        return is_valid(EvenThickCircle(position, diameter, thickness))
    else
        return is_valid(OddThickCircle(position, diameter, thickness))
    end
end

function draw!(image::AbstractMatrix, shape::ThickCircle, color)
    position = shape.position
    diameter = shape.diameter
    thickness = shape.thickness

    if iseven(diameter)
        draw!(image, EvenThickCircle(position, diameter, thickness), color)
    else
        draw!(image, OddThickCircle(position, diameter, thickness), color)
    end

    return nothing
end

function _draw!(f::Function, image::AbstractMatrix, shape::ThickCircle, color)
    position = shape.position
    diameter = shape.diameter
    thickness = shape.thickness

    if iseven(diameter)
        _draw!(f, image, EvenThickCircle(position, diameter, thickness), color)
    else
        _draw!(f, image, OddThickCircle(position, diameter, thickness), color)
    end

    return nothing
end
