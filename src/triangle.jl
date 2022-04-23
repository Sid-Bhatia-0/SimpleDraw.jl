abstract type AbstractTriangle <: AbstractShape end

struct VerticalBaseFilledTriangle{I <: Integer} <: AbstractTriangle
    vertical_line::VerticalLine{I}
    point::Point{I}
end

"""
# Examples
```julia-repl
julia> image = falses(32, 32); shape = FilledTriangle(Point(5, 14), Point(18, 3), Point(26, 28)); color = true;

julia> draw!(image, shape, color)

julia> visualize(image)
   1 2 3 4 5 6 7 8 91011121314151617181920212223242526272829303132
 1░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒
 2▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░
 3░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒
 4▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░
 5░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░██░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒
 6▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░██████░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░
 7░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░████████▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒
 8▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░████████████▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░
 9░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒██████████████▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒
10▒▒░░▒▒░░▒▒░░▒▒░░▒▒████████████████░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░
11░░▒▒░░▒▒░░▒▒░░▒▒████████████████████░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒
12▒▒░░▒▒░░▒▒░░▒▒████████████████████████░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░
13░░▒▒░░▒▒░░▒▒██████████████████████████▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒
14▒▒░░▒▒░░▒▒██████████████████████████████▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░
15░░▒▒░░▒▒░░████████████████████████████████▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒
16▒▒░░▒▒░░██████████████████████████████████░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░
17░░▒▒░░██████████████████████████████████████░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒
18▒▒░░██████████████████████████████████████████░░▒▒░░▒▒░░▒▒░░▒▒░░
19░░▒▒░░▒▒██████████████████████████████████████▒▒░░▒▒░░▒▒░░▒▒░░▒▒
20▒▒░░▒▒░░▒▒░░▒▒██████████████████████████████████▒▒░░▒▒░░▒▒░░▒▒░░
21░░▒▒░░▒▒░░▒▒░░▒▒░░████████████████████████████████▒▒░░▒▒░░▒▒░░▒▒
22▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░██████████████████████████░░▒▒░░▒▒░░▒▒░░
23░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░██████████████████████░░▒▒░░▒▒░░▒▒
24▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒████████████████░░▒▒░░▒▒░░
25░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒██████████▒▒░░▒▒░░▒▒
26▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░████▒▒░░▒▒░░
27░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒
28▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░
29░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒
30▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░
31░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒
32▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░
```
"""
struct FilledTriangle{I <: Integer} <: AbstractTriangle
    point1::Point{I}
    point2::Point{I}
    point3::Point{I}
end

#####
##### VerticalBaseFilledTriangle
#####

is_valid(shape::VerticalBaseFilledTriangle) = is_valid(shape.vertical_line)

get_i_min(shape::VerticalBaseFilledTriangle) = min(shape.vertical_line.i_min, shape.point.i)
get_i_max(shape::VerticalBaseFilledTriangle) = max(shape.vertical_line.i_max, shape.point.i)

get_j_min(shape::VerticalBaseFilledTriangle) = min(shape.vertical_line.j, shape.point.j)
get_j_max(shape::VerticalBaseFilledTriangle) = max(shape.vertical_line.j, shape.point.j)

get_drawing_optimization_style(::VerticalBaseFilledTriangle) = CHECK_BOUNDS

function draw!(f::F, image::AbstractMatrix, shape::VerticalBaseFilledTriangle, color) where {F <: Function}
    @assert is_valid(shape) "Cannot draw invalid shape $(shape)"

    i1 = shape.vertical_line.i_min
    i3 = shape.vertical_line.i_max
    i2 = shape.point.i
    j2 = shape.point.j
    j = shape.vertical_line.j

    point1 = Point(i1, j)
    point2 = shape.point
    point3 = Point(i3, j)

    I = typeof(i1)

    di1 = abs(i2 - i1)
    di3 = abs(i2 - i3)
    dj = -abs(j2 - j)

    si1 = i1 < i2 ? one(I) : -one(I)
    si3 = i3 < i2 ? one(I) : -one(I)
    sj = j < j2 ? one(I) : -one(I)

    err1 = di1 + dj
    err3 = di3 + dj

    should_increment_j1 = false
    should_increment_j3 = false

    while true
        draw!(f, image, VerticalLine(i1, i3, j), color)

        while true
            if (i1 == i2 && j == j2)
                break
            end

            e1 = convert(I, 2) * err1

            if (e1 >= dj)
                err1 += dj
                i1 += si1
            end

            if (e1 <= di1)
                should_increment_j1 = true
                break
            end
        end

        while true
            if (i3 == i2 && j == j2)
                break
            end

            e3 = convert(I, 2) * err3

            if (e3 >= dj)
                err3 += dj
                i3 += si3
            end

            if (e3 <= di3)
                should_increment_j3 = true
                break
            end
        end

        if should_increment_j1 && should_increment_j3
            err1 += di1
            err3 += di3
            j += sj
            should_increment_j1 = false
            should_increment_j3 = false
        end

        if (i1 == i2 && j == j2)
            break
        end
    end

    draw!(f, image, Line(point3, point2), color)

    return nothing
end

#####
##### FilledTriangle
#####

get_i_min(shape::FilledTriangle) = min(shape.point1.i, shape.point2.i, shape.point3.i)
get_i_max(shape::FilledTriangle) = max(shape.point1.i, shape.point2.i, shape.point3.i)

get_j_min(shape::FilledTriangle) = min(shape.point1.j, shape.point2.j, shape.point3.j)
get_j_max(shape::FilledTriangle) = max(shape.point1.j, shape.point2.j, shape.point3.j)

move_i(shape::FilledTriangle, i) = FilledTriangle(move_i(shape.point1, i), move_i(shape.point2, i), move_i(shape.point3, i))
move_j(shape::FilledTriangle, j) = FilledTriangle(move_j(shape.point1, j), move_j(shape.point2, j), move_j(shape.point3, j))

get_drawing_optimization_style(::FilledTriangle) = CHECK_BOUNDS

function sort_horizontal(point1, point2)
    if point1.j <= point2.j
        return (point1, point2)
    else
        return (point2, point1)
    end
end

function sort_horizontal(point1, point2, point3)
    point1, point3 = sort_horizontal(point1, point3)
    point1, point2 = sort_horizontal(point1, point2)
    point2, point3 = sort_horizontal(point2, point3)

    return (point1, point2, point3)
end

function vertical_line_intersection(point1, point2, j)
    i1 = point1.i
    j1 = point1.j
    i2 = point2.i
    j2 = point2.j

    i = i1 + div((i2 - i1) * (j - j1), j2 - j1, RoundNearest)

    return i
end

function draw!(f::F, image::AbstractMatrix, shape::FilledTriangle, color) where {F <: Function}
    point1, point2, point3 = sort_horizontal(shape.point1, shape.point2, shape.point3)

    i1 = point1.i
    j1 = point1.j
    i2 = point2.i
    j2 = point2.j
    i3 = point3.i
    j3 = point3.j

    if point1.j == point3.j
        draw!(f, image, VerticalLine(min(i1, i2, i3), max(i1, i2, i3), j1), color)
    else
        i = vertical_line_intersection(point1, point3, j2)
        vertical_line = VerticalLine(minmax(i, i2)..., j2)
        left_triangle = VerticalBaseFilledTriangle(vertical_line, point1)
        right_triangle = VerticalBaseFilledTriangle(vertical_line, point3)
        draw!(f, image, left_triangle, color)
        draw!(f, image, right_triangle, color)
    end

    return nothing
end
