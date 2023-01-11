abstract type AbstractTriangle <: AbstractShape end

"""
    struct Triangle{I <: Integer} <: AbstractTriangle
        point1::Point{I}
        point2::Point{I}
        point3::Point{I}
    end

# Examples
```julia-repl
julia> image = falses(32, 32); shape = Triangle(Point(5, 14), Point(18, 3), Point(26, 28)); color = true;

julia> draw!(image, shape, color)

julia> visualize(image)
   1 2 3 4 5 6 7 8 91011121314151617181920212223242526272829303132
 1░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒
 2▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░
 3░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒
 4▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░
 5░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░██░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒
 6▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░██░░██░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░
 7░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░██░░▒▒██▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒
 8▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░██░░▒▒░░▒▒██▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░
 9░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒██▒▒░░▒▒░░▒▒██▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒
10▒▒░░▒▒░░▒▒░░▒▒░░▒▒██▒▒░░▒▒░░▒▒░░██░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░
11░░▒▒░░▒▒░░▒▒░░▒▒██▒▒░░▒▒░░▒▒░░▒▒░░██░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒
12▒▒░░▒▒░░▒▒░░▒▒██▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░██░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░
13░░▒▒░░▒▒░░▒▒██▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒██▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒
14▒▒░░▒▒░░▒▒██▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒██▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░
15░░▒▒░░▒▒░░██░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒██▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒
16▒▒░░▒▒░░██░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░██░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░
17░░▒▒░░██░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░██░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒
18▒▒░░████▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░██░░▒▒░░▒▒░░▒▒░░▒▒░░
19░░▒▒░░▒▒██████▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒██▒▒░░▒▒░░▒▒░░▒▒░░▒▒
20▒▒░░▒▒░░▒▒░░▒▒██████▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒██▒▒░░▒▒░░▒▒░░▒▒░░
21░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒██████▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒██▒▒░░▒▒░░▒▒░░▒▒
22▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒████████░░▒▒░░▒▒░░▒▒░░██░░▒▒░░▒▒░░▒▒░░
23░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░██████░░▒▒░░▒▒░░██░░▒▒░░▒▒░░▒▒
24▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░██████░░▒▒░░██░░▒▒░░▒▒░░
25░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░████████▒▒░░▒▒░░▒▒
26▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░████▒▒░░▒▒░░
27░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒
28▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░
29░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒
30▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░
31░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒
32▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░
```
"""
struct Triangle{I <: Integer} <: AbstractTriangle
    point1::Point{I}
    point2::Point{I}
    point3::Point{I}
end

"""
    struct FilledTriangle{I <: Integer} <: AbstractTriangle
        point1::Point{I}
        point2::Point{I}
        point3::Point{I}
    end

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
 8▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒██████████▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░
 9░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒██████████████▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒
10▒▒░░▒▒░░▒▒░░▒▒░░▒▒████████████████░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░
11░░▒▒░░▒▒░░▒▒░░▒▒████████████████████░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒
12▒▒░░▒▒░░▒▒░░▒▒████████████████████████░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░
13░░▒▒░░▒▒░░▒▒██████████████████████████▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒
14▒▒░░▒▒░░▒▒░░████████████████████████████▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░
15░░▒▒░░▒▒░░████████████████████████████████▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒
16▒▒░░▒▒░░██████████████████████████████████░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░
17░░▒▒░░██████████████████████████████████████░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒
18▒▒░░██████████████████████████████████████████░░▒▒░░▒▒░░▒▒░░▒▒░░
19░░▒▒░░▒▒██████████████████████████████████████▒▒░░▒▒░░▒▒░░▒▒░░▒▒
20▒▒░░▒▒░░▒▒░░▒▒██████████████████████████████████▒▒░░▒▒░░▒▒░░▒▒░░
21░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒██████████████████████████████▒▒░░▒▒░░▒▒░░▒▒
22▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒████████████████████████░░▒▒░░▒▒░░▒▒░░
23░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░██████████████████░░▒▒░░▒▒░░▒▒
24▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░██████████████░░▒▒░░▒▒░░
25░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░████████▒▒░░▒▒░░▒▒
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
##### AbstractTriangle
#####

get_i_min(shape::AbstractTriangle) = min(shape.point1.i, shape.point2.i, shape.point3.i)
get_i_max(shape::AbstractTriangle) = max(shape.point1.i, shape.point2.i, shape.point3.i)

get_j_min(shape::AbstractTriangle) = min(shape.point1.j, shape.point2.j, shape.point3.j)
get_j_max(shape::AbstractTriangle) = max(shape.point1.j, shape.point2.j, shape.point3.j)

move_i(shape::AbstractTriangle, i) = typeof(shape)(move_i(shape.point1, i), move_i(shape.point2, i), move_i(shape.point3, i))
move_j(shape::AbstractTriangle, j) = typeof(shape)(move_j(shape.point1, j), move_j(shape.point2, j), move_j(shape.point3, j))

get_drawing_optimization_style(::AbstractTriangle) = CHECK_BOUNDS

function sort_points_horizontal_vertical(point1, point2, point3)
    point1, point2 = sort_points_horizontal_vertical(point1, point2)
    point1, point3 = sort_points_horizontal_vertical(point1, point3)
    point2, point3 = sort_points_horizontal_vertical(point2, point3)

    return point1, point2, point3
end

#####
##### Triangle
#####

function _draw!(f::F, image, shape::Triangle, color) where {F <: Function}
    point1, point2, point3 = sort_points_horizontal_vertical(shape.point1, shape.point2, shape.point3)

    _draw!(f, image, Line(point1, point2), color)
    _draw!(f, image, Line(point1, point3), color)
    _draw!(f, image, Line(point2, point3), color)

    return nothing
end

#####
##### FilledTriangle
#####

function _draw!(f::F, image, shape::FilledTriangle, color) where {F <: Function}
    # @assert is_valid(shape) "Cannot draw invalid shape $(shape)"

    point1, point2, point3 = sort_points_horizontal_vertical(shape.point1, shape.point2, shape.point3)

    i1 = point1.i
    j1 = point1.j
    i2 = point2.i
    j2 = point2.j
    i3 = point3.i
    j3 = point3.j

    I = typeof(i1)

    di13 = abs(i3 - i1)
    dj13 = -abs(j3 - j1)
    si13 = i1 < i3 ? one(I) : -one(I)
    sj13 = j1 < j3 ? one(I) : -one(I)
    err13 = di13 + dj13
    i13 = i1
    should_increment_j13 = false

    di12 = abs(i2 - i1)
    dj12 = -abs(j2 - j1)
    si12 = i1 < i2 ? one(I) : -one(I)
    sj12 = j1 < j2 ? one(I) : -one(I)
    err12 = di12 + dj12
    i12 = i1
    should_increment_j12 = false

    di23 = abs(i3 - i2)
    dj23 = -abs(j3 - j2)
    si23 = i2 < i3 ? one(I) : -one(I)
    sj23 = j2 < j3 ? one(I) : -one(I)
    err23 = di23 + dj23
    i23 = i2
    should_increment_j23 = false

    j = j1

    while true
        if !should_increment_j12 && !should_increment_j13
            _draw!(f, image, VerticalLine(minmax(i12, i13)..., j), color)
        end

        if (i12 == i2 && j == j2)
            break
        end

        if !should_increment_j12
            e12 = convert(I, 2) * err12

            if (e12 >= dj12)
                err12 += dj12
                i12 += si12
            end

            if (e12 <= di12)
                should_increment_j12 = true
            end
        end

        if !should_increment_j13
            e13 = convert(I, 2) * err13

            if (e13 >= dj13)
                err13 += dj13
                i13 += si13
            end

            if (e13 <= di13)
                should_increment_j13 = true
            end
        end

        if should_increment_j12 && should_increment_j13
            err12 += di12
            err13 += di13
            j += sj13
            should_increment_j12 = false
            should_increment_j13 = false
        end

    end

    while true
        if !should_increment_j23 && !should_increment_j13
            _draw!(f, image, VerticalLine(minmax(i23, i13)..., j), color)
        end

        if (i23 == i3 && j == j3)
            break
        end

        if !should_increment_j23
            e23 = convert(I, 2) * err23

            if (e23 >= dj23)
                err23 += dj23
                i23 += si23
            end

            if (e23 <= di23)
                should_increment_j23 = true
            end
        end

        if !should_increment_j13
            e13 = convert(I, 2) * err13

            if (e13 >= dj13)
                err13 += dj13
                i13 += si13
            end

            if (e13 <= di13)
                should_increment_j13 = true
            end
        end

        if should_increment_j23 && should_increment_j13
            err23 += di23
            err13 += di13
            j += sj13
            should_increment_j23 = false
            should_increment_j13 = false
        end
    end

    return nothing
end
