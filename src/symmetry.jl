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
##### AbstractOctantSymmetry
#####

is_valid(shape::AbstractOctantSymmetry) = is_valid(shape.shape)

#####
##### OddOctantSymmetricShape
#####

draw!(image::AbstractMatrix, shape::OddOctantSymmetricShape{I, Point{I}}, color) where {I} = draw!(put_pixel!, image, shape, color)

function draw!(f::Function, image::AbstractMatrix, shape::OddOctantSymmetricShape{I, Point{I}}, color) where {I}
    @assert is_valid(shape) "Cannot draw invalid shape $(shape)"

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

draw!(image::AbstractMatrix, shape::OddOctantSymmetricShape{I, VerticalLine{I}}, color) where {I} = draw!(put_pixel!, image, shape, color)

function draw!(f::Function, image::AbstractMatrix, shape::OddOctantSymmetricShape{I, VerticalLine{I}}, color) where {I}
    @assert is_valid(shape) "Cannot draw invalid shape $(shape)"

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

    draw!(f, image, HorizontalLine(i_origin - j_relative, j_origin - i_outer_relative, j_origin - i_inner_relative), color)
    draw!(f, image, HorizontalLine(i_origin + j_relative, j_origin - i_outer_relative, j_origin - i_inner_relative), color)
    draw!(f, image, VerticalLine(i_origin - i_outer_relative, i_origin - i_inner_relative, j_origin - j_relative), color)
    draw!(f, image, VerticalLine(i_origin + i_inner_relative, i_origin + i_outer_relative, j_origin - j_relative), color)
    draw!(f, image, VerticalLine(i_origin - i_outer_relative, i_origin - i_inner_relative, j_origin + j_relative), color)
    draw!(f, image, VerticalLine(i_origin + i_inner_relative, i_origin + i_outer_relative, j_origin + j_relative), color)
    draw!(f, image, HorizontalLine(i_origin - j_relative, j_origin + i_inner_relative, j_origin + i_outer_relative), color)
    draw!(f, image, HorizontalLine(i_origin + j_relative, j_origin + i_inner_relative, j_origin + i_outer_relative), color)

    return nothing
end

#####
##### EvenOctantSymmetricShape
#####

draw!(image::AbstractMatrix, shape::EvenOctantSymmetricShape{I, Point{I}}, color) where {I} = draw!(put_pixel!, image, shape, color)

function draw!(f::Function, image::AbstractMatrix, shape::EvenOctantSymmetricShape{I, Point{I}}, color) where {I}
    @assert is_valid(shape) "Cannot draw invalid shape $(shape)"

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

draw!(image::AbstractMatrix, shape::EvenOctantSymmetricShape{I, VerticalLine{I}}, color) where {I} = draw!(put_pixel!, image, shape, color)

function draw!(f::Function, image::AbstractMatrix, shape::EvenOctantSymmetricShape{I, VerticalLine{I}}, color) where {I}
    @assert is_valid(shape) "Cannot draw invalid shape $(shape)"

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

    draw!(f, image, HorizontalLine(i_origin - j_relative, j_origin - i_outer_relative, j_origin - i_inner_relative), color)
    draw!(f, image, HorizontalLine(i_origin + j_relative - one(I), j_origin - i_outer_relative, j_origin - i_inner_relative), color)
    draw!(f, image, VerticalLine(i_origin - i_outer_relative, i_origin - i_inner_relative, j_origin - j_relative), color)
    draw!(f, image, VerticalLine(i_origin + i_inner_relative - one(I), i_origin + i_outer_relative - one(I), j_origin - j_relative), color)
    draw!(f, image, VerticalLine(i_origin - i_outer_relative, i_origin - i_inner_relative, j_origin + j_relative - one(I)), color)
    draw!(f, image, VerticalLine(i_origin + i_inner_relative - one(I), i_origin + i_outer_relative - one(I), j_origin + j_relative - one(I)), color)
    draw!(f, image, HorizontalLine(i_origin - j_relative, j_origin + i_inner_relative - one(I), j_origin + i_outer_relative - one(I)), color)
    draw!(f, image, HorizontalLine(i_origin + j_relative - one(I), j_origin + i_inner_relative - one(I), j_origin + i_outer_relative - one(I)), color)

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

draw!(image::AbstractMatrix, shape::OddSymmetricVerticalLines4, color) = draw!(put_pixel!, image, shape, color)

function draw!(f::Function, image::AbstractMatrix, shape::OddSymmetricVerticalLines4, color)
    @assert is_valid(shape) "Cannot draw invalid shape $(shape)"

    origin = shape.origin
    point = shape.point

    i_origin = origin.i
    j_origin = origin.j
    i = point.i
    j = point.j

    i_diff = i - i_origin
    j_diff = j - j_origin

    draw!(f, image, VerticalLine(i_origin - j_diff, i_origin + j_diff, j_origin - i_diff), color)
    draw!(f, image, VerticalLine(i_origin - i_diff, i_origin + i_diff, j_origin - j_diff), color)
    draw!(f, image, VerticalLine(i_origin - i_diff, i_origin + i_diff, j_origin + j_diff), color)
    draw!(f, image, VerticalLine(i_origin - j_diff, i_origin + j_diff, j_origin + i_diff), color)

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

    return (i_point > i_origin) && (j_point > j_origin) && (i_point - i_origin >= j_point - j_origin)
end

draw!(image::AbstractMatrix, shape::EvenSymmetricVerticalLines4, color) = draw!(put_pixel!, image, shape, color)

function draw!(f::Function, image::AbstractMatrix, shape::EvenSymmetricVerticalLines4, color)
    @assert is_valid(shape) "Cannot draw invalid shape $(shape)"

    origin = shape.origin
    point = shape.point

    i_origin = origin.i
    j_origin = origin.j
    i = point.i
    j = point.j

    I = typeof(i_origin)

    i_diff = i - i_origin
    j_diff = j - j_origin

    draw!(f, image, VerticalLine(i_origin - j_diff, i_origin + j_diff - one(I), j_origin - i_diff), color)
    draw!(f, image, VerticalLine(i_origin - i_diff, i_origin + i_diff - one(I), j_origin - j_diff), color)
    draw!(f, image, VerticalLine(i_origin - i_diff, i_origin + i_diff - one(I), j_origin + j_diff - one(I)), color)
    draw!(f, image, VerticalLine(i_origin - j_diff, i_origin + j_diff - one(I), j_origin + i_diff - one(I)), color)

    return nothing
end

#####
##### line symmetries
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
