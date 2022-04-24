abstract type AbstractRectangle <: AbstractShape end

"""
    struct Rectangle{I <: Integer} <: AbstractRectangle
        position::Point{I}
        height::I
        width::I
    end

An instance of this type is considered valid only if the following conditions hold true:
1. `height > 0`
2. `width > 0`

See also [`FilledRectangle`](@ref), [`ThickRectangle`](@ref).

# Examples
```julia-repl
julia> image = falses(32, 32); shape = Rectangle(Point(9, 5), 16, 24); color = true;

julia> draw!(image, shape, color)

julia> visualize(image)
   1 2 3 4 5 6 7 8 91011121314151617181920212223242526272829303132
 1░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒
 2▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░
 3░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒
 4▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░
 5░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒
 6▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░
 7░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒
 8▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░
 9░░▒▒░░▒▒████████████████████████████████████████████████░░▒▒░░▒▒
10▒▒░░▒▒░░██░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒██▒▒░░▒▒░░
11░░▒▒░░▒▒██▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░██░░▒▒░░▒▒
12▒▒░░▒▒░░██░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒██▒▒░░▒▒░░
13░░▒▒░░▒▒██▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░██░░▒▒░░▒▒
14▒▒░░▒▒░░██░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒██▒▒░░▒▒░░
15░░▒▒░░▒▒██▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░██░░▒▒░░▒▒
16▒▒░░▒▒░░██░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒██▒▒░░▒▒░░
17░░▒▒░░▒▒██▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░██░░▒▒░░▒▒
18▒▒░░▒▒░░██░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒██▒▒░░▒▒░░
19░░▒▒░░▒▒██▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░██░░▒▒░░▒▒
20▒▒░░▒▒░░██░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒██▒▒░░▒▒░░
21░░▒▒░░▒▒██▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░██░░▒▒░░▒▒
22▒▒░░▒▒░░██░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒██▒▒░░▒▒░░
23░░▒▒░░▒▒██▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░██░░▒▒░░▒▒
24▒▒░░▒▒░░████████████████████████████████████████████████▒▒░░▒▒░░
25░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒
26▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░
27░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒
28▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░
29░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒
30▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░
31░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒
32▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░
```
"""
struct Rectangle{I <: Integer} <: AbstractRectangle
    position::Point{I}
    height::I
    width::I
end

"""
    struct FilledRectangle{I <: Integer} <: AbstractRectangle
        position::Point{I}
        height::I
        width::I
    end

An instance of this type is considered valid only if the following conditions hold true:
1. `height > 0`
2. `width > 0`

See also [`Rectangle`](@ref), [`ThickRectangle`](@ref).

# Examples
```julia-repl
julia> image = falses(32, 32); shape = FilledRectangle(Point(9, 5), 16, 24); color = true;

julia> draw!(image, shape, color)

julia> visualize(image)
   1 2 3 4 5 6 7 8 91011121314151617181920212223242526272829303132
 1░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒
 2▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░
 3░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒
 4▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░
 5░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒
 6▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░
 7░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒
 8▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░
 9░░▒▒░░▒▒████████████████████████████████████████████████░░▒▒░░▒▒
10▒▒░░▒▒░░████████████████████████████████████████████████▒▒░░▒▒░░
11░░▒▒░░▒▒████████████████████████████████████████████████░░▒▒░░▒▒
12▒▒░░▒▒░░████████████████████████████████████████████████▒▒░░▒▒░░
13░░▒▒░░▒▒████████████████████████████████████████████████░░▒▒░░▒▒
14▒▒░░▒▒░░████████████████████████████████████████████████▒▒░░▒▒░░
15░░▒▒░░▒▒████████████████████████████████████████████████░░▒▒░░▒▒
16▒▒░░▒▒░░████████████████████████████████████████████████▒▒░░▒▒░░
17░░▒▒░░▒▒████████████████████████████████████████████████░░▒▒░░▒▒
18▒▒░░▒▒░░████████████████████████████████████████████████▒▒░░▒▒░░
19░░▒▒░░▒▒████████████████████████████████████████████████░░▒▒░░▒▒
20▒▒░░▒▒░░████████████████████████████████████████████████▒▒░░▒▒░░
21░░▒▒░░▒▒████████████████████████████████████████████████░░▒▒░░▒▒
22▒▒░░▒▒░░████████████████████████████████████████████████▒▒░░▒▒░░
23░░▒▒░░▒▒████████████████████████████████████████████████░░▒▒░░▒▒
24▒▒░░▒▒░░████████████████████████████████████████████████▒▒░░▒▒░░
25░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒
26▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░
27░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒
28▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░
29░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒
30▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░
31░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒
32▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░
```
"""
struct FilledRectangle{I <: Integer} <: AbstractRectangle
    position::Point{I}
    height::I
    width::I
end

"""
    struct ThickRectangle{I <: Integer} <: AbstractRectangle
        position::Point{I}
        height::I
        width::I
        thickness::I
    end

An instance of this type is considered valid only if the following conditions hold true:
1. `height > 0`
2. `width > 0`
3. `thickness > 0`
4. `thickness <= min(height, width)`

See also [`Rectangle`](@ref), [`FilledRectangle`](@ref).

# Examples
```julia-repl
julia> image = falses(32, 32); shape = ThickRectangle(Point(9, 5), 16, 24, 4); color = true;

julia> draw!(image, shape, color)

julia> visualize(image)
   1 2 3 4 5 6 7 8 91011121314151617181920212223242526272829303132
 1░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒
 2▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░
 3░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒
 4▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░
 5░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒
 6▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░
 7░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒
 8▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░
 9░░▒▒░░▒▒████████████████████████████████████████████████░░▒▒░░▒▒
10▒▒░░▒▒░░████████████████████████████████████████████████▒▒░░▒▒░░
11░░▒▒░░▒▒████████████████████████████████████████████████░░▒▒░░▒▒
12▒▒░░▒▒░░████████████████████████████████████████████████▒▒░░▒▒░░
13░░▒▒░░▒▒████████░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒████████░░▒▒░░▒▒
14▒▒░░▒▒░░████████▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░████████▒▒░░▒▒░░
15░░▒▒░░▒▒████████░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒████████░░▒▒░░▒▒
16▒▒░░▒▒░░████████▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░████████▒▒░░▒▒░░
17░░▒▒░░▒▒████████░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒████████░░▒▒░░▒▒
18▒▒░░▒▒░░████████▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░████████▒▒░░▒▒░░
19░░▒▒░░▒▒████████░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒████████░░▒▒░░▒▒
20▒▒░░▒▒░░████████▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░████████▒▒░░▒▒░░
21░░▒▒░░▒▒████████████████████████████████████████████████░░▒▒░░▒▒
22▒▒░░▒▒░░████████████████████████████████████████████████▒▒░░▒▒░░
23░░▒▒░░▒▒████████████████████████████████████████████████░░▒▒░░▒▒
24▒▒░░▒▒░░████████████████████████████████████████████████▒▒░░▒▒░░
25░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒
26▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░
27░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒
28▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░
29░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒
30▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░
31░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒
32▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░
```
"""
struct ThickRectangle{I <: Integer} <: AbstractRectangle
    position::Point{I}
    height::I
    width::I
    thickness::I
end

#####
##### AbstractRectangle
#####

is_valid(shape::AbstractRectangle) = shape.height > zero(shape.height) && shape.width > zero(shape.width)

get_i_min(shape::AbstractRectangle) = shape.position.i
get_i_max(shape::AbstractRectangle) = shape.position.i + shape.height - one(shape.height)

get_j_min(shape::AbstractRectangle) = shape.position.j
get_j_max(shape::AbstractRectangle) = shape.position.j + shape.width - one(shape.width)

get_drawing_optimization_style(::AbstractRectangle) = CHECK_BOUNDS

#####
##### Rectangle
#####

move_i(shape::Rectangle, i) = Rectangle(move_i(shape.position, i), shape.height, shape.width)
move_j(shape::Rectangle, j) = Rectangle(move_j(shape.position, j), shape.height, shape.width)

function draw!(f::F, image::AbstractMatrix, shape::Rectangle, color) where {F <: Function}
    @assert is_valid(shape) "Cannot draw invalid shape $(shape)"

    i_min, i_max = get_i_extrema(shape)
    j_min, j_max = get_j_extrema(shape)

    draw!(f, image, VerticalLine(i_min, i_max, j_min), color)
    draw!(f, image, HorizontalLine(i_min, j_min, j_max), color)
    draw!(f, image, HorizontalLine(i_max, j_min, j_max), color)
    draw!(f, image, VerticalLine(i_min, i_max, j_max), color)

    return nothing
end

#####
##### FilledRectangle
#####

move_i(shape::FilledRectangle, i) = FilledRectangle(move_i(shape.position, i), shape.height, shape.width)
move_j(shape::FilledRectangle, j) = FilledRectangle(move_j(shape.position, j), shape.height, shape.width)

function clip(image::AbstractMatrix, shape::FilledRectangle)
    i_min_shape, i_max_shape = get_i_extrema(shape)
    i_min_image, i_max_image = get_i_extrema(image)

    I = typeof(i_min_shape)

    j_min_shape, j_max_shape = get_j_extrema(shape)
    j_min_image, j_max_image = get_j_extrema(image)

    i_min = max(i_min_shape, i_min_image)
    i_max = min(i_max_shape, i_max_image)

    j_min = max(j_min_shape, j_min_image)
    j_max = min(j_max_shape, j_max_image)

    return FilledRectangle(Point(i_min, j_min), i_max - i_min + one(I), j_max - j_min + one(I))
end

get_drawing_optimization_style(::FilledRectangle) = CLIP

function draw!(f::F, image::AbstractMatrix, shape::FilledRectangle, color) where {F <: Function}
    @assert is_valid(shape) "Cannot draw invalid shape $(shape)"

    i_min, i_max = get_i_extrema(shape)
    j_min, j_max = get_j_extrema(shape)

    for j in j_min:j_max
        for i in i_min:i_max
            f(image, i, j, color)
        end
    end

    return nothing
end

#####
##### ThickRectangle
#####

move_i(shape::ThickRectangle, i) = ThickRectangle(move_i(shape.position, i), shape.height, shape.width, shape.thickness)
move_j(shape::ThickRectangle, j) = ThickRectangle(move_j(shape.position, j), shape.height, shape.width, shape.thickness)

function is_valid(shape::ThickRectangle)
    height = shape.height
    width = shape.width
    thickness = shape.thickness

    I = typeof(height)

    return height > zero(I) && width > zero(I) && thickness > zero(I) && thickness <= min(height, width)
end

function draw!(f::F, image::AbstractMatrix, shape::ThickRectangle, color) where {F <: Function}
    @assert is_valid(shape) "Cannot draw invalid shape $(shape)"

    position = shape.position
    height = shape.height
    width = shape.width
    thickness = shape.thickness

    i_min = position.i
    j_min = position.j

    draw!(f, image, FilledRectangle(position, height, thickness), color)
    draw!(f, image, FilledRectangle(position, thickness, width), color)
    draw!(f, image, FilledRectangle(Point(i_min + height - thickness, j_min), thickness, width), color)
    draw!(f, image, FilledRectangle(Point(i_min, j_min + width - thickness), height, thickness), color)

    return nothing
end
