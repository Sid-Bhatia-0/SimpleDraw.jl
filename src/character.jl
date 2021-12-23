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

function has_char(font::Terminus_32_16, char::Char)
    bitmap = font.bitmap

    codepoint_exclamation = codepoint('!')
    k = codepoint(char) - codepoint_exclamation + one(codepoint_exclamation)

    return (k in axes(bitmap, 3) || char == ' ')
end

function get_bitmap(font::Terminus_32_16, char::Char)
    bitmap = font.bitmap

    codepoint_exclamation = codepoint('!')
    k = codepoint(char) - codepoint_exclamation + one(codepoint_exclamation)

    char_bitmap = @view bitmap[:, :, k]

    return char_bitmap
end

is_valid(shape::Character) = has_char(shape.font, shape.char)

function draw!(image::AbstractMatrix, shape::Character{I, C, Terminus_32_16}, color) where {I, C}
    @assert is_valid(shape) "Cannot draw invalid shape $(shape)"

    position = shape.position
    char = shape.char
    font = shape.font

    if char == ' '
        return nothing
    else
        bitmap_shape = Bitmap(position, get_bitmap(font, char))
        draw!(put_pixel_unchecked!, image, clip(bitmap_shape, image), color)
    end

    return nothing
end

function draw!(f::Function, image::AbstractMatrix, shape::Character{I, C, Terminus_32_16}, color) where {I, C}
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
