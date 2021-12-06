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

struct Circle{I <: Integer} <: AbstractShape
    position::Point{I}
    diameter::I
end

struct FilledCircle{I <: Integer} <: AbstractShape
    position::Point{I}
    diameter::I
end

struct ThickCircle{I <: Integer} <: AbstractShape
    position::Point{I}
    diameter::I
    thickness::I
end

#####
##### EvenSymmetricPoints8
#####

function draw!(image::AbstractMatrix, shape::EvenSymmetricPoints8{I}, color) where {I}
    _draw!(put_pixel!, image, shape, color)
    return nothing
end

_draw!(image::AbstractMatrix, shape::EvenSymmetricPoints8, color) = _draw!(put_pixel_unchecked!, image, shape, color)

function _draw!(f::Function, image::AbstractMatrix, shape::EvenSymmetricPoints8{I}, color) where {I}
    center = shape.center
    point = shape.point

    i_center = center.i
    j_center = center.j
    i = point.i
    j = point.j

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

function draw!(image::AbstractMatrix, shape::EvenSymmetricVerticalLines4{I}, color) where {I}
    center = shape.center
    point = shape.point

    i_center = center.i
    j_center = center.j
    i = point.i
    j = point.j

    one_value = one(I)

    draw!(image, VerticalLine(i_center - i, i_center + i - one_value, j_center - j), color)
    draw!(image, VerticalLine(i_center - j, i_center + j - one_value, j_center - i), color)
    draw!(image, VerticalLine(i_center - j, i_center + j - one_value, j_center + i - one_value), color)
    draw!(image, VerticalLine(i_center - i, i_center + i - one_value, j_center + j - one_value), color)

    return nothing
end

function _draw!(image::AbstractMatrix, shape::EvenSymmetricVerticalLines4{I}, color) where {I}
    center = shape.center
    point = shape.point

    i_center = center.i
    j_center = center.j
    i = point.i
    j = point.j

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

function draw!(image::AbstractMatrix, shape::EvenSymmetricLines8{I}, color) where {I}
    center = shape.center
    i = shape.i
    j_inner = shape.j_inner
    j_outer = shape.j_outer

    i_center = center.i
    j_center = center.j

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

function _draw!(image::AbstractMatrix, shape::EvenSymmetricLines8{I}, color) where {I}
    center = shape.center
    i = shape.i
    j_inner = shape.j_inner
    j_outer = shape.j_outer

    i_center = center.i
    j_center = center.j

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
##### Circle
#####

get_bounding_box(shape::Circle) = Rectangle(shape.position, shape.diameter, shape.diameter)

function draw!(image::AbstractMatrix, shape::Circle{I}, color) where {I}
    position = shape.position
    i_position = position.i
    j_position = position.j
    diameter = shape.diameter

    zero_value = zero(I)
    one_value = one(I)

    if diameter < one_value
        return nothing
    end

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
    i_center = i_position + radius
    j_center = j_position + radius
    center = Point(i_center, j_center)

    if i_min >= i_min_image && j_min >= j_min_image && i_max <= i_max_image && j_max <= j_max_image
        if iseven(diameter)
            f = (image, i, j, color) -> _draw!(image, EvenSymmetricPoints8(center, Point(i, j)), color)
        else
            f = (image, i, j, color) -> _draw!(image, OddSymmetricPoints8(center, Point(i, j)), color)
        end
    else
        if iseven(diameter)
            f = (image, i, j, color) -> draw!(image, EvenSymmetricPoints8(center, Point(i, j)), color)
        else
            f = (image, i, j, color) -> draw!(image, OddSymmetricPoints8(center, Point(i, j)), color)
        end
    end

    _draw!(f, image, shape, color)

    return nothing
end

function _draw!(image::AbstractMatrix, shape::Circle{I}, color) where {I}
    position = shape.position
    i_position = position.i
    j_position = position.j
    diameter = shape.diameter

    radius = diameter ÷ convert(I, 2)
    i_center = i_position + radius
    j_center = j_position + radius
    center = Point(i_center, j_center)

    if iseven(diameter)
        f = (image, i, j, color) -> _draw!(image, EvenSymmetricPoints8(center, Point(i, j)), color)
    else
        f = (image, i, j, color) -> _draw!(image, OddSymmetricPoints8(center, Point(i, j)), color)
    end

    _draw!(f, image, shape, color)

    return nothing
end

function _draw!(f::Function, image::AbstractMatrix, shape::Circle{I}, color) where {I}
    position = shape.position
    i_position = position.i
    j_position = position.j
    diameter = shape.diameter

    zero_value = zero(I)
    one_value = one(I)

    radius = diameter ÷ convert(I, 2)
    i_center = i_position + radius
    j_center = j_position + radius
    center = Point(i_center, j_center)

    i = zero_value
    j = radius

    f(image, i, j, color)

    constant = convert(I, 3) - convert(I, 2) * radius * radius

    while j >= i
        d = convert(I, 2) * j * j + convert(I, 2) * i * i + convert(I, 4) * i - convert(I, 2) * j + constant

        i += one_value

        if d > zero_value
            j -= one_value
        end

        f(image, i, j, color)
    end

    return nothing
end

#####
##### FilledCircle
#####

get_bounding_box(shape::FilledCircle) = get_bounding_box(Circle(shape.position, shape.diameter))

function draw!(image::AbstractMatrix, shape::FilledCircle{I}, color) where {I}
    position = shape.position
    i_position = position.i
    j_position = position.j
    diameter = shape.diameter

    zero_value = zero(I)
    one_value = one(I)

    if diameter < one_value
        return nothing
    end

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
    i_center = i_position + radius
    j_center = j_position + radius
    center = Point(i_center, j_center)

    if i_min >= i_min_image && j_min >= j_min_image && i_max <= i_max_image && j_max <= j_max_image
        if iseven(diameter)
            f = (image, i, j, color) -> _draw!(image, EvenSymmetricVerticalLines4(center, Point(i, j)), color)
        else
            f = (image, i, j, color) -> _draw!(image, OddSymmetricVerticalLines4(center, Point(i, j)), color)
        end
    else
        if iseven(diameter)
            f = (image, i, j, color) -> draw!(image, EvenSymmetricVerticalLines4(center, Point(i, j)), color)
        else
            f = (image, i, j, color) -> draw!(image, OddSymmetricVerticalLines4(center, Point(i, j)), color)
        end
    end

    _draw!(f, image, Circle(position, diameter), color)

    return nothing
end

function _draw!(image::AbstractMatrix, shape::FilledCircle{I}, color) where {I}
    position = shape.position
    i_position = position.i
    j_position = position.j
    diameter = shape.diameter

    radius = diameter ÷ convert(I, 2)
    i_center = i_position + radius
    j_center = j_position + radius
    center = Point(i_center, j_center)

    if iseven(diameter)
        f = (image, i, j, color) -> _draw!(image, EvenSymmetricVerticalLines4(center, Point(i, j)), color)
    else
        f = (image, i, j, color) -> _draw!(image, OddSymmetricVerticalLines4(center, Point(i, j)), color)
    end

    _draw!(f, image, Circle(position, diameter), color)

    return nothing
end

#####
##### ThickCircle
#####

get_bounding_box(shape::ThickCircle) = get_bounding_box(Circle(shape.position, shape.diameter))

function draw!(image::AbstractMatrix, shape::ThickCircle{I}, color) where {I}
    position = shape.position
    i_position = position.i
    j_position = position.j
    diameter = shape.diameter
    diameter_outer = diameter
    thickness = shape.thickness

    zero_value = zero(I)
    one_value = one(I)

    if diameter < one_value || thickness < one_value || convert(I, 2) * thickness + one_value > diameter
        return nothing
    end

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

function _draw!(image::AbstractMatrix, shape::ThickCircle{I}, color) where {I}
    position = shape.position
    i_position = position.i
    j_position = position.j
    diameter = shape.diameter

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

function _draw!(f::Function, image::AbstractMatrix, shape::ThickCircle{I}, color) where {I}
    position = shape.position
    i_position = position.i
    j_position = position.j
    diameter = shape.diameter
    thickness = shape.thickness

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
