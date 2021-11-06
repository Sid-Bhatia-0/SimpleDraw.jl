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
    position_i = position.i
    position_j = position.j
    bitmap = font.bitmap

    height, width, _ = size(bitmap)

    k = codepoint(char) - codepoint('!') + 1

    i_min = max(position_i, firstindex(image, 1))
    i_max = min(position_i + height - 1, lastindex(image, 1))

    j_min = max(position_j, firstindex(image, 1))
    j_max = min(position_j + width - 1, lastindex(image, 1))

    if k in axes(bitmap, 3)
        for j in j_min:j_max
            for i in i_min:i_max
                i_bitmap = i - position_i + 1
                j_bitmap = j - position_j + 1
                if bitmap[i_bitmap, j_bitmap, k]
                    put_pixel_inbounds!(image, i, j, color)
                end
            end
        end
    end

    return nothing
end

function draw_inbounds!(image::AbstractMatrix, shape::Character, color)
    position = shape.position
    char = shape.char
    font = shape.font
    position_i = position.i
    position_j = position.j
    bitmap = font.bitmap

    height, width, _ = size(bitmap)

    i_min = position_i
    i_max = position_i + height - 1

    j_min = position_j
    j_max = position_j + width - 1

    k = codepoint(char) - codepoint('!') + 1

    if k in axes(bitmap, 3)
        for j in j_min:j_max
            for i in i_min:i_max
                i_bitmap = i - position_i + 1
                j_bitmap = j - position_j + 1
                if bitmap[i_bitmap, j_bitmap, k]
                    put_pixel_inbounds!(image, i, j, color)
                end
            end
        end
    end

    return nothing
end
