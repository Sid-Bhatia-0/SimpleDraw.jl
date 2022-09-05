"""
    struct TextLine{I <: Integer, S, F <: AbstractFont} <: AbstractShape
        position::Point{I}
        text::S
        font::F
    end

There are two monospace fonts available at this point - `TERMINUS_32_16` (height 32 pixels, width 16 pixels) and `TERMINUS_16_8` (height 16 pixels, width 8 pixels). Only glyphs for ASCII characters are available as of now.

See also [`Character`](@ref).

# Examples
```julia-repl
julia> image = falses(32, 64); shape = TextLine(Point(1, 1), "Text", TERMINUS_32_16); color = true;

julia> draw!(image, shape, color)

julia> visualize(image)
   1 2 3 4 5 6 7 8 910111213141516171819202122232425262728293031323334353637383940414243444546474849505152535455565758596061626364
 1░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒
 2▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░
 3░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒
 4▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░
 5░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒
 6▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░
 7░░▒▒████████████████████████░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒████░░▒▒░░▒▒░░▒▒░░▒▒
 8▒▒░░████████████████████████▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░████▒▒░░▒▒░░▒▒░░▒▒░░
 9░░▒▒░░▒▒░░▒▒░░████▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒████░░▒▒░░▒▒░░▒▒░░▒▒
10▒▒░░▒▒░░▒▒░░▒▒████░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░████▒▒░░▒▒░░▒▒░░▒▒░░
11░░▒▒░░▒▒░░▒▒░░████▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒████░░▒▒░░▒▒░░▒▒░░▒▒
12▒▒░░▒▒░░▒▒░░▒▒████░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░████▒▒░░▒▒░░▒▒░░▒▒░░
13░░▒▒░░▒▒░░▒▒░░████▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒████████████████░░▒▒░░▒▒░░▒▒████░░▒▒░░▒▒░░▒▒░░▒▒████░░▒▒░░▒▒████████████████████░░▒▒░░▒▒
14▒▒░░▒▒░░▒▒░░▒▒████░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒████████████████████░░▒▒░░▒▒░░████▒▒░░▒▒░░▒▒░░▒▒░░████▒▒░░▒▒░░████████████████████▒▒░░▒▒░░
15░░▒▒░░▒▒░░▒▒░░████▒▒░░▒▒░░▒▒░░▒▒░░▒▒██████▒▒░░▒▒░░▒▒░░██████░░▒▒░░▒▒██████▒▒░░▒▒░░▒▒░░██████░░▒▒░░▒▒░░▒▒░░▒▒████░░▒▒░░▒▒░░▒▒░░▒▒
16▒▒░░▒▒░░▒▒░░▒▒████░░▒▒░░▒▒░░▒▒░░▒▒░░████▒▒░░▒▒░░▒▒░░▒▒░░████▒▒░░▒▒░░▒▒██████▒▒░░▒▒░░██████░░▒▒░░▒▒░░▒▒░░▒▒░░████▒▒░░▒▒░░▒▒░░▒▒░░
17░░▒▒░░▒▒░░▒▒░░████▒▒░░▒▒░░▒▒░░▒▒░░▒▒████░░▒▒░░▒▒░░▒▒░░▒▒████░░▒▒░░▒▒░░▒▒██████▒▒░░██████░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒████░░▒▒░░▒▒░░▒▒░░▒▒
18▒▒░░▒▒░░▒▒░░▒▒████░░▒▒░░▒▒░░▒▒░░▒▒░░████▒▒░░▒▒░░▒▒░░▒▒░░████▒▒░░▒▒░░▒▒░░▒▒████████████░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░████▒▒░░▒▒░░▒▒░░▒▒░░
19░░▒▒░░▒▒░░▒▒░░████▒▒░░▒▒░░▒▒░░▒▒░░▒▒████████████████████████░░▒▒░░▒▒░░▒▒░░▒▒████████░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒████░░▒▒░░▒▒░░▒▒░░▒▒
20▒▒░░▒▒░░▒▒░░▒▒████░░▒▒░░▒▒░░▒▒░░▒▒░░████████████████████████▒▒░░▒▒░░▒▒░░▒▒░░████████▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░████▒▒░░▒▒░░▒▒░░▒▒░░
21░░▒▒░░▒▒░░▒▒░░████▒▒░░▒▒░░▒▒░░▒▒░░▒▒████░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░████████████▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒████░░▒▒░░▒▒░░▒▒░░▒▒
22▒▒░░▒▒░░▒▒░░▒▒████░░▒▒░░▒▒░░▒▒░░▒▒░░████▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░██████░░▒▒██████▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░████▒▒░░▒▒░░▒▒░░▒▒░░
23░░▒▒░░▒▒░░▒▒░░████▒▒░░▒▒░░▒▒░░▒▒░░▒▒████░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░██████░░▒▒░░▒▒██████▒▒░░▒▒░░▒▒░░▒▒░░▒▒████░░▒▒░░▒▒░░▒▒░░▒▒
24▒▒░░▒▒░░▒▒░░▒▒████░░▒▒░░▒▒░░▒▒░░▒▒░░██████░░▒▒░░▒▒░░▒▒░░████▒▒░░▒▒░░██████░░▒▒░░▒▒░░▒▒██████▒▒░░▒▒░░▒▒░░▒▒░░██████░░▒▒░░▒▒░░▒▒░░
25░░▒▒░░▒▒░░▒▒░░████▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░██████████████████████░░▒▒░░▒▒████░░▒▒░░▒▒░░▒▒░░▒▒████░░▒▒░░▒▒░░▒▒░░▒▒░░██████████████░░▒▒
26▒▒░░▒▒░░▒▒░░▒▒████░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░██████████████████░░▒▒░░▒▒░░████▒▒░░▒▒░░▒▒░░▒▒░░████▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░████████████▒▒░░
27░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒
28▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░
29░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒
30▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░
31░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒
32▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░
```
"""
struct TextLine{I <: Integer, S, F <: AbstractFont} <: AbstractShape
    position::Point{I}
    text::S
    font::F
end

get_drawing_optimization_style(::TextLine) = PUT_PIXEL

"""
    get_num_printable_characters(text)

Return the number of printable characters in text.

# Examples
```julia-repl
julia> SimpleDraw.get_num_printable_characters("hello █\n")
7
```
"""
get_num_printable(text) = count(isprint, text)

get_num_printable(shape::TextLine) = get_num_printable(shape.text)

get_i_min(shape::TextLine) = shape.position.i

function get_i_max(shape::TextLine)
    num_printable = get_num_printable(shape)

    if num_printable > zero(num_printable)
        return shape.position.i + get_height(shape.font) - one(shape.position.i)
    else
        return shape.position.i
    end
end

get_j_min(shape::TextLine) = shape.position.j

function get_j_max(shape::TextLine)
    num_printable = get_num_printable(shape)

    if num_printable > zero(num_printable)
        return shape.position.j + num_printable * get_width(shape.font) - one(shape.position.j)
    else
        return shape.position.j
    end
end

move_i(shape::TextLine, i) = TextLine(move_i(shape.position, i), shape.text, shape.font)
move_j(shape::TextLine, j) = TextLine(move_j(shape.position, j), shape.text, shape.font)

function draw!(f::F, image, shape::TextLine, color) where {F <: Function}
    position = shape.position
    text = shape.text
    font = shape.font

    bitmaps = font.bitmaps

    height = size(bitmaps, 1)
    width = size(bitmaps, 2)

    char_position = position

    for character in text
        draw!(f, image, Character(char_position, character, font), color)
        if isprint(character)
            char_position = Point(char_position.i, char_position.j + width)
        end
    end

    return nothing
end
