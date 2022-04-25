abstract type AbstractFont end

abstract type AbstractASCIIFont <: AbstractFont end

include("Terminus_32_16.jl")
include("Terminus_16_8.jl")

const FONTS = [
               TERMINUS_32_16,
               TERMINUS_16_8,
              ]

"""
    get_height(font::AbstractFont)

Return the height of a glyph contained in the monospace font `font` along the i-axis (vertical-axis, 1st-axis).

See also [`get_width`](@ref).

# Examples
```julia-repl
julia> get_height(TERMINUS_32_16)
32

julia> get_height(TERMINUS_16_8)
16
```
"""
get_height(font::Terminus_32_16) = 32

"""
    get_width(font::AbstractFont)

Return the width of a glyph contained in the monospace font `font` along the j-axis (horizontal-axis, 2nd-axis).

See also [`get_width`](@ref).

# Examples
```julia-repl
julia> get_width(TERMINUS_32_16)
16

julia> get_width(TERMINUS_16_8)
8
```
"""
get_width(font::Terminus_32_16) = 16

get_height(font::Terminus_16_8) = 16
get_width(font::Terminus_16_8) = 8

has_char(font::AbstractASCIIFont, character) = isascii(character) && isprint(character)

function get_bitmap(font, character)
    bitmaps = font.bitmaps

    codepoint_begin = codepoint(' ')
    k = codepoint(character) - codepoint_begin + one(codepoint_begin)

    char_bitmap = @view bitmaps[:, :, k]

    return char_bitmap
end
