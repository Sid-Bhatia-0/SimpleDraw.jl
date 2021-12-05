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

struct OddSymmetricVerticalLines8{I <: Integer} <: AbstractShape
    center::Point{I}
    point::Point{I}
end

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

function draw!(image::AbstractMatrix, shape::OddSymmetricVerticalLines8, color)
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

function _draw!(image::AbstractMatrix, shape::OddSymmetricVerticalLines8, color)
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

@inline function draw_octant_reflections_lines!(image::AbstractMatrix, i_center, j_center, i, j_inner, j_outer, color)
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

@inline function draw_octant_reflections_lines_unchecked!(image::AbstractMatrix, i_center, j_center, i, j_inner, j_outer, color)
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

@inline function draw_octant_reflections_lines_even_unchecked!(image::AbstractMatrix, i_center, j_center, i, j_inner, j_outer, color)
    one_value = one(i_center)
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

    if i_min >= i_min_image && j_min >= j_min_image && i_max <= i_max_image && j_max <= j_max_image
        draw_unchecked!(image, shape, color)
        return nothing
    end

    radius = diameter ÷ 2 # d = 1 and d = 2 cases have been take care of above
    i = zero_value
    j = radius
    i_center = i_position + radius
    j_center = j_position + radius

    if iseven(diameter)
        draw!(image, EvenSymmetricPoints8(Point(i_center, j_center), Point(i, j)), color)
    else
        draw!(image, OddSymmetricPoints8(Point(i_center, j_center), Point(i, j)), color)
    end

    constant = convert(I, 3) - convert(I, 2) * radius * radius

    while j >= i
        d = convert(I, 2) * j * j + convert(I, 2) * i * i + convert(I, 4) * i - convert(I, 2) * j + constant

        i += one_value

        if d > zero_value
            j -= one_value
        end

        if iseven(diameter)
            draw!(image, EvenSymmetricPoints8(Point(i_center, j_center), Point(i, j)), color)
        else
            draw!(image, OddSymmetricPoints8(Point(i_center, j_center), Point(i, j)), color)
        end
    end

    return nothing
end

function draw_unchecked!(image::AbstractMatrix, shape::Circle{I}, color) where {I}
    position = shape.position
    i_position = position.i
    j_position = position.j
    diameter = shape.diameter

    zero_value = zero(I)
    one_value = one(I)

    radius = diameter ÷ 2
    i = zero_value
    j = radius
    i_center = i_position + radius
    j_center = j_position + radius

    if iseven(diameter)
        _draw!(image, EvenSymmetricPoints8(Point(i_center, j_center), Point(i, j)), color)
    else
        _draw!(image, OddSymmetricPoints8(Point(i_center, j_center), Point(i, j)), color)
    end

    constant = convert(I, 3) - convert(I, 2) * radius * radius

    while j >= i
        d = convert(I, 2) * j * j + convert(I, 2) * i * i + convert(I, 4) * i - convert(I, 2) * j + constant

        i += one_value

        if d > zero_value
            j -= one_value
        end

        if iseven(diameter)
            _draw!(image, EvenSymmetricPoints8(Point(i_center, j_center), Point(i, j)), color)
        else
            _draw!(image, OddSymmetricPoints8(Point(i_center, j_center), Point(i, j)), color)
        end
    end

    return nothing
end

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

    if i_min >= i_min_image && j_min >= j_min_image && i_max <= i_max_image && j_max <= j_max_image
        draw_unchecked!(image, shape, color)
        return nothing
    end

    radius = diameter ÷ 2 # d = 1 and d = 2 cases have been take care of above
    i = zero_value
    j = radius
    i_center = i_position + radius
    j_center = j_position + radius

    if iseven(diameter)
        draw!(image, EvenSymmetricVerticalLines4(Point(i_center, j_center), Point(i, j)), color)
    else
        draw!(image, OddSymmetricVerticalLines8(Point(i_center, j_center), Point(i, j)), color)
    end

    constant = convert(I, 3) - convert(I, 2) * radius * radius

    while j >= i
        d = convert(I, 2) * j * j + convert(I, 2) * i * i + convert(I, 4) * i - convert(I, 2) * j + constant

        i += one_value

        if d > zero_value
            j -= one_value
        end

        if iseven(diameter)
            draw!(image, EvenSymmetricVerticalLines4(Point(i_center, j_center), Point(i, j)), color)
        else
            draw!(image, OddSymmetricVerticalLines8(Point(i_center, j_center), Point(i, j)), color)
        end
    end

    return nothing
end

function draw_unchecked!(image::AbstractMatrix, shape::FilledCircle{I}, color) where {I}
    position = shape.position
    i_position = position.i
    j_position = position.j
    diameter = shape.diameter

    zero_value = zero(I)
    one_value = one(I)

    radius = diameter ÷ 2
    i = zero_value
    j = radius
    i_center = i_position + radius
    j_center = j_position + radius

    if iseven(diameter)
        _draw!(image, EvenSymmetricVerticalLines4(Point(i_center, j_center), Point(i, j)), color)
    else
        _draw!(image, OddSymmetricVerticalLines8(Point(i_center, j_center), Point(i, j)), color)
    end

    constant = convert(I, 3) - convert(I, 2) * radius * radius

    while j >= i
        d = convert(I, 2) * j * j + convert(I, 2) * i * i + convert(I, 4) * i - convert(I, 2) * j + constant

        i += one_value

        if d > zero_value
            j -= one_value
        end

        if iseven(diameter)
            _draw!(image, EvenSymmetricVerticalLines4(Point(i_center, j_center), Point(i, j)), color)
        else
            _draw!(image, OddSymmetricVerticalLines8(Point(i_center, j_center), Point(i, j)), color)
        end
    end

    return nothing
end

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
        draw_unchecked!(image, shape, color)
        return nothing
    end

    # radius_inner = radius_outer - thickness + one_value
    radius = diameter ÷ 2
    i_center = i_position + radius
    j_center = j_position + radius

    i_position_inner = i_position + thickness - one_value
    j_position_inner = j_position + thickness - one_value
    diameter_inner = diameter - convert(I, 2) * (thickness - one_value)
    radius_outer = radius
    radius_inner = diameter_inner ÷ 2

    i_inner = zero_value
    j_inner = radius_inner

    i_outer = zero_value
    j_outer = radius_outer

    draw_octant_reflections_lines!(image, i_center, j_center, i_outer, j_inner, j_outer, color)

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

        draw_octant_reflections_lines!(image, i_center, j_center, i_outer, j_inner, j_outer, color)
    end

    while j_outer >= i_outer
        d_outer = convert(I, 2) * j_outer * j_outer + convert(I, 2) * i_outer * i_outer + convert(I, 4) * i_outer - convert(I, 2) * j_outer + constant_outer

        i_outer += one_value

        if d_outer > zero_value
            j_outer -= one_value
        end

        i = min(i_outer, j_outer)

        draw_octant_reflections_lines!(image, i_center, j_center, i, i_outer, j_outer, color)
    end

    return nothing
end

function draw_unchecked!(image::AbstractMatrix, shape::ThickCircle{I}, color) where {I}
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

    i_position_inner = i_position + thickness - one_value
    j_position_inner = j_position + thickness - one_value
    diameter_inner = diameter - convert(I, 2) * (thickness - one_value)
    radius_outer = radius
    radius_inner = diameter_inner ÷ 2

    i_inner = zero_value
    j_inner = radius_inner

    i_outer = zero_value
    j_outer = radius_outer

    if iseven(diameter)
        draw_octant_reflections_lines_even_unchecked!(image, i_center, j_center, i_outer, j_inner, j_outer, color)
    else
        draw_octant_reflections_lines_unchecked!(image, i_center, j_center, i_outer, j_inner, j_outer, color)
    end

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

        if iseven(diameter)
            draw_octant_reflections_lines_even_unchecked!(image, i_center, j_center, i_outer, j_inner, j_outer, color)
        else
            draw_octant_reflections_lines_unchecked!(image, i_center, j_center, i_outer, j_inner, j_outer, color)
        end
    end

    while j_outer >= i_outer
        d_outer = convert(I, 2) * j_outer * j_outer + convert(I, 2) * i_outer * i_outer + convert(I, 4) * i_outer - convert(I, 2) * j_outer + constant_outer

        i_outer += one_value

        if d_outer > zero_value
            j_outer -= one_value
        end

        i = min(i_outer, j_outer)

        if iseven(diameter)
            draw_octant_reflections_lines_even_unchecked!(image, i_center, j_center, i, i_outer, j_outer, color)
        else
            draw_octant_reflections_lines_unchecked!(image, i_center, j_center, i, i_outer, j_outer, color)
        end
    end

    return nothing
end

get_bounding_box(shape::Circle) = Rectangle(shape.position, shape.diameter, shape.diameter)

get_bounding_box(shape::ThickCircle) = get_bounding_box(Circle(shape.position, shape.diameter))

get_bounding_box(shape::FilledCircle) = get_bounding_box(Circle(shape.position, shape.diameter))
