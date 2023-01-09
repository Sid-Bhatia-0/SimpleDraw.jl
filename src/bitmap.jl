"""
    struct Bitmap{I <: Integer, B <: AbstractMatrix{Bool}} <: AbstractShape
        position::Point{I}
        bitmap::B
    end

Can be used to draw a 1-bit image using some color on an image. For example, it is used for drawing character glyphs in `Character` or `TextLine`.

See also [`Image`](@ref).

# Examples
```julia-repl
julia> import SimpleDraw as SD

julia> image = falses(32, 32); color = true;

julia> bitmap = BitArray([
                           0 0 0 0 0 0 0 1 1 0 0 0 0 0 0 0
                           0 0 0 0 0 0 1 0 0 1 0 0 0 0 0 0
                           0 0 0 0 0 1 0 0 0 0 1 0 0 0 0 0
                           0 0 0 0 1 0 0 0 0 0 0 1 0 0 0 0
                           0 0 0 1 0 0 0 0 0 0 0 0 1 0 0 0
                           0 0 1 0 0 0 0 0 0 0 0 0 0 1 0 0
                           0 1 0 0 0 0 0 0 0 0 0 0 0 0 1 0
                           1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1
                           1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1
                           0 1 0 0 0 0 0 0 0 0 0 0 0 0 1 0
                           0 0 1 0 0 0 0 0 0 0 0 0 0 1 0 0
                           0 0 0 1 0 0 0 0 0 0 0 0 1 0 0 0
                           0 0 0 0 1 0 0 0 0 0 0 1 0 0 0 0
                           0 0 0 0 0 1 0 0 0 0 1 0 0 0 0 0
                           0 0 0 0 0 0 1 0 0 1 0 0 0 0 0 0
                           0 0 0 0 0 0 0 1 1 0 0 0 0 0 0 0
                          ]);

julia> shape = SD.Bitmap(SD.Point(8, 4), bitmap)
SimpleDraw.Bitmap{Int64, BitMatrix}(SimpleDraw.Point{Int64}(8, 4), Bool[0 0 … 0 0; 0 0 … 0 0; … ; 0 0 … 0 0; 0 0 … 0 0])

julia> SD.draw!(image, shape, color); SD.visualize(image)
   1 2 3 4 5 6 7 8 91011121314151617181920212223242526272829303132
 1░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒
 2▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░
 3░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒
 4▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░
 5░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒
 6▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░
 7░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒
 8▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░████▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░
 9░░▒▒░░▒▒░░▒▒░░▒▒░░██░░▒▒██▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒
10▒▒░░▒▒░░▒▒░░▒▒░░██░░▒▒░░▒▒██▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░
11░░▒▒░░▒▒░░▒▒░░██░░▒▒░░▒▒░░▒▒██▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒
12▒▒░░▒▒░░▒▒░░██░░▒▒░░▒▒░░▒▒░░▒▒██▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░
13░░▒▒░░▒▒░░██░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒██▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒
14▒▒░░▒▒░░██░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒██▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░
15░░▒▒░░██░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒██▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒
16▒▒░░▒▒██▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░██░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░
17░░▒▒░░▒▒██▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░██░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒
18▒▒░░▒▒░░▒▒██▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░██░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░
19░░▒▒░░▒▒░░▒▒██▒▒░░▒▒░░▒▒░░▒▒░░██░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒
20▒▒░░▒▒░░▒▒░░▒▒██▒▒░░▒▒░░▒▒░░██░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░
21░░▒▒░░▒▒░░▒▒░░▒▒██▒▒░░▒▒░░██░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒
22▒▒░░▒▒░░▒▒░░▒▒░░▒▒██▒▒░░██░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░
23░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒████░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒
24▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░
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
struct Bitmap{I <: Integer, B <: AbstractMatrix{Bool}} <: AbstractShape
    position::Point{I}
    bitmap::B
end

is_valid(shape::Bitmap) = !isempty(shape.bitmap)

get_i_min(shape::Bitmap) = shape.position.i
get_i_max(shape::Bitmap) = shape.position.i + size(shape.bitmap, 1) - one(shape.position.i)

get_j_min(shape::Bitmap) = shape.position.j
get_j_max(shape::Bitmap) = shape.position.j + size(shape.bitmap, 2) - one(shape.position.j)

move_i(shape::Bitmap, i) = Bitmap(move_i(shape.position, i), shape.bitmap)
move_j(shape::Bitmap, j) = Bitmap(move_j(shape.position, j), shape.bitmap)

function clip_array(image, position, array)
    # assuming shape is not outbounds, !isempty(shape.image), and it has an overlap region with the image

    I = typeof(position.i)

    i_min_shape = position.i
    i_max_shape = position.i + size(array, 1) - one(I)
    i_min_image, i_max_image = get_i_extrema(image)

    j_min_shape = position.j
    j_max_shape = position.j + size(array, 2) - one(I)
    j_min_image, j_max_image = get_j_extrema(image)

    delta_i_min = i_min_image - i_min_shape
    if delta_i_min > zero(delta_i_min)
        i_new_position = i_min_image
        i_begin = firstindex(array, 1) + delta_i_min
    else
        i_new_position = position.i
        i_begin = firstindex(array, 1)
    end

    delta_i_max = i_max_shape - i_max_image
    if delta_i_max > zero(delta_i_max)
        i_end = lastindex(array, 1) - delta_i_max
    else
        i_end = lastindex(array, 1)
    end

    delta_j_min = j_min_image - j_min_shape
    if delta_j_min > zero(delta_j_min)
        j_new_position = j_min_image
        j_begin = firstindex(array, 2) + delta_j_min
    else
        j_new_position = position.j
        j_begin = firstindex(array, 2)
    end

    delta_j_max = j_max_shape - j_max_image
    if delta_j_max > zero(delta_j_max)
        j_end = lastindex(array, 2) - delta_j_max
    else
        j_end = lastindex(array, 2)
    end

    new_position = Point(i_new_position, j_new_position)
    new_array = @view array[i_begin:i_end, j_begin:j_end]

    return new_position, new_array
end

clip(image, shape::Bitmap) = Bitmap(clip_array(image, shape.position, shape.bitmap)...)

get_drawing_optimization_style(::Bitmap) = CLIP

function _draw!(f::F, image, shape::Bitmap, color) where {F <: Function}
    @assert is_valid(shape) "Cannot draw invalid shape $(shape)"

    position = shape.position
    bitmap = shape.bitmap

    i_position = position.i
    j_position = position.j

    I = typeof(i_position)

    i_min, i_max = get_i_extrema(shape)
    j_min, j_max = get_j_extrema(shape)

    for j in j_min:j_max
        for i in i_min:i_max
            i_bitmap = i - i_position + one(I)
            j_bitmap = j - j_position + one(I)
            if bitmap[i_bitmap, j_bitmap]
                f(image, i, j, color)
            end
        end
    end

    return nothing
end
