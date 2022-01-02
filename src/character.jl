abstract type AbstractFont end

include("fonts/Terminus_32_16.jl")

const FONTS = [
               TERMINUS_32_16,
              ]

struct Character{I, C <: AbstractChar, F <: AbstractFont} <: AbstractShape
    position::Point{I}
    char::C
    font::F
end

has_char(font::Terminus_32_16, char) = isascii(char) && isprint(char)

function get_bitmap(font::Terminus_32_16, char::Char)
    bitmap = font.bitmap

    codepoint_begin = codepoint(' ')
    k = codepoint(char) - codepoint_begin + one(codepoint_begin)

    char_bitmap = @view bitmap[:, :, k]

    return char_bitmap
end

is_valid(shape::Character) = has_char(shape.font, shape.char)

get_i_min(shape::Character) = shape.position.i
get_i_max(shape::Character) = shape.position.i + size(shape.font.bitmap, 1) - one(shape.position.i)

get_j_min(shape::Character) = shape.position.j
get_j_max(shape::Character) = shape.position.j + size(shape.font.bitmap, 2) - one(shape.position.j)

function draw!(image::AbstractMatrix, shape::Character{I, C, Terminus_32_16} where {I, C}, color)
    @assert is_valid(shape) "Cannot draw invalid shape $(shape)"

    position = shape.position
    char = shape.char
    font = shape.font

    if is_outbounds(image, shape)
        return nothing
    end

    if char == ' '
        return nothing
    else
        bitmap_shape = Bitmap(position, get_bitmap(font, char))
        draw!(put_pixel_unchecked!, image, clip(image, bitmap_shape), color)
    end

    return nothing
end

function draw!(f::F, image::AbstractMatrix, shape::Character{I, C, Terminus_32_16} where {I, C}, color) where {F <: Function}
    @assert is_valid(shape) "Cannot draw invalid shape $(shape)"

    position = shape.position
    char = shape.char
    font = shape.font

    if char == ' '
        return nothing
    else
        bitmap_shape = Bitmap(position, get_bitmap(font, char))
        draw!(f, image, bitmap_shape, color)
    end

    return nothing
end
