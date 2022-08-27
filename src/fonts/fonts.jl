abstract type AbstractFont end

abstract type AbstractASCIIFont <: AbstractFont end

include("Terminus_16_8.jl")
include("TerminusBold_16_8.jl")
include("Terminus_24_12.jl")
include("TerminusBold_24_12.jl")
include("Terminus_32_16.jl")
include("TerminusBold_32_16.jl")

const FONTS = [
               TERMINUS_16_8,
               TERMINUS_BOLD_16_8,
               TERMINUS_24_12,
               TERMINUS_BOLD_24_12,
               TERMINUS_32_16,
               TERMINUS_BOLD_32_16,
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
get_height(font::Terminus_16_8) = 16

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
get_width(font::Terminus_16_8) = 8

get_height(font::TerminusBold_16_8) = 16
get_width(font::TerminusBold_16_8) = 8

get_height(font::Terminus_24_12) = 24
get_width(font::Terminus_24_12) = 12

get_height(font::TerminusBold_24_12) = 24
get_width(font::TerminusBold_24_12) = 12

get_height(font::Terminus_32_16) = 32
get_width(font::Terminus_32_16) = 16

get_height(font::TerminusBold_32_16) = 32
get_width(font::TerminusBold_32_16) = 16

has_char(font::AbstractASCIIFont, character) = isascii(character) && isprint(character)

function get_bitmap(font, character)
    bitmaps = font.bitmaps

    codepoint_begin = codepoint(' ')
    k = codepoint(character) - codepoint_begin + one(codepoint_begin)

    bitmap = @view bitmaps[:, :, k]

    return bitmap
end
