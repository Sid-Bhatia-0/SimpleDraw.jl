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

function draw!(image::AbstractMatrix, shape::Character, color)
    position = shape.position
    char = shape.char
    font = shape.font
    i_position = position.i
    j_position = position.j
    bitmap = font.bitmap

    codepoint_exclamation = codepoint('!')
    k = codepoint(char) - codepoint_exclamation + one(codepoint_exclamation)

    if !(k in axes(bitmap, 3))
        return nothing
    end

    bitmap_shape = Bitmap(position, @view bitmap[:, :, k])

    if is_outbounds(bitmap_shape, image)
        return nothing
    end

    _draw!(put_pixel_unchecked!, image, clip(bitmap_shape, image), color)

    return nothing
end

function _draw!(f::Function, image::AbstractMatrix, shape::Character, color)
    position = shape.position
    char = shape.char
    font = shape.font
    bitmap = font.bitmap

    codepoint_exclamation = codepoint('!')
    k = codepoint(char) - codepoint_exclamation + one(codepoint_exclamation)

    bitmap_shape = Bitmap(position, @view bitmap[:, :, k])

    _draw!(f, image, bitmap_shape, color)

    return nothing
end

function get_bounding_box(shape::Character)
    position = shape.position
    bitmap = shape.font.bitmap

    height = size(bitmap, 1)
    width = size(bitmap, 2)

    return Rectangle(position, height, width)
end
