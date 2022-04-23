abstract type AbstractCircleOctant <: AbstractShape end

struct CircleOctant{I <: Integer} <: AbstractCircleOctant
    center::Point{I}
    radius::I
end

struct ThickCircleOctant{I <: Integer} <: AbstractCircleOctant
    center::Point{I}
    radius::I
    thickness::I
end

abstract type AbstractCircle <: AbstractShape end

struct OddCircle{I <: Integer} <: AbstractCircle
    position::Point{I}
    diameter::I
end

struct EvenCircle{I <: Integer} <: AbstractCircle
    position::Point{I}
    diameter::I
end

"""
# Examples
```julia-repl
julia> image = falses(32, 32); shape = Circle(Point(2, 2), 30); color = true;

julia> draw!(image, shape, color)

julia> visualize(image)
   1 2 3 4 5 6 7 8 91011121314151617181920212223242526272829303132
 1░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒
 2▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒████████████░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░
 3░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒██████▒▒░░▒▒░░▒▒░░██████░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒
 4▒▒░░▒▒░░▒▒░░▒▒░░████▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░████▒▒░░▒▒░░▒▒░░▒▒░░
 5░░▒▒░░▒▒░░▒▒░░██░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒██▒▒░░▒▒░░▒▒░░▒▒
 6▒▒░░▒▒░░▒▒░░██░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒██▒▒░░▒▒░░▒▒░░
 7░░▒▒░░▒▒░░██░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒██▒▒░░▒▒░░▒▒
 8▒▒░░▒▒░░██░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒██▒▒░░▒▒░░
 9░░▒▒░░██░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒██▒▒░░▒▒
10▒▒░░▒▒██▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░██░░▒▒░░
11░░▒▒██▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░██░░▒▒
12▒▒░░██░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒██▒▒░░
13░░▒▒██▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░██░░▒▒
14▒▒██▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░██░░
15░░██░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒██▒▒
16▒▒██▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░██░░
17░░██░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒██▒▒
18▒▒██▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░██░░
19░░██░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒██▒▒
20▒▒░░██░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒██▒▒░░
21░░▒▒██▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░██░░▒▒
22▒▒░░██░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒██▒▒░░
23░░▒▒░░██░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒██▒▒░░▒▒
24▒▒░░▒▒██▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░██░░▒▒░░
25░░▒▒░░▒▒██▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░██░░▒▒░░▒▒
26▒▒░░▒▒░░▒▒██▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░██░░▒▒░░▒▒░░
27░░▒▒░░▒▒░░▒▒██▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░██░░▒▒░░▒▒░░▒▒
28▒▒░░▒▒░░▒▒░░▒▒██▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░██░░▒▒░░▒▒░░▒▒░░
29░░▒▒░░▒▒░░▒▒░░▒▒████░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒████░░▒▒░░▒▒░░▒▒░░▒▒
30▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░██████░░▒▒░░▒▒░░▒▒██████▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░
31░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░████████████▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒
32▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░
```
"""
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

"""
# Examples
```julia-repl
julia> image = falses(32, 32); shape = FilledCircle(Point(2, 2), 30); color = true;

julia> draw!(image, shape, color)

julia> visualize(image)
   1 2 3 4 5 6 7 8 91011121314151617181920212223242526272829303132
 1░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒
 2▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒████████████░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░
 3░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒████████████████████████░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒
 4▒▒░░▒▒░░▒▒░░▒▒░░████████████████████████████████▒▒░░▒▒░░▒▒░░▒▒░░
 5░░▒▒░░▒▒░░▒▒░░████████████████████████████████████▒▒░░▒▒░░▒▒░░▒▒
 6▒▒░░▒▒░░▒▒░░████████████████████████████████████████▒▒░░▒▒░░▒▒░░
 7░░▒▒░░▒▒░░████████████████████████████████████████████▒▒░░▒▒░░▒▒
 8▒▒░░▒▒░░████████████████████████████████████████████████▒▒░░▒▒░░
 9░░▒▒░░████████████████████████████████████████████████████▒▒░░▒▒
10▒▒░░▒▒████████████████████████████████████████████████████░░▒▒░░
11░░▒▒████████████████████████████████████████████████████████░░▒▒
12▒▒░░████████████████████████████████████████████████████████▒▒░░
13░░▒▒████████████████████████████████████████████████████████░░▒▒
14▒▒████████████████████████████████████████████████████████████░░
15░░████████████████████████████████████████████████████████████▒▒
16▒▒████████████████████████████████████████████████████████████░░
17░░████████████████████████████████████████████████████████████▒▒
18▒▒████████████████████████████████████████████████████████████░░
19░░████████████████████████████████████████████████████████████▒▒
20▒▒░░████████████████████████████████████████████████████████▒▒░░
21░░▒▒████████████████████████████████████████████████████████░░▒▒
22▒▒░░████████████████████████████████████████████████████████▒▒░░
23░░▒▒░░████████████████████████████████████████████████████▒▒░░▒▒
24▒▒░░▒▒████████████████████████████████████████████████████░░▒▒░░
25░░▒▒░░▒▒████████████████████████████████████████████████░░▒▒░░▒▒
26▒▒░░▒▒░░▒▒████████████████████████████████████████████░░▒▒░░▒▒░░
27░░▒▒░░▒▒░░▒▒████████████████████████████████████████░░▒▒░░▒▒░░▒▒
28▒▒░░▒▒░░▒▒░░▒▒████████████████████████████████████░░▒▒░░▒▒░░▒▒░░
29░░▒▒░░▒▒░░▒▒░░▒▒████████████████████████████████░░▒▒░░▒▒░░▒▒░░▒▒
30▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░████████████████████████▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░
31░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░████████████▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒
32▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░
```
"""
struct FilledCircle{I <: Integer} <: AbstractCircle
    position::Point{I}
    diameter::I
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

"""
# Examples
```julia-repl
julia> image = falses(32, 32); shape = ThickCircle(Point(2, 2), 30, 4); color = true;

julia> draw!(image, shape, color)

julia> visualize(image)
   1 2 3 4 5 6 7 8 91011121314151617181920212223242526272829303132
 1░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒
 2▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒████████████░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░
 3░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒████████████████████████░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒
 4▒▒░░▒▒░░▒▒░░▒▒░░████████████████████████████████▒▒░░▒▒░░▒▒░░▒▒░░
 5░░▒▒░░▒▒░░▒▒░░████████████████████████████████████▒▒░░▒▒░░▒▒░░▒▒
 6▒▒░░▒▒░░▒▒░░██████████████░░▒▒░░▒▒░░▒▒██████████████▒▒░░▒▒░░▒▒░░
 7░░▒▒░░▒▒░░████████████▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░████████████▒▒░░▒▒░░▒▒
 8▒▒░░▒▒░░██████████░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒██████████▒▒░░▒▒░░
 9░░▒▒░░██████████░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒██████████▒▒░░▒▒
10▒▒░░▒▒████████░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒████████░░▒▒░░
11░░▒▒██████████▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░██████████░░▒▒
12▒▒░░████████▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░████████▒▒░░
13░░▒▒████████░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒████████░░▒▒
14▒▒████████░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒████████░░
15░░████████▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░████████▒▒
16▒▒████████░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒████████░░
17░░████████▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░████████▒▒
18▒▒████████░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒████████░░
19░░████████▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░████████▒▒
20▒▒░░████████▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░████████▒▒░░
21░░▒▒████████░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒████████░░▒▒
22▒▒░░██████████░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒██████████▒▒░░
23░░▒▒░░████████▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░████████▒▒░░▒▒
24▒▒░░▒▒██████████▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░██████████░░▒▒░░
25░░▒▒░░▒▒██████████▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░██████████░░▒▒░░▒▒
26▒▒░░▒▒░░▒▒████████████░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒████████████░░▒▒░░▒▒░░
27░░▒▒░░▒▒░░▒▒██████████████▒▒░░▒▒░░▒▒░░██████████████░░▒▒░░▒▒░░▒▒
28▒▒░░▒▒░░▒▒░░▒▒████████████████████████████████████░░▒▒░░▒▒░░▒▒░░
29░░▒▒░░▒▒░░▒▒░░▒▒████████████████████████████████░░▒▒░░▒▒░░▒▒░░▒▒
30▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░████████████████████████▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░
31░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░████████████▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒
32▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░
```
"""
struct ThickCircle{I <: Integer} <: AbstractCircle
    position::Point{I}
    diameter::I
    thickness::I
end

#####
##### AbstractCircleOctant
#####

is_valid(shape::AbstractCircleOctant) = shape.radius >= zero(shape.radius)

get_i_min(shape::AbstractCircleOctant) = shape.center.i
get_i_max(shape::AbstractCircleOctant) = shape.center.i + shape.radius

get_j_min(shape::AbstractCircleOctant) = shape.center.j
get_j_max(shape::AbstractCircleOctant) = shape.center.j + shape.radius

get_drawing_optimization_style(::AbstractCircleOctant) = CHECK_BOUNDS

#####
##### CircleOctant
#####

function draw!(f::F, image::AbstractMatrix, shape::CircleOctant, color) where {F <: Function}
    @assert is_valid(shape) "Cannot draw invalid shape $(shape)"

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
##### ThickCircleOctant
#####

is_valid(shape::ThickCircleOctant) = (shape.radius >= zero(shape.radius)) && (shape.thickness > zero(shape.thickness) && (shape.thickness <= shape.radius + one(shape.radius)))

function draw!(image::AbstractMatrix, shape::ThickCircleOctant, color)
    @assert is_valid(shape) "Cannot draw invalid shape $(shape)"

    center = shape.center
    radius = shape.radius
    thickness = shape.thickness

    if is_outbounds(image, shape)
        return nothing
    end

    if is_inbounds(image, shape)
        draw!(image, ThickCircleOctant(center, radius, thickness), color) do image, i1, j1, i2, j2, color
            draw!(put_pixel_inbounds!, image, VerticalLine(i1, i2, j1), color)
        end
    else
        draw!(image, ThickCircleOctant(center, radius, thickness), color) do image, i1, j1, i2, j2, color
            draw!(put_pixel!, image, VerticalLine(i1, i2, j1), color)
        end
    end

    return nothing
end

function draw!(f::F, image::AbstractMatrix, shape::ThickCircleOctant, color) where {F <: Function}
    @assert is_valid(shape) "Cannot draw invalid shape $(shape)"

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

get_i_min(shape::AbstractCircle) = shape.position.i
get_i_max(shape::AbstractCircle) = shape.position.i + shape.diameter - one(shape.diameter)

get_j_min(shape::AbstractCircle) = shape.position.j
get_j_max(shape::AbstractCircle) = shape.position.j + shape.diameter - one(shape.diameter)

get_drawing_optimization_style(::AbstractCircle) = CHECK_BOUNDS

#####
##### OddCircle
#####

is_valid(shape::OddCircle) = isodd(shape.diameter) && shape.diameter > zero(shape.diameter)

function draw!(f::F, image::AbstractMatrix, shape::OddCircle, color) where {F <: Function}
    @assert is_valid(shape) "Cannot draw invalid shape $(shape)"

    center, radius = get_center_radius(shape)

    draw!(image, CircleOctant(center, radius), color) do image, i, j, color
        draw!(f, image, OddOctantSymmetricShape(center, Point(i, j)), color)
    end

    return nothing
end

#####
##### EvenCircle
#####

is_valid(shape::EvenCircle) = iseven(shape.diameter) && shape.diameter > zero(shape.diameter)

function draw!(f::F, image::AbstractMatrix, shape::EvenCircle, color) where {F <: Function}
    @assert is_valid(shape) "Cannot draw invalid shape $(shape)"

    center, radius = get_center_radius(shape)

    draw!(image, CircleOctant(center, radius), color) do image, i, j, color
        draw!(f, image, EvenOctantSymmetricShape(center, Point(i, j)), color)
    end

    return nothing
end

#####
##### Circle
#####

move_i(shape::Circle, i) = Circle(move_i(shape.position, i), shape.diameter)
move_j(shape::Circle, j) = Circle(move_j(shape.position, j), shape.diameter)

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

function draw!(f::F, image::AbstractMatrix, shape::Circle, color) where {F <: Function}
    @assert is_valid(shape) "Cannot draw invalid shape $(shape)"

    position = shape.position
    diameter = shape.diameter

    if iseven(diameter)
        draw!(f, image, EvenCircle(position, diameter), color)
    else
        draw!(f, image, OddCircle(position, diameter), color)
    end

    return nothing
end

#####
##### OddFilledCircle
#####

is_valid(shape::OddFilledCircle) = is_valid(OddCircle(shape.position, shape.diameter))

function draw!(f::F, image::AbstractMatrix, shape::OddFilledCircle, color) where {F <: Function}
    @assert is_valid(shape) "Cannot draw invalid shape $(shape)"

    center, radius = get_center_radius(shape)

    draw!(image, CircleOctant(center, radius), color) do image, i, j, color
        draw!(f, image, OddSymmetricVerticalLines4(center, Point(i, j)), color)
    end

    return nothing
end

#####
##### EvenFilledCircle
#####

is_valid(shape::EvenFilledCircle) = is_valid(EvenCircle(shape.position, shape.diameter))

function draw!(f::F, image::AbstractMatrix, shape::EvenFilledCircle, color) where {F <: Function}
    @assert is_valid(shape) "Cannot draw invalid shape $(shape)"

    position = shape.position
    diameter = shape.diameter

    I = typeof(diameter)

    i_position = position.i
    j_position = position.j

    center, radius = get_center_radius(shape)

    if diameter == convert(I, 2)
        draw!(f, image, FilledRectangle(position, convert(I, 2), convert(I, 2)), color)
    end

    draw!(image, CircleOctant(center, radius), color) do image, i, j, color
        if i > center.i && j > center.j
            draw!(f, image, EvenSymmetricVerticalLines4(center, Point(i, j)), color)
        else
            return nothing
        end
    end

    return nothing
end

#####
##### FilledCircle
#####

move_i(shape::FilledCircle, i) = FilledCircle(move_i(shape.position, i), shape.diameter)
move_j(shape::FilledCircle, j) = FilledCircle(move_j(shape.position, j), shape.diameter)

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

function draw!(f::F, image::AbstractMatrix, shape::FilledCircle, color) where {F <: Function}
    @assert is_valid(shape) "Cannot draw invalid shape $(shape)"

    position = shape.position
    diameter = shape.diameter

    if iseven(diameter)
        draw!(f, image, EvenFilledCircle(position, diameter), color)
    else
        draw!(f, image, OddFilledCircle(position, diameter), color)
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

function draw!(f::F, image::AbstractMatrix, shape::OddThickCircle, color) where {F <: Function}
    @assert is_valid(shape) "Cannot draw invalid shape $(shape)"

    thickness = shape.thickness

    center, radius = get_center_radius(shape)

    draw!(image, ThickCircleOctant(center, radius, thickness), color) do image, i1, j1, i2, j2, color
        draw!(f, image, OddOctantSymmetricShape(center, VerticalLine(i1, i2, j1)), color)
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

function draw!(f::F, image::AbstractMatrix, shape::EvenThickCircle, color) where {F <: Function}
    @assert is_valid(shape) "Cannot draw invalid shape $(shape)"

    thickness = shape.thickness

    center, radius = get_center_radius(shape)

    draw!(image, ThickCircleOctant(center, radius, thickness), color) do image, i1, j1, i2, j2, color
        draw!(f, image, EvenOctantSymmetricShape(center, VerticalLine(i1, i2, j1)), color)
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

move_i(shape::ThickCircle, i) = ThickCircle(move_i(shape.position, i), shape.diameter, shape.thickness)
move_j(shape::ThickCircle, j) = ThickCircle(move_j(shape.position, j), shape.diameter, shape.thickness)

function draw!(image::AbstractMatrix, shape::ThickCircle, color)
    @assert is_valid(shape) "Cannot draw invalid shape $(shape)"

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

function draw!(f::F, image::AbstractMatrix, shape::ThickCircle, color) where {F <: Function}
    @assert is_valid(shape) "Cannot draw invalid shape $(shape)"

    position = shape.position
    diameter = shape.diameter
    thickness = shape.thickness

    if iseven(diameter)
        draw!(f, image, EvenThickCircle(position, diameter, thickness), color)
    else
        draw!(f, image, OddThickCircle(position, diameter, thickness), color)
    end

    return nothing
end
