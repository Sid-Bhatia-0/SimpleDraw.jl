abstract type AbstractFont end

abstract type AbstractASCIIFont <: AbstractFont end

include("fonts/Terminus_32_16.jl")
include("fonts/Terminus_16_8.jl")

const FONTS = [
               TERMINUS_32_16,
               TERMINUS_16_8,
              ]

get_height(font::Terminus_32_16) = 32
get_width(font::Terminus_32_16) = 16

get_height(font::Terminus_16_8) = 16
get_width(font::Terminus_16_8) = 8

struct Character{I, C <: AbstractChar, F <: AbstractFont} <: AbstractShape
    position::Point{I}
    char::C
    font::F
end

has_char(font::AbstractASCIIFont, char) = isascii(char) && isprint(char)

function get_bitmap(font::AbstractASCIIFont, char::Char)
    bitmap = font.bitmap

    codepoint_begin = codepoint(' ')
    k = codepoint(char) - codepoint_begin + one(codepoint_begin)

    char_bitmap = @view bitmap[:, :, k]

    return char_bitmap
end

get_i_min(shape::Character) = shape.position.i
get_i_max(shape::Character) = shape.position.i + size(shape.font.bitmap, 1) - one(shape.position.i)

get_j_min(shape::Character) = shape.position.j
get_j_max(shape::Character) = shape.position.j + size(shape.font.bitmap, 2) - one(shape.position.j)

function draw!(image::AbstractMatrix, shape::Character{I, C, <:AbstractASCIIFont} where {I, C}, color)
    position = shape.position
    char = shape.char
    font = shape.font

    if is_outbounds(image, shape)
        return nothing
    end

    if isprint(char)
        if isascii(char)
            if char == ' '
                return nothing
            else
                bitmap_shape = Bitmap(position, get_bitmap(font, char))
                draw!(put_pixel_inbounds!, image, bitmap_shape, color)
            end
        else
            filled_rectangle = FilledRectangle(position, get_height(font), get_width(font))
            draw!(image, filled_rectangle, color)
        end
    end

    return nothing
end

function draw!(f::F, image::AbstractMatrix, shape::Character{I, C, <:AbstractASCIIFont} where {I, C}, color) where {F <: Function}
    position = shape.position
    char = shape.char
    font = shape.font

    if isprint(char)
        if isascii(char)
            if char == ' '
                return nothing
            else
                bitmap_shape = Bitmap(position, get_bitmap(font, char))
                draw!(f, image, bitmap_shape, color)
            end
        else
            filled_rectangle = FilledRectangle(position, get_height(font), get_width(font))
            draw!(f, image, filled_rectangle, color)
        end
    end

    return nothing
end
