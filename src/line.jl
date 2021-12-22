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

clip(shape::VerticalLine, image::AbstractMatrix) = VerticalLine(max(get_i_min(shape), get_i_min(image)), min(get_i_max(shape), get_i_max(image)), shape.j)

function draw!(image::AbstractMatrix, shape::VerticalLine, color)
    @assert is_valid(shape) "Cannot draw invalid shape $(shape)"

    if is_outbounds(shape, image)
        return nothing
    end

    draw!(put_pixel_unchecked!, image, clip(shape, image), color)

    return nothing
end

function draw!(f::Function, image::AbstractMatrix, shape::VerticalLine, color)
    @assert is_valid(shape) "Cannot draw invalid shape $(shape)"

    i_min = shape.i_min
    i_max = shape.i_max
    j = shape.j

    for i in i_min:i_max
        f(image, i, j, color)
    end

    return nothing
end

get_bounding_box(shape::VerticalLine) = Rectangle(Point(shape.i_min, shape.j), shape.i_max - shape.i_min + one(shape.i_min), one(shape.i_min))

#####
##### HorizontalLine
#####

is_valid(shape::HorizontalLine) = shape.j_min <= shape.j_max

get_i_min(shape::HorizontalLine) = shape.i
get_i_max(shape::HorizontalLine) = shape.i

get_j_min(shape::HorizontalLine) = shape.j_min
get_j_max(shape::HorizontalLine) = shape.j_max

clip(shape::HorizontalLine, image::AbstractMatrix) = HorizontalLine(shape.i, max(get_j_min(shape), get_j_min(image)), min(get_j_max(shape), get_j_max(image)))

function draw!(image::AbstractMatrix, shape::HorizontalLine, color)
    @assert is_valid(shape) "Cannot draw invalid shape $(shape)"

    if is_outbounds(shape, image)
        return nothing
    end

    draw!(put_pixel_unchecked!, image, clip(shape, image), color)

    return nothing
end

function draw!(f::Function, image::AbstractMatrix, shape::HorizontalLine, color)
    @assert is_valid(shape) "Cannot draw invalid shape $(shape)"

    i = shape.i
    j_min = shape.j_min
    j_max = shape.j_max

    for j in j_min:j_max
        f(image, i, j, color)
    end

    return nothing
end

get_bounding_box(shape::HorizontalLine) = Rectangle(Point(shape.i, shape.j_min), one(shape.i), shape.j_max - shape.j_min + one(shape.i))

#####
##### Line
#####

get_i_min(shape::Line) = min(shape.point1.i, shape.point2.i)
get_i_max(shape::Line) = max(shape.point1.i, shape.point2.i)
get_i_extrema(shape::Line) = minmax(shape.point1.i, shape.point2.i)

get_j_min(shape::Line) = min(shape.point1.j, shape.point2.j)
get_j_max(shape::Line) = max(shape.point1.j, shape.point2.j)
get_j_extrema(shape::Line) = minmax(shape.point1.j, shape.point2.j)

function draw!(f::Function, image::AbstractMatrix, shape::Line, color)
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

function get_bounding_box(shape::Line)
    point1 = shape.point1
    point2 = shape.point2

    i1 = point1.i
    j1 = point1.j
    i2 = point2.i
    j2 = point2.j

    I = typeof(i1)

    if i1 < i2
        i_min = i1
        height = i2 - i1 + one(I)
    else
        i_min = i2
        height = i1 - i2 + one(I)
    end

    if j1 < j2
        j_min = j1
        width = j2 - j1 + one(I)
    else
        j_min = j2
        width = j1 - j2 + one(I)
    end

    return Rectangle(Point(i_min, j_min), height, width)
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

function draw!(f::Function, image::AbstractMatrix, shape::ThickLine, color)
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

function get_bounding_box(shape::ThickLine)
    point1 = shape.point1
    point2 = shape.point2
    diameter = shape.diameter

    i1 = point1.i
    j1 = point1.j
    i2 = point2.i
    j2 = point2.j

    I = typeof(i1)
    radius = diameter ÷ convert(I, 2)

    if i1 < i2
        i_min = i1 - radius
        i_diff = i2 - i1
    else
        i_min = i2 - radius
        i_diff = i1 - i2
    end

    if j1 < j2
        j_min = j1 - radius
        j_diff = j2 - j1
    else
        j_min = j2 - radius
        j_diff = j1 - j2
    end

    return Rectangle(Point(i_min, j_min), i_diff + diameter, j_diff + diameter)
end
