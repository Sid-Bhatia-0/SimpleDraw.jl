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

struct Character{I <: Integer, C <: AbstractChar, F <: AbstractFont} <: AbstractShape
    position::Point{I}
    character::C
    font::F
end

has_char(font::AbstractASCIIFont, character) = isascii(character) && isprint(character)

function get_bitmap(font::AbstractASCIIFont, character)
    bitmap = font.bitmap

    codepoint_begin = codepoint(' ')
    k = codepoint(character) - codepoint_begin + one(codepoint_begin)

    char_bitmap = @view bitmap[:, :, k]

    return char_bitmap
end

get_i_min(shape::Character) = shape.position.i
get_i_max(shape::Character) = isprint(shape.character) ? shape.position.i + get_height(shape.font) - one(shape.position.i) : shape.position.i

get_j_min(shape::Character) = shape.position.j
get_j_max(shape::Character) = isprint(shape.character) ? shape.position.j + get_width(shape.font) - one(shape.position.j) : shape.position.j

move_i(shape::Character, i) = Character(move_i(shape.position, i), shape.character, shape.font)
move_j(shape::Character, j) = Character(move_j(shape.position, j), shape.character, shape.font)

function draw!(image::AbstractMatrix, shape::Character{I, C, <:AbstractASCIIFont} where {I, C}, color)
    position = shape.position
    character = shape.character
    font = shape.font

    if is_outbounds(image, shape)
        return nothing
    end

    if isprint(character)
        if isascii(character)
            if character == ' '
                return nothing
            else
                bitmap_shape = Bitmap(position, get_bitmap(font, character))
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
    character = shape.character
    font = shape.font

    if isprint(character)
        if isascii(character)
            if character == ' '
                return nothing
            else
                bitmap_shape = Bitmap(position, get_bitmap(font, character))
                draw!(f, image, bitmap_shape, color)
            end
        else
            filled_rectangle = FilledRectangle(position, get_height(font), get_width(font))
            draw!(f, image, filled_rectangle, color)
        end
    end

    return nothing
end
