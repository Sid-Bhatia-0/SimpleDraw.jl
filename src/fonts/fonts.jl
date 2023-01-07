abstract type AbstractFont end

struct MonospaceBitmapASCIIFont <: AbstractFont
    bitmaps::BitArray{3}
end

include("GLYPHS_TERMINUS_16_8.jl")
const TERMINUS_16_8 = MonospaceBitmapASCIIFont(GLYPHS_TERMINUS_16_8)

include("GLYPHS_TERMINUS_BOLD_16_8.jl")
const TERMINUS_BOLD_16_8 = MonospaceBitmapASCIIFont(GLYPHS_TERMINUS_BOLD_16_8)

include("GLYPHS_TERMINUS_24_12.jl")
const TERMINUS_24_12 = MonospaceBitmapASCIIFont(GLYPHS_TERMINUS_24_12)

include("GLYPHS_TERMINUS_BOLD_24_12.jl")
const TERMINUS_BOLD_24_12 = MonospaceBitmapASCIIFont(GLYPHS_TERMINUS_BOLD_24_12)

include("GLYPHS_TERMINUS_32_16.jl")
const TERMINUS_32_16 = MonospaceBitmapASCIIFont(GLYPHS_TERMINUS_32_16)

include("GLYPHS_TERMINUS_BOLD_32_16.jl")
const TERMINUS_BOLD_32_16 = MonospaceBitmapASCIIFont(GLYPHS_TERMINUS_BOLD_32_16)

"""
    get_height(font::MonospaceBitmapASCIIFont)

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
get_height(font::MonospaceBitmapASCIIFont) = size(font.bitmaps, 1)

"""
    get_width(font::MonospaceBitmapASCIIFont)

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
get_width(font::MonospaceBitmapASCIIFont) = size(font.bitmaps, 2)

function get_bitmap(font::MonospaceBitmapASCIIFont, character)
    bitmaps = font.bitmaps

    codepoint_begin = codepoint(' ')
    k = codepoint(character) - codepoint_begin + one(codepoint_begin)

    bitmap = @view bitmaps[:, :, k]

    return bitmap
end
