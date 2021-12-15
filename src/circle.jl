abstract type AbstractCircle <: AbstractShape end

struct EvenSymmetricPoints8{I <: Integer} <: AbstractShape
    center::Point{I}
    point::Point{I}
end

struct OddSymmetricPoints8{I <: Integer} <: AbstractShape
    center::Point{I}
    point::Point{I}
end

struct EvenSymmetricVerticalLines4{I <: Integer} <: AbstractShape
    center::Point{I}
    point::Point{I}
end

struct OddSymmetricVerticalLines4{I <: Integer} <: AbstractShape
    center::Point{I}
    point::Point{I}
end

struct EvenSymmetricLines8{I <: Integer} <: AbstractShape
    center::Point{I}
    i::I
    j_inner::I
    j_outer::I
end

struct OddSymmetricLines8{I <: Integer} <: AbstractShape
    center::Point{I}
    i::I
    j_inner::I
    j_outer::I
end

struct Circle{I <: Integer} <: AbstractCircle
    position::Point{I}
    diameter::I
end

struct OddCircle{I <: Integer} <: AbstractCircle
    position::Point{I}
    diameter::I
end

struct EvenCircle{I <: Integer} <: AbstractCircle
    position::Point{I}
    diameter::I
end

struct FilledCircle{I <: Integer} <: AbstractCircle
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

struct ThickCircle{I <: Integer} <: AbstractCircle
    position::Point{I}
    diameter::I
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

#####
##### EvenSymmetricPoints8
#####

function draw!(image::AbstractMatrix, shape::EvenSymmetricPoints8, color)
    _draw!(put_pixel!, image, shape, color)
    return nothing
end

_draw!(image::AbstractMatrix, shape::EvenSymmetricPoints8, color) = _draw!(put_pixel_unchecked!, image, shape, color)

function _draw!(f::Function, image::AbstractMatrix, shape::EvenSymmetricPoints8, color)
    center = shape.center
    point = shape.point

    i_center = center.i
    j_center = center.j
    i = point.i
    j = point.j

    I = typeof(i_center)
    one_value = one(I)

    f(image, i_center - i, j_center - j, color)
    f(image, i_center + i - one_value, j_center - j, color)
    f(image, i_center - j, j_center - i, color)
    f(image, i_center + j - one_value, j_center - i, color)
    f(image, i_center - j, j_center + i - one_value, color)
    f(image, i_center + j - one_value, j_center + i - one_value, color)
    f(image, i_center - i, j_center + j - one_value, color)
    f(image, i_center + i - one_value, j_center + j - one_value, color)

    return nothing
end

#####
##### OddSymmetricPoints8
#####

function draw!(image::AbstractMatrix, shape::OddSymmetricPoints8, color)
    _draw!(put_pixel!, image, shape, color)
    return nothing
end

_draw!(image::AbstractMatrix, shape::OddSymmetricPoints8, color) = _draw!(put_pixel_unchecked!, image, shape, color)

function _draw!(f::Function, image::AbstractMatrix, shape::OddSymmetricPoints8, color)
    center = shape.center
    point = shape.point

    i_center = center.i
    j_center = center.j
    i = point.i
    j = point.j

    f(image, i_center - i, j_center - j, color)
    f(image, i_center + i, j_center - j, color)
    f(image, i_center - j, j_center - i, color)
    f(image, i_center + j, j_center - i, color)
    f(image, i_center - j, j_center + i, color)
    f(image, i_center + j, j_center + i, color)
    f(image, i_center - i, j_center + j, color)
    f(image, i_center + i, j_center + j, color)

    return nothing
end

#####
##### EvenSymmetricVerticalLines4
#####

function draw!(image::AbstractMatrix, shape::EvenSymmetricVerticalLines4, color)
    center = shape.center
    point = shape.point

    i_center = center.i
    j_center = center.j
    i = point.i
    j = point.j

    I = typeof(i_center)
    one_value = one(I)

    draw!(image, VerticalLine(i_center - i, i_center + i - one_value, j_center - j), color)
    draw!(image, VerticalLine(i_center - j, i_center + j - one_value, j_center - i), color)
    draw!(image, VerticalLine(i_center - j, i_center + j - one_value, j_center + i - one_value), color)
    draw!(image, VerticalLine(i_center - i, i_center + i - one_value, j_center + j - one_value), color)

    return nothing
end

function _draw!(image::AbstractMatrix, shape::EvenSymmetricVerticalLines4, color)
    center = shape.center
    point = shape.point

    i_center = center.i
    j_center = center.j
    i = point.i
    j = point.j

    I = typeof(i_center)
    one_value = one(I)

    _draw!(image, VerticalLine(i_center - i, i_center + i - one_value, j_center - j), color)
    _draw!(image, VerticalLine(i_center - j, i_center + j - one_value, j_center - i), color)
    _draw!(image, VerticalLine(i_center - j, i_center + j - one_value, j_center + i - one_value), color)
    _draw!(image, VerticalLine(i_center - i, i_center + i - one_value, j_center + j - one_value), color)

    return nothing
end

#####
##### OddSymmetricVerticalLines4
#####

function draw!(image::AbstractMatrix, shape::OddSymmetricVerticalLines4, color)
    center = shape.center
    point = shape.point

    i_center = center.i
    j_center = center.j
    i = point.i
    j = point.j

    draw!(image, VerticalLine(i_center - i, i_center + i, j_center - j), color)
    draw!(image, VerticalLine(i_center - j, i_center + j, j_center - i), color)
    draw!(image, VerticalLine(i_center - j, i_center + j, j_center + i), color)
    draw!(image, VerticalLine(i_center - i, i_center + i, j_center + j), color)

    return nothing
end

function _draw!(image::AbstractMatrix, shape::OddSymmetricVerticalLines4, color)
    center = shape.center
    point = shape.point

    i_center = center.i
    j_center = center.j
    i = point.i
    j = point.j

    _draw!(image, VerticalLine(i_center - i, i_center + i, j_center - j), color)
    _draw!(image, VerticalLine(i_center - j, i_center + j, j_center - i), color)
    _draw!(image, VerticalLine(i_center - j, i_center + j, j_center + i), color)
    _draw!(image, VerticalLine(i_center - i, i_center + i, j_center + j), color)

    return nothing
end

#####
##### EvenSymmetricLines8
#####

function draw!(image::AbstractMatrix, shape::EvenSymmetricLines8, color)
    center = shape.center
    i = shape.i
    j_inner = shape.j_inner
    j_outer = shape.j_outer

    i_center = center.i
    j_center = center.j

    I = typeof(i_center)
    one_value = one(I)

    draw!(image, HorizontalLine(i_center - i, j_center - j_outer, j_center - j_inner), color)
    draw!(image, HorizontalLine(i_center + i - one_value, j_center - j_outer, j_center - j_inner), color)
    draw!(image, VerticalLine(i_center - j_outer, i_center - j_inner, j_center - i), color)
    draw!(image, VerticalLine(i_center + j_inner - one_value, i_center + j_outer - one_value, j_center - i), color)
    draw!(image, VerticalLine(i_center - j_outer, i_center - j_inner, j_center + i - one_value), color)
    draw!(image, VerticalLine(i_center + j_inner - one_value, i_center + j_outer - one_value, j_center + i - one_value), color)
    draw!(image, HorizontalLine(i_center - i, j_center + j_inner - one_value, j_center + j_outer - one_value), color)
    draw!(image, HorizontalLine(i_center + i - one_value, j_center + j_inner - one_value, j_center + j_outer - one_value), color)

    return nothing
end

function _draw!(image::AbstractMatrix, shape::EvenSymmetricLines8, color)
    center = shape.center
    i = shape.i
    j_inner = shape.j_inner
    j_outer = shape.j_outer

    i_center = center.i
    j_center = center.j

    I = typeof(i_center)
    one_value = one(I)

    _draw!(image, HorizontalLine(i_center - i, j_center - j_outer, j_center - j_inner), color)
    _draw!(image, HorizontalLine(i_center + i - one_value, j_center - j_outer, j_center - j_inner), color)
    _draw!(image, VerticalLine(i_center - j_outer, i_center - j_inner, j_center - i), color)
    _draw!(image, VerticalLine(i_center + j_inner - one_value, i_center + j_outer - one_value, j_center - i), color)
    _draw!(image, VerticalLine(i_center - j_outer, i_center - j_inner, j_center + i - one_value), color)
    _draw!(image, VerticalLine(i_center + j_inner - one_value, i_center + j_outer - one_value, j_center + i - one_value), color)
    _draw!(image, HorizontalLine(i_center - i, j_center + j_inner - one_value, j_center + j_outer - one_value), color)
    _draw!(image, HorizontalLine(i_center + i - one_value, j_center + j_inner - one_value, j_center + j_outer - one_value), color)

    return nothing
end

#####
##### OddSymmetricLines8
#####

function draw!(image::AbstractMatrix, shape::OddSymmetricLines8, color)
    center = shape.center
    i = shape.i
    j_inner = shape.j_inner
    j_outer = shape.j_outer

    i_center = center.i
    j_center = center.j

    draw!(image, HorizontalLine(i_center - i, j_center - j_outer, j_center - j_inner), color)
    draw!(image, HorizontalLine(i_center + i, j_center - j_outer, j_center - j_inner), color)
    draw!(image, VerticalLine(i_center - j_outer, i_center - j_inner, j_center - i), color)
    draw!(image, VerticalLine(i_center + j_inner, i_center + j_outer, j_center - i), color)
    draw!(image, VerticalLine(i_center - j_outer, i_center - j_inner, j_center + i), color)
    draw!(image, VerticalLine(i_center + j_inner, i_center + j_outer, j_center + i), color)
    draw!(image, HorizontalLine(i_center - i, j_center + j_inner, j_center + j_outer), color)
    draw!(image, HorizontalLine(i_center + i, j_center + j_inner, j_center + j_outer), color)

    return nothing
end

function _draw!(image::AbstractMatrix, shape::OddSymmetricLines8, color)
    center = shape.center
    i = shape.i
    j_inner = shape.j_inner
    j_outer = shape.j_outer

    i_center = center.i
    j_center = center.j

    _draw!(image, HorizontalLine(i_center - i, j_center - j_outer, j_center - j_inner), color)
    _draw!(image, HorizontalLine(i_center + i, j_center - j_outer, j_center - j_inner), color)
    _draw!(image, VerticalLine(i_center - j_outer, i_center - j_inner, j_center - i), color)
    _draw!(image, VerticalLine(i_center + j_inner, i_center + j_outer, j_center - i), color)
    _draw!(image, VerticalLine(i_center - j_outer, i_center - j_inner, j_center + i), color)
    _draw!(image, VerticalLine(i_center + j_inner, i_center + j_outer, j_center + i), color)
    _draw!(image, HorizontalLine(i_center - i, j_center + j_inner, j_center + j_outer), color)
    _draw!(image, HorizontalLine(i_center + i, j_center + j_inner, j_center + j_outer), color)

    return nothing
end

#####
##### AbstractCircle
#####

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
##### Circle
#####

function draw!(image::AbstractMatrix, shape::Circle, color)
    @assert is_valid(shape) "Cannot draw invalid shape $(shape)"

    position = shape.position
    diameter = shape.diameter

    if iseven(diameter)
        draw!(image, EvenCircle(position, diameter), color)
    else
        draw!(image, OddCircle(position, diameter), color)
    end

    return nothing
end

function _draw!(image::AbstractMatrix, shape::Circle, color)
    position = shape.position
    diameter = shape.diameter

    i_position = position.i
    j_position = position.j

    I = typeof(i_position)

    radius = diameter ÷ convert(I, 2)
    center = Point(i_position + radius, j_position + radius)

    if iseven(diameter)
        _draw!((image, i, j, color) -> _draw!(image, EvenSymmetricPoints8(center, Point(i, j)), color), image, shape, color)
    else
        _draw!((image, i, j, color) -> _draw!(image, OddSymmetricPoints8(center, Point(i, j)), color), image, shape, color)
    end

    return nothing
end

#####
##### OddCircle
#####

is_valid(shape::OddCircle) = isodd(shape.diameter) && shape.diameter > zero(shape.diameter)

function draw!(image::AbstractMatrix, shape::OddCircle, color)
    @assert is_valid(shape) "Cannot draw invalid shape $(shape)"

    if is_outbounds(shape, image)
        return nothing
    end

    position = shape.position
    diameter = shape.diameter

    I = typeof(diameter)

    if diameter == one(I)
        draw!(image, position, color)
        return nothing
    end

    i_position = position.i
    j_position = position.j

    radius = diameter ÷ convert(I, 2)
    center = Point(i_position + radius, j_position + radius)

    if is_inbounds(shape, image)
        _draw!((image, i, j, color) -> _draw!(image, OddSymmetricPoints8(center, Point(i, j)), color), image, shape, color)
    else
        _draw!((image, i, j, color) -> draw!(image, OddSymmetricPoints8(center, Point(i, j)), color), image, shape, color)
    end

    return nothing
end

function _draw!(image::AbstractMatrix, shape::OddCircle, color)
    position = shape.position
    diameter = shape.diameter

    i_position = position.i
    j_position = position.j

    I = typeof(i_position)

    radius = diameter ÷ convert(I, 2)
    i_center = i_position + radius
    j_center = j_position + radius
    center = Point(i_center, j_center)

    f = (image, i, j, color) -> _draw!(image, OddSymmetricPoints8(center, Point(i, j)), color)

    _draw!(f, image, shape, color)

    return nothing
end

function _draw!(f::Function, image::AbstractMatrix, shape::OddCircle, color)
    position = shape.position
    diameter = shape.diameter

    I = typeof(diameter)

    radius = diameter ÷ convert(I, 2)

    i = zero(I)
    j = radius

    f(image, i, j, color)

    constant = convert(I, 3) - convert(I, 2) * radius * radius

    while j >= i
        d = convert(I, 2) * j * j + convert(I, 2) * i * i + convert(I, 4) * i - convert(I, 2) * j + constant

        i += one(I)

        if d > zero(I)
            j -= one(I)
        end

        f(image, i, j, color)
    end

    return nothing
end

#####
##### EvenCircle
#####

is_valid(shape::EvenCircle) = iseven(shape.diameter) && shape.diameter > zero(shape.diameter)

function draw!(image::AbstractMatrix, shape::EvenCircle, color)
    @assert is_valid(shape) "Cannot draw invalid shape $(shape)"

    if is_outbounds(shape, image)
        return nothing
    end

    position = shape.position
    diameter = shape.diameter

    I = typeof(diameter)

    i_position = position.i
    j_position = position.j

    if diameter == convert(I, 2)
        i_position_plus_1 = i_position + one_value
        j_position_plus_1 = j_position + one_value
        draw!(image, position, color)
        draw!(image, Point(i_position_plus_1, j_position), color)
        draw!(image, Point(i_position, j_position_plus_1), color)
        draw!(image, Point(i_position_plus_1, j_position_plus_1), color)
        return nothing
    end

    radius = diameter ÷ convert(I, 2)
    center = Point(i_position + radius, j_position + radius)

    if is_inbounds(shape, image)
        _draw!((image, i, j, color) -> _draw!(image, EvenSymmetricPoints8(center, Point(i, j)), color), image, shape, color)
    else
        _draw!((image, i, j, color) -> draw!(image, EvenSymmetricPoints8(center, Point(i, j)), color), image, shape, color)
    end

    return nothing
end

function _draw!(image::AbstractMatrix, shape::EvenCircle, color)
    position = shape.position
    diameter = shape.diameter

    i_position = position.i
    j_position = position.j

    I = typeof(i_position)

    radius = diameter ÷ convert(I, 2)
    center = Point(i_position + radius, j_position + radius)

    f = (image, i, j, color) -> _draw!(image, EvenSymmetricPoints8(center, Point(i, j)), color)

    _draw!(f, image, shape, color)

    return nothing
end

function _draw!(f::Function, image::AbstractMatrix, shape::EvenCircle, color)
    position = shape.position
    diameter = shape.diameter

    I = typeof(diameter)

    radius = diameter ÷ convert(I, 2)

    i = zero(I)
    j = radius

    constant = convert(I, 3) - convert(I, 2) * radius * radius

    while j >= i
        d = convert(I, 2) * j * j + convert(I, 2) * i * i + convert(I, 4) * i - convert(I, 2) * j + constant

        i += one(I)

        if d > zero(I)
            j -= one(I)
        end

        f(image, i, j, color)
    end

    return nothing
end

#####
##### FilledCircle
#####

function draw!(image::AbstractMatrix, shape::FilledCircle, color)
    @assert is_valid(shape) "Cannot draw invalid shape $(shape)"

    position = shape.position
    diameter = shape.diameter

    if iseven(diameter)
        draw!(image, EvenFilledCircle(position, diameter), color)
    else
        draw!(image, OddFilledCircle(position, diameter), color)
    end

    return nothing
end

function _draw!(image::AbstractMatrix, shape::FilledCircle, color)
    position = shape.position
    diameter = shape.diameter

    i_position = position.i
    j_position = position.j

    I = typeof(i_position)

    radius = diameter ÷ convert(I, 2)
    center = Point(i_position + radius, j_position + radius)

    if iseven(diameter)
        _draw!(image, EvenCircle(position, diameter), color) do image, i, j, color
            _draw!(image, EvenSymmetricVerticalLines4(center, Point(i, j)), color)
        end
    else
        _draw!(image, OddCircle(position, diameter), color) do image, i, j, color
            _draw!(image, OddSymmetricVerticalLines4(center, Point(i, j)), color)
        end
    end

    return nothing
end

#####
##### OddFilledCircle
#####

is_valid(shape::OddFilledCircle) = is_valid(OddCircle(shape.position, shape.diameter))

function draw!(image::AbstractMatrix, shape::OddFilledCircle, color)
    @assert is_valid(shape) "Cannot draw invalid shape $(shape)"

    position = shape.position
    diameter = shape.diameter

    I = typeof(diameter)

    if diameter == one(I)
        draw!(image, position, color)
        return nothing
    end

    i_position = position.i
    j_position = position.j

    radius = diameter ÷ convert(I, 2)
    center = Point(i_position + radius, j_position + radius)

    if is_inbounds(shape, image)
        _draw!(image, OddCircle(position, diameter), color) do image, i, j, color
            _draw!(image, OddSymmetricVerticalLines4(center, Point(i, j)), color)
        end
    else
        _draw!(image, OddCircle(position, diameter), color) do image, i, j, color
            draw!(image, OddSymmetricVerticalLines4(center, Point(i, j)), color)
        end
    end

    return nothing
end

function _draw!(image::AbstractMatrix, shape::OddFilledCircle, color)
    position = shape.position
    diameter = shape.diameter

    I = typeof(i_position)

    i_position = position.i
    j_position = position.j

    radius = diameter ÷ convert(I, 2)
    center = Point(i_position + radius, j_position + radius)

    _draw!(image, OddCircle(position, diameter), color) do image, i, j, color
        _draw!(image, OddSymmetricVerticalLines4(center, Point(i, j)), color)
    end

    return nothing
end

#####
##### EvenFilledCircle
#####

is_valid(shape::EvenFilledCircle) = is_valid(EvenCircle(shape.position, shape.diameter))

function draw!(image::AbstractMatrix, shape::EvenFilledCircle, color)
    @assert is_valid(shape) "Cannot draw invalid shape $(shape)"

    position = shape.position
    diameter = shape.diameter

    I = typeof(diameter)

    i_position = position.i
    j_position = position.j

    if diameter == convert(I, 2)
        i_position_plus_1 = i_position + one_value
        j_position_plus_1 = j_position + one_value
        draw!(image, position, color)
        draw!(image, Point(i_position_plus_1, j_position), color)
        draw!(image, Point(i_position, j_position_plus_1), color)
        draw!(image, Point(i_position_plus_1, j_position_plus_1), color)
        return nothing
    end

    radius = diameter ÷ convert(I, 2)
    center = Point(i_position + radius, j_position + radius)

    if is_inbounds(shape, image)
        _draw!(image, EvenCircle(position, diameter), color) do image, i, j, color
            _draw!(image, EvenSymmetricVerticalLines4(center, Point(i, j)), color)
        end
    else
        _draw!(image, EvenCircle(position, diameter), color) do image, i, j, color
            draw!(image, EvenSymmetricVerticalLines4(center, Point(i, j)), color)
        end
    end

    return nothing
end

function _draw!(image::AbstractMatrix, shape::EvenFilledCircle, color)
    position = shape.position
    diameter = shape.diameter

    I = typeof(i_position)

    i_position = position.i
    j_position = position.j

    radius = diameter ÷ convert(I, 2)
    center = Point(i_position + radius, j_position + radius)

    _draw!(image, EvenCircle(position, diameter), color) do image, i, j, color
        _draw!(image, EvenSymmetricVerticalLines4(center, Point(i, j)), color)
    end

    return nothing
end

#####
##### ThickCircle
#####

function is_valid(shape::ThickCircle)
    diameter = shape.diameter
    thickness = shape.thickness

    I = typeof(shape.diameter)
    radius = diameter ÷ convert(I, 2)

    if iseven(diameter)
        return diameter > zero(I) && thickness > zero(I) && thickness <= radius
    else
        return diameter > zero(I) && thickness > zero(I) && thickness <= radius + one(I)
    end
end

function draw!(image::AbstractMatrix, shape::ThickCircle, color)
    position = shape.position
    i_position = position.i
    j_position = position.j
    diameter = shape.diameter
    diameter_outer = diameter
    thickness = shape.thickness

    I = typeof(i_position)
    zero_value = zero(I)
    one_value = one(I)

    @assert is_valid(shape) "Cannot draw invalid shape $(shape)"

    i_min = i_position
    j_min = j_position

    diameter_minus_1 = diameter - one_value
    i_max = i_position + diameter_minus_1
    j_max = j_position + diameter_minus_1

    i_min_image = firstindex(image, 1)
    i_max_image = lastindex(image, 1)

    j_min_image = firstindex(image, 2)
    j_max_image = lastindex(image, 2)

    if i_max < i_min_image || i_min > i_max_image || j_max < j_min_image || j_min > j_max_image
        return nothing
    end

    if diameter == one_value
        draw!(image, position, color)
        return nothing
    end

    if thickness == one_value
        draw!(image, Circle(position, diameter), color)
        return nothing
    end

    if diameter == convert(I, 2)
        i_position_plus_1 = i_position + one_value
        j_position_plus_1 = j_position + one_value
        draw!(image, position, color)
        draw!(image, Point(i_position_plus_1, j_position), color)
        draw!(image, Point(i_position, j_position_plus_1), color)
        draw!(image, Point(i_position_plus_1, j_position_plus_1), color)
        return nothing
    end

    if convert(I, 2) * thickness + one_value == diameter
        draw!(image, FilledCircle(position, diameter), color)
        return nothing
    end

    if i_min >= i_min_image && j_min >= j_min_image && i_max <= i_max_image && j_max <= j_max_image
        if iseven(diameter)
            f = (image, i_center, j_center, i, j_inner, j_outer, color) -> _draw!(image, EvenSymmetricLines8(Point(i_center, j_center), i, j_inner, j_outer), color)
        else
            f = (image, i_center, j_center, i, j_inner, j_outer, color) -> _draw!(image, OddSymmetricLines8(Point(i_center, j_center), i, j_inner, j_outer), color)
        end
    else
        if iseven(diameter)
            f = (image, i_center, j_center, i, j_inner, j_outer, color) -> draw!(image, EvenSymmetricLines8(Point(i_center, j_center), i, j_inner, j_outer), color)
        else
            f = (image, i_center, j_center, i, j_inner, j_outer, color) -> draw!(image, OddSymmetricLines8(Point(i_center, j_center), i, j_inner, j_outer), color)
        end
    end

    _draw!(f, image, shape, color)

    return nothing
end

function _draw!(image::AbstractMatrix, shape::ThickCircle, color)
    position = shape.position
    i_position = position.i
    j_position = position.j
    diameter = shape.diameter

    I = typeof(i_position)
    radius = diameter ÷ convert(I, 2)
    i_center = i_position + radius
    j_center = j_position + radius
    center = Point(i_center, j_center)

    if iseven(diameter)
        f = (image, _, _, i, j_inner, j_outer, color) -> _draw!(image, EvenSymmetricLines8(center, i, j_inner, j_outer), color)
    else
        f = (image, _, _, i, j_inner, j_outer, color) -> _draw!(image, OddSymmetricLines8(center, i, j_inner, j_outer), color)
    end

    _draw!(f, image, shape, color)

    return nothing
end

function _draw!(f::Function, image::AbstractMatrix, shape::ThickCircle, color)
    position = shape.position
    i_position = position.i
    j_position = position.j
    diameter = shape.diameter
    thickness = shape.thickness

    I = typeof(i_position)
    zero_value = zero(I)
    one_value = one(I)

    radius = diameter ÷ 2
    i_center = i_position + radius
    j_center = j_position + radius
    center = Point(i_center, j_center)

    i_position_inner = i_position + thickness - one_value
    j_position_inner = j_position + thickness - one_value
    diameter_inner = diameter - convert(I, 2) * (thickness - one_value)
    radius_outer = radius
    radius_inner = diameter_inner ÷ 2

    i_inner = zero_value
    j_inner = radius_inner

    i_outer = zero_value
    j_outer = radius_outer

    f(image, i_center, j_center, i_outer, j_inner, j_outer, color)

    constant_inner = convert(I, 3) - convert(I, 2) * radius_inner * radius_inner
    constant_outer = convert(I, 3) - convert(I, 2) * radius_outer * radius_outer

    while j_inner >= i_inner
        d_inner = convert(I, 2) * j_inner * j_inner + convert(I, 2) * i_inner * i_inner + convert(I, 4) * i_inner - convert(I, 2) * j_inner + constant_inner
        d_outer = convert(I, 2) * j_outer * j_outer + convert(I, 2) * i_outer * i_outer + convert(I, 4) * i_outer - convert(I, 2) * j_outer + constant_outer

        i_inner += one_value
        i_outer += one_value

        if d_inner > zero_value
            j_inner -= one_value
        end

        if d_outer > zero_value
            j_outer -= one_value
        end

        f(image, i_center, j_center, i_outer, j_inner, j_outer, color)
    end

    while j_outer >= i_outer
        d_outer = convert(I, 2) * j_outer * j_outer + convert(I, 2) * i_outer * i_outer + convert(I, 4) * i_outer - convert(I, 2) * j_outer + constant_outer

        i_outer += one_value

        if d_outer > zero_value
            j_outer -= one_value
        end

        i = min(i_outer, j_outer)

        f(image, i_center, j_center, i_outer, j_inner, j_outer, color)
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

    if is_outbounds(shape, image)
        return nothing
    end

    position = shape.position
    diameter = shape.diameter
    thickness = shape.thickness

    I = typeof(diameter)

    if diameter == one(I)
        draw!(image, position, color)
        return nothing
    end

    if thickness == one(I)
        draw!(image, OddCircle(position, diameter), color)
        return nothing
    end

    if convert(I, 2) * thickness + one(I) >= diameter
        draw!(image, OddFilledCircle(position, diameter), color)
        return nothing
    end

    if is_inbounds(shape, image)
        _draw!(image, shape, color) do image, i_center, j_center, i, j_inner, j_outer, color
             _draw!(image, OddSymmetricLines8(Point(i_center, j_center), i, j_inner, j_outer), color)
        end
    else
        _draw!(image, shape, color) do image, i_center, j_center, i, j_inner, j_outer, color
             draw!(image, OddSymmetricLines8(Point(i_center, j_center), i, j_inner, j_outer), color)
        end
    end

    return nothing
end

function _draw!(image::AbstractMatrix, shape::ThickCircle, color)
    position = shape.position
    diameter = shape.diameter

    I = typeof(diameter)

    i_position = position.i
    j_position = position.j

    radius = diameter ÷ convert(I, 2)
    center = Point(i_position + radius, j_position + radius)

    _draw!(f, image, shape, color) do image, _, _, i, j_inner, j_outer, color
        _draw!(image, OddSymmetricLines8(center, i, j_inner, j_outer), color)
    end

    return nothing
end

function _draw!(f::Function, image::AbstractMatrix, shape::OddThickCircle, color)
    position = shape.position
    diameter = shape.diameter
    thickness = shape.thickness

    I = typeof(diameter)

    i_position = position.i
    j_position = position.j

    radius = diameter ÷ convert(I, 2)

    i_center = i_position + radius
    j_center = j_position + radius
    center = Point(i_center, j_center)

    i_position_inner = i_position + thickness - one(I)
    j_position_inner = j_position + thickness - one(I)

    diameter_inner = diameter - convert(I, 2) * (thickness - one(I))
    radius_outer = radius
    radius_inner = diameter_inner ÷ convert(I, 2)

    i_inner = zero(I)
    j_inner = radius_inner

    i_outer = zero(I)
    j_outer = radius_outer

    f(image, i_center, j_center, i_outer, j_inner, j_outer, color)

    constant_inner = convert(I, 3) - convert(I, 2) * radius_inner * radius_inner
    constant_outer = convert(I, 3) - convert(I, 2) * radius_outer * radius_outer

    while j_inner >= i_inner
        d_inner = convert(I, 2) * j_inner * j_inner + convert(I, 2) * i_inner * i_inner + convert(I, 4) * i_inner - convert(I, 2) * j_inner + constant_inner
        d_outer = convert(I, 2) * j_outer * j_outer + convert(I, 2) * i_outer * i_outer + convert(I, 4) * i_outer - convert(I, 2) * j_outer + constant_outer

        i_inner += one(I)
        i_outer += one(I)

        if d_inner > zero(I)
            j_inner -= one(I)
        end

        if d_outer > zero(I)
            j_outer -= one(I)
        end

        f(image, i_center, j_center, i_outer, j_inner, j_outer, color)
    end

    while j_outer >= i_outer
        d_outer = convert(I, 2) * j_outer * j_outer + convert(I, 2) * i_outer * i_outer + convert(I, 4) * i_outer - convert(I, 2) * j_outer + constant_outer

        i_outer += one(I)

        if d_outer > zero(I)
            j_outer -= one(I)
        end

        f(image, i_center, j_center, i_outer, j_inner, j_outer, color)
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

    if is_outbounds(shape, image)
        return nothing
    end

    position = shape.position
    diameter = shape.diameter
    thickness = shape.thickness

    I = typeof(diameter)

    if diameter == convert(I, 2)
        i_position_plus_1 = i_position + one_value
        j_position_plus_1 = j_position + one_value
        draw!(image, position, color)
        draw!(image, Point(i_position_plus_1, j_position), color)
        draw!(image, Point(i_position, j_position_plus_1), color)
        draw!(image, Point(i_position_plus_1, j_position_plus_1), color)
        return nothing
    end

    if thickness == one(I)
        draw!(image, EvenCircle(position, diameter), color)
        return nothing
    end

    if convert(I, 2) * thickness == diameter
        draw!(image, EvenFilledCircle(position, diameter), color)
        return nothing
    end

    if is_inbounds(shape, image)
        _draw!(image, shape, color) do image, i_center, j_center, i, j_inner, j_outer, color
             _draw!(image, EvenSymmetricLines8(Point(i_center, j_center), i, j_inner, j_outer), color)
        end
    else
        _draw!(image, shape, color) do image, i_center, j_center, i, j_inner, j_outer, color
             draw!(image, EvenSymmetricLines8(Point(i_center, j_center), i, j_inner, j_outer), color)
        end
    end

    return nothing
end

function _draw!(image::AbstractMatrix, shape::EvenThickCircle, color)
    position = shape.position
    diameter = shape.diameter

    I = typeof(diameter)

    i_position = position.i
    j_position = position.j

    radius = diameter ÷ convert(I, 2)
    center = Point(i_position + radius, j_position + radius)

    _draw!(image, shape, color) do image, _, _, i, j_inner, j_outer, color
        _draw!(image, EvenSymmetricLines8(center, i, j_inner, j_outer), color)
    end

    return nothing
end

function _draw!(f::Function, image::AbstractMatrix, shape::EvenThickCircle, color)
    position = shape.position
    diameter = shape.diameter
    thickness = shape.thickness

    I = typeof(diameter)

    i_position = position.i
    j_position = position.j

    radius = diameter ÷ convert(I, 2)

    i_center = i_position + radius
    j_center = j_position + radius
    center = Point(i_center, j_center)

    i_position_inner = i_position + thickness - one(I)
    j_position_inner = j_position + thickness - one(I)

    diameter_inner = diameter - convert(I, 2) * (thickness - one(I))
    radius_outer = radius
    radius_inner = diameter_inner ÷ convert(I, 2)

    i_inner = zero(I)
    j_inner = radius_inner

    i_outer = zero(I)
    j_outer = radius_outer

    f(image, i_center, j_center, i_outer, j_inner, j_outer, color)

    constant_inner = convert(I, 3) - convert(I, 2) * radius_inner * radius_inner
    constant_outer = convert(I, 3) - convert(I, 2) * radius_outer * radius_outer

    while j_inner >= i_inner
        d_inner = convert(I, 2) * j_inner * j_inner + convert(I, 2) * i_inner * i_inner + convert(I, 4) * i_inner - convert(I, 2) * j_inner + constant_inner
        d_outer = convert(I, 2) * j_outer * j_outer + convert(I, 2) * i_outer * i_outer + convert(I, 4) * i_outer - convert(I, 2) * j_outer + constant_outer

        i_inner += one(I)
        i_outer += one(I)

        if d_inner > zero(I)
            j_inner -= one(I)
        end

        if d_outer > zero(I)
            j_outer -= one(I)
        end

        f(image, i_center, j_center, i_outer, j_inner, j_outer, color)
    end

    while j_outer >= i_outer
        d_outer = convert(I, 2) * j_outer * j_outer + convert(I, 2) * i_outer * i_outer + convert(I, 4) * i_outer - convert(I, 2) * j_outer + constant_outer

        i_outer += one(I)

        if d_outer > zero(I)
            j_outer -= one(I)
        end

        f(image, i_center, j_center, i_outer, j_inner, j_outer, color)
    end

    return nothing
end
