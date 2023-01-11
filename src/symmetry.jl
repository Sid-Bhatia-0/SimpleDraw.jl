abstract type AbstractSymmetry <: AbstractShape end

abstract type AbstractOctantSymmetry <: AbstractSymmetry end

abstract type AbstractOddOctantSymmetry <: AbstractOctantSymmetry end

abstract type AbstractEvenOctantSymmetry <: AbstractOctantSymmetry end

struct OddOctantSymmetricShape{I <: Integer, S <: AbstractShape} <: AbstractOddOctantSymmetry
    origin::Point{I}
    shape::S
end

struct EvenOctantSymmetricShape{I <: Integer, S <: AbstractShape} <: AbstractOddOctantSymmetry
    origin::Point{I}
    shape::S
end

struct OddSymmetricVerticalLines4{I <: Integer} <: AbstractSymmetry
    origin::Point{I}
    point::Point{I}
end

struct EvenSymmetricVerticalLines4{I <: Integer} <: AbstractSymmetry
    origin::Point{I}
    point::Point{I}
end

#####
##### reflections
#####

get_odd_reflection_horizontal_line(shape::Point, i) = Point(i + i - shape.i, shape.j)
get_even_reflection_horizontal_line(shape::Point, i) = Point(i + i - shape.i - one(i), shape.j)

get_odd_reflection_vertical_line(shape::Point, j) = Point(shape.i, j + j - shape.j)
get_even_reflection_vertical_line(shape::Point, j) = Point(shape.i, j + j - shape.j - one(j))

get_reflection_diagonal_line(shape::Point, i, j) = Point(i + shape.j - j, j + shape.i - i)

get_odd_reflection_horizontal_line(shape::VerticalLine, i) = VerticalLine(i + i - shape.i_max, i + i - shape.i_min, shape.j)
get_even_reflection_horizontal_line(shape::VerticalLine, i) = VerticalLine(i + i - shape.i_max - one(i), i + i - shape.i_min - one(i), shape.j)

get_odd_reflection_vertical_line(shape::VerticalLine, j) = VerticalLine(shape.i_min, shape.i_max, j + j - shape.j)
get_even_reflection_vertical_line(shape::VerticalLine, j) = VerticalLine(shape.i_min, shape.i_max, j + j - shape.j - one(j))

function get_reflection_diagonal_line(shape::VerticalLine, i, j)
    new_i = i + shape.j - j
    j_min = j + shape.i_min - i
    j_max = j + shape.i_max - i
    return HorizontalLine(new_i, j_min, j_max)
end

#####
##### AbstractOctantSymmetry
#####

is_valid(shape::AbstractOctantSymmetry) = is_valid(shape.shape)

#####
##### OddOctantSymmetricShape
#####

function get_i_min(shape::OddOctantSymmetricShape)
    origin = shape.origin
    generator = shape.shape
    generator_reflected = get_odd_reflection_horizontal_line(generator, origin.i)
    return min(get_i_min(generator), get_i_min(generator_reflected))
end

function get_i_max(shape::OddOctantSymmetricShape)
    origin = shape.origin
    generator = shape.shape
    generator_reflected = get_odd_reflection_horizontal_line(generator, origin.i)
    return max(get_i_max(generator), get_i_max(generator_reflected))
end

function get_i_extrema(shape::OddOctantSymmetricShape)
    origin = shape.origin
    generator = shape.shape
    generator_reflected = get_odd_reflection_horizontal_line(generator, origin.i)
    return (min(get_i_min(generator), get_i_min(generator_reflected)), max(get_i_max(generator), get_i_max(generator_reflected)))
end

function get_j_min(shape::OddOctantSymmetricShape)
    origin = shape.origin
    generator = shape.shape
    generator_reflected = get_odd_reflection_horizontal_line(generator, origin.j)
    return min(get_j_min(generator), get_j_min(generator_reflected))
end

function get_j_max(shape::OddOctantSymmetricShape)
    origin = shape.origin
    generator = shape.shape
    generator_reflected = get_odd_reflection_horizontal_line(generator, origin.j)
    return max(get_j_max(generator), get_j_max(generator_reflected))
end

function get_j_extrema(shape::OddOctantSymmetricShape)
    origin = shape.origin
    generator = shape.shape
    generator_reflected = get_odd_reflection_horizontal_line(generator, origin.j)
    return (min(get_j_min(generator), get_j_min(generator_reflected)), max(get_j_max(generator), get_j_max(generator_reflected)))
end

function _draw!(f::F, image, shape::OddOctantSymmetricShape{I, Point{I}}, color) where {F <: Function, I}
    # @assert is_valid(shape) "Cannot draw invalid shape $(shape)"

    origin = shape.origin
    point = shape.shape

    i_origin = origin.i
    j_origin = origin.j
    i = point.i
    j = point.j

    i_diff = i - i_origin
    j_diff = j - j_origin

    f(image, i_origin - j_diff, j_origin - i_diff, color)
    f(image, i_origin + j_diff, j_origin - i_diff, color)
    f(image, i_origin - i_diff, j_origin - j_diff, color)
    f(image, i_origin + i_diff, j_origin - j_diff, color)
    f(image, i_origin - i_diff, j_origin + j_diff, color)
    f(image, i, j, color)
    f(image, i_origin - j_diff, j_origin + i_diff, color)
    f(image, i_origin + j_diff, j_origin + i_diff, color)

    return nothing
end

function _draw!(f::F, image, shape::OddOctantSymmetricShape{I, VerticalLine{I}}, color) where {F <: Function, I}
    # @assert is_valid(shape) "Cannot draw invalid shape $(shape)"

    origin = shape.origin
    line = shape.shape

    i_origin = origin.i
    j_origin = origin.j

    i_min_line = line.i_min
    i_max_line = line.i_max
    j_line = line.j

    i_inner_relative = i_min_line - i_origin
    i_outer_relative = i_max_line - i_origin
    j_relative = j_line - j_origin

    _draw!(f, image, HorizontalLine(i_origin - j_relative, j_origin - i_outer_relative, j_origin - i_inner_relative), color)
    _draw!(f, image, HorizontalLine(i_origin + j_relative, j_origin - i_outer_relative, j_origin - i_inner_relative), color)
    _draw!(f, image, VerticalLine(i_origin - i_outer_relative, i_origin - i_inner_relative, j_origin - j_relative), color)
    _draw!(f, image, VerticalLine(i_origin + i_inner_relative, i_origin + i_outer_relative, j_origin - j_relative), color)
    _draw!(f, image, VerticalLine(i_origin - i_outer_relative, i_origin - i_inner_relative, j_origin + j_relative), color)
    _draw!(f, image, VerticalLine(i_origin + i_inner_relative, i_origin + i_outer_relative, j_origin + j_relative), color)
    _draw!(f, image, HorizontalLine(i_origin - j_relative, j_origin + i_inner_relative, j_origin + i_outer_relative), color)
    _draw!(f, image, HorizontalLine(i_origin + j_relative, j_origin + i_inner_relative, j_origin + i_outer_relative), color)

    return nothing
end

#####
##### EvenOctantSymmetricShape
#####

function get_i_min(shape::EvenOctantSymmetricShape)
    origin = shape.origin
    generator = shape.shape
    generator_reflected = get_even_reflection_horizontal_line(generator, origin.i)
    return min(get_i_min(generator), get_i_min(generator_reflected))
end

function get_i_max(shape::EvenOctantSymmetricShape)
    origin = shape.origin
    generator = shape.shape
    generator_reflected = get_even_reflection_horizontal_line(generator, origin.i)
    return max(get_i_max(generator), get_i_max(generator_reflected))
end

function get_i_extrema(shape::EvenOctantSymmetricShape)
    origin = shape.origin
    generator = shape.shape
    generator_reflected = get_even_reflection_horizontal_line(generator, origin.i)
    return (min(get_i_min(generator), get_i_min(generator_reflected)), max(get_i_max(generator), get_i_max(generator_reflected)))
end

function get_j_min(shape::EvenOctantSymmetricShape)
    origin = shape.origin
    generator = shape.shape
    generator_reflected = get_even_reflection_horizontal_line(generator, origin.j)
    return min(get_j_min(generator), get_j_min(generator_reflected))
end

function get_j_max(shape::EvenOctantSymmetricShape)
    origin = shape.origin
    generator = shape.shape
    generator_reflected = get_even_reflection_horizontal_line(generator, origin.j)
    return max(get_j_max(generator), get_j_max(generator_reflected))
end

function get_j_extrema(shape::EvenOctantSymmetricShape)
    origin = shape.origin
    generator = shape.shape
    generator_reflected = get_even_reflection_horizontal_line(generator, origin.j)
    return (min(get_j_min(generator), get_j_min(generator_reflected)), max(get_j_max(generator), get_j_max(generator_reflected)))
end

function _draw!(f::F, image, shape::EvenOctantSymmetricShape{I, Point{I}}, color) where {F <: Function, I}
    # @assert is_valid(shape) "Cannot draw invalid shape $(shape)"

    origin = shape.origin
    point = shape.shape

    i_origin = origin.i
    j_origin = origin.j
    i = point.i
    j = point.j

    i_diff = i - i_origin
    j_diff = j - j_origin

    f(image, i_origin - j_diff, j_origin - i_diff, color)
    f(image, i_origin + j_diff - one(I), j_origin - i_diff, color)
    f(image, i_origin - i_diff, j_origin - j_diff, color)
    f(image, i_origin + i_diff - one(I), j_origin - j_diff, color)
    f(image, i_origin - i_diff, j_origin + j_diff - one(I), color)
    f(image, i - one(I), j - one(I), color)
    f(image, i_origin - j_diff, j_origin + i_diff - one(I), color)
    f(image, i_origin + j_diff - one(I), j_origin + i_diff - one(I), color)

    return nothing
end

function _draw!(f::F, image, shape::EvenOctantSymmetricShape{I, VerticalLine{I}}, color) where {F <: Function, I}
    # @assert is_valid(shape) "Cannot draw invalid shape $(shape)"

    origin = shape.origin
    line = shape.shape

    i_origin = origin.i
    j_origin = origin.j

    i_min_line = line.i_min
    i_max_line = line.i_max
    j_line = line.j

    i_inner_relative = i_min_line - i_origin
    i_outer_relative = i_max_line - i_origin
    j_relative = j_line - j_origin

    _draw!(f, image, HorizontalLine(i_origin - j_relative, j_origin - i_outer_relative, j_origin - i_inner_relative), color)
    _draw!(f, image, HorizontalLine(i_origin + j_relative - one(I), j_origin - i_outer_relative, j_origin - i_inner_relative), color)
    _draw!(f, image, VerticalLine(i_origin - i_outer_relative, i_origin - i_inner_relative, j_origin - j_relative), color)
    _draw!(f, image, VerticalLine(i_origin + i_inner_relative - one(I), i_origin + i_outer_relative - one(I), j_origin - j_relative), color)
    _draw!(f, image, VerticalLine(i_origin - i_outer_relative, i_origin - i_inner_relative, j_origin + j_relative - one(I)), color)
    _draw!(f, image, VerticalLine(i_origin + i_inner_relative - one(I), i_origin + i_outer_relative - one(I), j_origin + j_relative - one(I)), color)
    _draw!(f, image, HorizontalLine(i_origin - j_relative, j_origin + i_inner_relative - one(I), j_origin + i_outer_relative - one(I)), color)
    _draw!(f, image, HorizontalLine(i_origin + j_relative - one(I), j_origin + i_inner_relative - one(I), j_origin + i_outer_relative - one(I)), color)

    return nothing
end

#####
##### OddSymmetricVerticalLines4
#####

function is_valid(shape::OddSymmetricVerticalLines4)
    origin = shape.origin
    point = shape.point

    i_origin = origin.i
    j_origin = origin.j

    i_point = point.i
    j_point = point.j

    return (i_point >= i_origin) && (j_point >= j_origin) && (i_point - i_origin >= j_point - j_origin)
end

get_i_min(shape::OddSymmetricVerticalLines4) = get_odd_reflection_horizontal_line(shape.point, shape.origin.i).i
get_i_max(shape::OddSymmetricVerticalLines4) = shape.point.i

function get_j_min(shape::OddSymmetricVerticalLines4)
    diagonally_reflected_point = get_reflection_diagonal_line(shape.point, shape.origin.i, shape.origin.j)
    return get_odd_reflection_vertical_line(diagonally_reflected_point, shape.origin.j).j
end

get_j_max(shape::OddSymmetricVerticalLines4) = get_reflection_diagonal_line(shape.point, shape.origin.i, shape.origin.j).j

function get_j_extrema(shape::OddSymmetricVerticalLines4)
    diagonally_reflected_point = get_reflection_diagonal_line(shape.point, shape.origin.i, shape.origin.j)
    return (get_odd_reflection_vertical_line(diagonally_reflected_point, shape.origin.j).j, diagonally_reflected_point.j)
end

function _draw!(f::F, image, shape::OddSymmetricVerticalLines4, color) where {F <: Function}
    # @assert is_valid(shape) "Cannot draw invalid shape $(shape)"

    origin = shape.origin
    point = shape.point

    i_origin = origin.i
    j_origin = origin.j
    i = point.i
    j = point.j

    i_diff = i - i_origin
    j_diff = j - j_origin

    _draw!(f, image, VerticalLine(i_origin - j_diff, i_origin + j_diff, j_origin - i_diff), color)
    _draw!(f, image, VerticalLine(i_origin - i_diff, i_origin + i_diff, j_origin - j_diff), color)
    _draw!(f, image, VerticalLine(i_origin - i_diff, i_origin + i_diff, j_origin + j_diff), color)
    _draw!(f, image, VerticalLine(i_origin - j_diff, i_origin + j_diff, j_origin + i_diff), color)

    return nothing
end

#####
##### EvenSymmetricVerticalLines4
#####

function is_valid(shape::EvenSymmetricVerticalLines4)
    origin = shape.origin
    point = shape.point

    i_origin = origin.i
    j_origin = origin.j

    i_point = point.i
    j_point = point.j

    return (i_point > i_origin) && (j_point >= j_origin) && (i_point - i_origin >= j_point - j_origin)
end

get_i_min(shape::EvenSymmetricVerticalLines4) = get_even_reflection_horizontal_line(shape.point, shape.origin.i).i
get_i_max(shape::EvenSymmetricVerticalLines4) = shape.point.i

function get_j_min(shape::EvenSymmetricVerticalLines4)
    diagonally_reflected_point = get_reflection_diagonal_line(shape.point, shape.origin.i, shape.origin.j)
    return get_even_reflection_vertical_line(diagonally_reflected_point, shape.origin.j).j
end

get_j_max(shape::EvenSymmetricVerticalLines4) = get_reflection_diagonal_line(shape.point, shape.origin.i, shape.origin.j).j

function get_j_extrema(shape::EvenSymmetricVerticalLines4)
    diagonally_reflected_point = get_reflection_diagonal_line(shape.point, shape.origin.i, shape.origin.j)
    return (get_even_reflection_vertical_line(diagonally_reflected_point, shape.origin.j).j, diagonally_reflected_point.j)
end

function _draw!(f::F, image, shape::EvenSymmetricVerticalLines4, color) where {F <: Function}
    # @assert is_valid(shape) "Cannot draw invalid shape $(shape)"

    origin = shape.origin
    point = shape.point

    i_origin = origin.i
    j_origin = origin.j
    i = point.i
    j = point.j

    I = typeof(i_origin)

    i_diff = i - i_origin
    j_diff = j - j_origin

    _draw!(f, image, VerticalLine(i_origin - j_diff, i_origin + j_diff - one(I), j_origin - i_diff), color)
    _draw!(f, image, VerticalLine(i_origin - i_diff, i_origin + i_diff - one(I), j_origin - j_diff), color)
    _draw!(f, image, VerticalLine(i_origin - i_diff, i_origin + i_diff - one(I), j_origin + j_diff - one(I)), color)
    _draw!(f, image, VerticalLine(i_origin - j_diff, i_origin + j_diff - one(I), j_origin + i_diff - one(I)), color)

    return nothing
end
