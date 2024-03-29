"""
    struct Background <: AbstractShape end

# Examples
```julia-repl
julia> image = falses(32, 32); shape = Background(); color = true;

julia> draw!(image, shape, color)

julia> visualize(image)
   1 2 3 4 5 6 7 8 91011121314151617181920212223242526272829303132
 1████████████████████████████████████████████████████████████████
 2████████████████████████████████████████████████████████████████
 3████████████████████████████████████████████████████████████████
 4████████████████████████████████████████████████████████████████
 5████████████████████████████████████████████████████████████████
 6████████████████████████████████████████████████████████████████
 7████████████████████████████████████████████████████████████████
 8████████████████████████████████████████████████████████████████
 9████████████████████████████████████████████████████████████████
10████████████████████████████████████████████████████████████████
11████████████████████████████████████████████████████████████████
12████████████████████████████████████████████████████████████████
13████████████████████████████████████████████████████████████████
14████████████████████████████████████████████████████████████████
15████████████████████████████████████████████████████████████████
16████████████████████████████████████████████████████████████████
17████████████████████████████████████████████████████████████████
18████████████████████████████████████████████████████████████████
19████████████████████████████████████████████████████████████████
20████████████████████████████████████████████████████████████████
21████████████████████████████████████████████████████████████████
22████████████████████████████████████████████████████████████████
23████████████████████████████████████████████████████████████████
24████████████████████████████████████████████████████████████████
25████████████████████████████████████████████████████████████████
26████████████████████████████████████████████████████████████████
27████████████████████████████████████████████████████████████████
28████████████████████████████████████████████████████████████████
29████████████████████████████████████████████████████████████████
30████████████████████████████████████████████████████████████████
31████████████████████████████████████████████████████████████████
32████████████████████████████████████████████████████████████████
```
"""
struct Background <: AbstractShape end

get_drawing_optimization_style(::Background) = PUT_PIXEL_INBOUNDS

get_i_min(shape::Background) = error("i_min for $(shape) depends upon the type of image. Cannot determine it solely based on the shape")
get_i_max(shape::Background) = error("i_max for $(shape) depends upon the type of image. Cannot determine it solely based on the shape")

get_j_min(shape::Background) = error("j_min for $(shape) depends upon the type of image. Cannot determine it solely based on the shape")
get_j_max(shape::Background) = error("j_max for $(shape) depends upon the type of image. Cannot determine it solely based on the shape")

move_i(shape::Background, i) = shape
move_j(shape::Background, j) = shape

function _draw!(f::F, image, shape::Background, color) where {F <: Function}
    # @assert is_valid(shape) "Cannot draw invalid shape $(shape)"

    for j in axes(image, 2)
        for i in axes(image, 1)
            f(image, i, j, color)
        end
    end

    return nothing
end
