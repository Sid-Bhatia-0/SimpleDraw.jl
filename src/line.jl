abstract type AbstractLine <: AbstractShape end

struct VerticalLine{I <: Integer} <: AbstractLine
    i_min::I
    i_max::I
    j::I
end

struct HorizontalLine{I <: Integer} <: AbstractLine
    i::I
    j_min::I
    j_max::I
end

struct Line{I <: Integer} <: AbstractLine
    point1::Point{I}
    point2::Point{I}
end

struct ThickLine{I <: Integer} <: AbstractLine
    point1::Point{I}
    point2::Point{I}
    diameter::I
end

#####
##### VerticalLine
#####

is_valid(shape::VerticalLine) = shape.i_min <= shape.i_max

get_i_min(shape::VerticalLine) = shape.i_min
get_i_max(shape::VerticalLine) = shape.i_max

get_j_min(shape::VerticalLine) = shape.j
get_j_max(shape::VerticalLine) = shape.j

clip(image::AbstractMatrix, shape::VerticalLine) = VerticalLine(max(get_i_min(shape), get_i_min(image)), min(get_i_max(shape), get_i_max(image)), shape.j)

get_drawing_optimization_style(::VerticalLine) = CLIP

function draw!(f::F, image::AbstractMatrix, shape::VerticalLine, color) where {F <: Function}
    @assert is_valid(shape) "Cannot draw invalid shape $(shape)"

    i_min = shape.i_min
    i_max = shape.i_max
    j = shape.j

    for i in i_min:i_max
        f(image, i, j, color)
    end

    return nothing
end

#####
##### HorizontalLine
#####

is_valid(shape::HorizontalLine) = shape.j_min <= shape.j_max

get_i_min(shape::HorizontalLine) = shape.i
get_i_max(shape::HorizontalLine) = shape.i

get_j_min(shape::HorizontalLine) = shape.j_min
get_j_max(shape::HorizontalLine) = shape.j_max

clip(image::AbstractMatrix, shape::HorizontalLine) = HorizontalLine(shape.i, max(get_j_min(shape), get_j_min(image)), min(get_j_max(shape), get_j_max(image)))

get_drawing_optimization_style(::HorizontalLine) = CLIP

function draw!(f::F, image::AbstractMatrix, shape::HorizontalLine, color) where {F <: Function}
    @assert is_valid(shape) "Cannot draw invalid shape $(shape)"

    i = shape.i
    j_min = shape.j_min
    j_max = shape.j_max

    for j in j_min:j_max
        f(image, i, j, color)
    end

    return nothing
end

#####
##### Line
#####

get_i_min(shape::Line) = min(shape.point1.i, shape.point2.i)
get_i_max(shape::Line) = max(shape.point1.i, shape.point2.i)
get_i_extrema(shape::Line) = minmax(shape.point1.i, shape.point2.i)

get_j_min(shape::Line) = min(shape.point1.j, shape.point2.j)
get_j_max(shape::Line) = max(shape.point1.j, shape.point2.j)
get_j_extrema(shape::Line) = minmax(shape.point1.j, shape.point2.j)

get_drawing_optimization_style(::Line) = CHECK_BOUNDS

function draw!(f::F, image::AbstractMatrix, shape::Line, color) where {F <: Function}
    point1 = shape.point1
    point2 = shape.point2

    i1 = point1.i
    j1 = point1.j
    i2 = point2.i
    j2 = point2.j

    I = typeof(i1)

    di = abs(i2 - i1)
    dj = -abs(j2 - j1)
    si = i1 < i2 ? one(I) : -one(I)
    sj = j1 < j2 ? one(I) : -one(I)
    err = di + dj

    while true
        f(image, i1, j1, color)

        if (i1 == i2 && j1 == j2)
            break
        end

        e2 = convert(I, 2) * err

        if (e2 >= dj)
            err += dj
            i1 += si
        end

        if (e2 <= di)
            err += di
            j1 += sj
        end
    end

    return nothing
end

#####
##### ThickLine
#####

get_radius(shape::ThickLine) = shape.diameter ÷ oftype(shape.diameter, 2)

is_valid(shape::ThickLine) = shape.diameter > zero(shape.diameter)

get_i_min(shape::ThickLine) = min(shape.point1.i, shape.point2.i) - get_radius(shape)

function get_i_max(shape::ThickLine)
    point1 = shape.point1
    point2 = shape.point2
    diameter = shape.diameter

    i_max = max(point1.i, point2.i)

    radius = get_radius(shape)

    if iseven(diameter)
        return i_max + radius - one(radius)
    else
        return i_max + radius
    end
end

get_j_min(shape::ThickLine) = min(shape.point1.j, shape.point2.j) - get_radius(shape)

function get_j_max(shape::ThickLine)
    point1 = shape.point1
    point2 = shape.point2
    diameter = shape.diameter

    j_max = max(point1.j, point2.j)

    radius = get_radius(shape)

    if iseven(diameter)
        return j_max + radius - one(radius)
    else
        return j_max + radius
    end
end

get_drawing_optimization_style(::ThickLine) = CHECK_BOUNDS

function draw!(f::F, image::AbstractMatrix, shape::ThickLine, color) where {F <: Function}
    @assert is_valid(shape) "Cannot draw invalid shape $(shape)"

    point1 = shape.point1
    point2 = shape.point2
    diameter = shape.diameter

    radius = get_radius(shape)

    draw!(image, Line(point1, point2), color) do image, i, j, color
        draw!(f, image, FilledCircle(Point(i - radius, j - radius), diameter), color)
    end

    return nothing
end
