"""
    struct TerminusBold_16_8 <: AbstractASCIIFont
        bitmaps::BitArray{3}
    end

A monospace bitmap font with each glyph having a height of 16 pixels and a width of 8 pixels. Only ASCII character glyphs are available for now.

See also [`Terminus_16_8`](@ref), [`Terminus_24_12`](@ref), [`TerminusBold_24_12`](@ref), [`Terminus_32_16`](@ref), [`TerminusBold_32_16`](@ref).

# Examples
```julia-repl
julia> image = falses(16, 32); shape = SD.TextLine(SD.Point(1, 1), "Text", SD.TERMINUS_BOLD_16_8); color = true;

julia> SD.draw!(image, shape, color)

julia> SD.visualize(image)
   1 2 3 4 5 6 7 8 91011121314151617181920212223242526272829303132
 1░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒
 2▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░
 3████████████████░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒████░░▒▒░░▒▒
 4▒▒░░▒▒████░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░████▒▒░░▒▒░░
 5░░▒▒░░████▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒████░░▒▒░░▒▒
 6▒▒░░▒▒████░░▒▒░░▒▒██████████▒▒░░████▒▒░░▒▒████░░████████████▒▒░░
 7░░▒▒░░████▒▒░░▒▒████░░▒▒░░████▒▒████░░▒▒░░████▒▒░░▒▒████░░▒▒░░▒▒
 8▒▒░░▒▒████░░▒▒░░████▒▒░░▒▒████░░▒▒████░░████▒▒░░▒▒░░████▒▒░░▒▒░░
 9░░▒▒░░████▒▒░░▒▒██████████████▒▒░░▒▒██████▒▒░░▒▒░░▒▒████░░▒▒░░▒▒
10▒▒░░▒▒████░░▒▒░░████▒▒░░▒▒░░▒▒░░▒▒████░░████▒▒░░▒▒░░████▒▒░░▒▒░░
11░░▒▒░░████▒▒░░▒▒████░░▒▒░░▒▒░░▒▒████░░▒▒░░████▒▒░░▒▒████░░▒▒░░▒▒
12▒▒░░▒▒████░░▒▒░░▒▒██████████▒▒░░████▒▒░░▒▒████░░▒▒░░▒▒████████░░
13░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒
14▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░
15░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒
16▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░▒▒░░
"""
struct TerminusBold_16_8 <: AbstractASCIIFont
    bitmaps::BitArray{3}
end

const TERMINUS_BOLD_16_8 = TerminusBold_16_8(falses(16, 8, 95))

TERMINUS_BOLD_16_8.bitmaps[:, :, 1] = [
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
]

TERMINUS_BOLD_16_8.bitmaps[:, :, 2] = [
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 1 1 0 0 0
0 0 0 1 1 0 0 0
0 0 0 1 1 0 0 0
0 0 0 1 1 0 0 0
0 0 0 1 1 0 0 0
0 0 0 1 1 0 0 0
0 0 0 1 1 0 0 0
0 0 0 0 0 0 0 0
0 0 0 1 1 0 0 0
0 0 0 1 1 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
]

TERMINUS_BOLD_16_8.bitmaps[:, :, 3] = [
0 0 0 0 0 0 0 0
0 1 1 0 0 1 1 0
0 1 1 0 0 1 1 0
0 1 1 0 0 1 1 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
]

TERMINUS_BOLD_16_8.bitmaps[:, :, 4] = [
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 1 1 0 1 1 0 0
0 1 1 0 1 1 0 0
0 1 1 0 1 1 0 0
1 1 1 1 1 1 1 0
0 1 1 0 1 1 0 0
0 1 1 0 1 1 0 0
1 1 1 1 1 1 1 0
0 1 1 0 1 1 0 0
0 1 1 0 1 1 0 0
0 1 1 0 1 1 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
]

TERMINUS_BOLD_16_8.bitmaps[:, :, 5] = [
0 0 0 0 0 0 0 0
0 0 0 1 0 0 0 0
0 0 0 1 0 0 0 0
0 1 1 1 1 1 0 0
1 1 0 1 0 1 1 0
1 1 0 1 0 0 0 0
1 1 0 1 0 0 0 0
0 1 1 1 1 1 0 0
0 0 0 1 0 1 1 0
0 0 0 1 0 1 1 0
1 1 0 1 0 1 1 0
0 1 1 1 1 1 0 0
0 0 0 1 0 0 0 0
0 0 0 1 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
]

TERMINUS_BOLD_16_8.bitmaps[:, :, 6] = [
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 1 1 0 0 1 1 0
1 1 0 1 0 1 1 0
0 1 1 0 1 1 0 0
0 0 0 0 1 1 0 0
0 0 0 1 1 0 0 0
0 0 0 1 1 0 0 0
0 0 1 1 0 0 0 0
0 0 1 1 0 1 1 0
0 1 1 0 1 0 1 1
0 1 1 0 0 1 1 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
]

TERMINUS_BOLD_16_8.bitmaps[:, :, 7] = [
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 1 1 1 0 0 0
0 1 1 0 1 1 0 0
0 1 1 0 1 1 0 0
0 0 1 1 1 0 0 0
0 1 1 1 0 1 1 0
1 1 0 1 1 1 0 0
1 1 0 0 1 1 0 0
1 1 0 0 1 1 0 0
1 1 0 1 1 1 0 0
0 1 1 1 0 1 1 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
]

TERMINUS_BOLD_16_8.bitmaps[:, :, 8] = [
0 0 0 0 0 0 0 0
0 0 0 1 1 0 0 0
0 0 0 1 1 0 0 0
0 0 0 1 1 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
]

TERMINUS_BOLD_16_8.bitmaps[:, :, 9] = [
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 1 1 0 0
0 0 0 1 1 0 0 0
0 0 1 1 0 0 0 0
0 0 1 1 0 0 0 0
0 0 1 1 0 0 0 0
0 0 1 1 0 0 0 0
0 0 1 1 0 0 0 0
0 0 1 1 0 0 0 0
0 0 0 1 1 0 0 0
0 0 0 0 1 1 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
]

TERMINUS_BOLD_16_8.bitmaps[:, :, 10] = [
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 1 1 0 0 0 0
0 0 0 1 1 0 0 0
0 0 0 0 1 1 0 0
0 0 0 0 1 1 0 0
0 0 0 0 1 1 0 0
0 0 0 0 1 1 0 0
0 0 0 0 1 1 0 0
0 0 0 0 1 1 0 0
0 0 0 1 1 0 0 0
0 0 1 1 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
]

TERMINUS_BOLD_16_8.bitmaps[:, :, 11] = [
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 1 1 0 1 1 0 0
0 0 1 1 1 0 0 0
1 1 1 1 1 1 1 0
0 0 1 1 1 0 0 0
0 1 1 0 1 1 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
]

TERMINUS_BOLD_16_8.bitmaps[:, :, 12] = [
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 1 1 0 0 0
0 0 0 1 1 0 0 0
0 1 1 1 1 1 1 0
0 0 0 1 1 0 0 0
0 0 0 1 1 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
]

TERMINUS_BOLD_16_8.bitmaps[:, :, 13] = [
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 1 1 0 0 0
0 0 0 1 1 0 0 0
0 0 1 1 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
]

TERMINUS_BOLD_16_8.bitmaps[:, :, 14] = [
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
1 1 1 1 1 1 1 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
]

TERMINUS_BOLD_16_8.bitmaps[:, :, 15] = [
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 1 1 0 0 0
0 0 0 1 1 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
]

TERMINUS_BOLD_16_8.bitmaps[:, :, 16] = [
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 1 1 0
0 0 0 0 0 1 1 0
0 0 0 0 1 1 0 0
0 0 0 0 1 1 0 0
0 0 0 1 1 0 0 0
0 0 0 1 1 0 0 0
0 0 1 1 0 0 0 0
0 0 1 1 0 0 0 0
0 1 1 0 0 0 0 0
0 1 1 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
]

TERMINUS_BOLD_16_8.bitmaps[:, :, 17] = [
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 1 1 1 1 1 0 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 1 1 1 0
1 1 0 1 1 1 1 0
1 1 1 1 0 1 1 0
1 1 1 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
0 1 1 1 1 1 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
]

TERMINUS_BOLD_16_8.bitmaps[:, :, 18] = [
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 1 1 0 0 0
0 0 1 1 1 0 0 0
0 1 1 1 1 0 0 0
0 0 0 1 1 0 0 0
0 0 0 1 1 0 0 0
0 0 0 1 1 0 0 0
0 0 0 1 1 0 0 0
0 0 0 1 1 0 0 0
0 0 0 1 1 0 0 0
0 1 1 1 1 1 1 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
]

TERMINUS_BOLD_16_8.bitmaps[:, :, 19] = [
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 1 1 1 1 1 0 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
0 0 0 0 0 1 1 0
0 0 0 0 1 1 0 0
0 0 0 1 1 0 0 0
0 0 1 1 0 0 0 0
0 1 1 0 0 0 0 0
1 1 0 0 0 0 0 0
1 1 1 1 1 1 1 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
]

TERMINUS_BOLD_16_8.bitmaps[:, :, 20] = [
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 1 1 1 1 1 0 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
0 0 0 0 0 1 1 0
0 0 1 1 1 1 0 0
0 0 0 0 0 1 1 0
0 0 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
0 1 1 1 1 1 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
]

TERMINUS_BOLD_16_8.bitmaps[:, :, 21] = [
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 1 1 0
0 0 0 0 1 1 1 0
0 0 0 1 1 1 1 0
0 0 1 1 0 1 1 0
0 1 1 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 1 1 1 1 1 0
0 0 0 0 0 1 1 0
0 0 0 0 0 1 1 0
0 0 0 0 0 1 1 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
]

TERMINUS_BOLD_16_8.bitmaps[:, :, 22] = [
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
1 1 1 1 1 1 1 0
1 1 0 0 0 0 0 0
1 1 0 0 0 0 0 0
1 1 0 0 0 0 0 0
1 1 1 1 1 1 0 0
0 0 0 0 0 1 1 0
0 0 0 0 0 1 1 0
0 0 0 0 0 1 1 0
1 1 0 0 0 1 1 0
0 1 1 1 1 1 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
]

TERMINUS_BOLD_16_8.bitmaps[:, :, 23] = [
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 1 1 1 1 0 0
0 1 1 0 0 0 0 0
1 1 0 0 0 0 0 0
1 1 0 0 0 0 0 0
1 1 1 1 1 1 0 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
0 1 1 1 1 1 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
]

TERMINUS_BOLD_16_8.bitmaps[:, :, 24] = [
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
1 1 1 1 1 1 1 0
0 0 0 0 0 1 1 0
0 0 0 0 0 1 1 0
0 0 0 0 1 1 0 0
0 0 0 0 1 1 0 0
0 0 0 1 1 0 0 0
0 0 0 1 1 0 0 0
0 0 1 1 0 0 0 0
0 0 1 1 0 0 0 0
0 0 1 1 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
]

TERMINUS_BOLD_16_8.bitmaps[:, :, 25] = [
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 1 1 1 1 1 0 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
0 1 1 1 1 1 0 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
0 1 1 1 1 1 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
]

TERMINUS_BOLD_16_8.bitmaps[:, :, 26] = [
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 1 1 1 1 1 0 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
0 1 1 1 1 1 1 0
0 0 0 0 0 1 1 0
0 0 0 0 0 1 1 0
0 0 0 0 1 1 0 0
0 1 1 1 1 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
]

TERMINUS_BOLD_16_8.bitmaps[:, :, 27] = [
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 1 1 0 0 0
0 0 0 1 1 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 1 1 0 0 0
0 0 0 1 1 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
]

TERMINUS_BOLD_16_8.bitmaps[:, :, 28] = [
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 1 1 0 0 0
0 0 0 1 1 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 1 1 0 0 0
0 0 0 1 1 0 0 0
0 0 1 1 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
]

TERMINUS_BOLD_16_8.bitmaps[:, :, 29] = [
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 1 1 0
0 0 0 0 1 1 0 0
0 0 0 1 1 0 0 0
0 0 1 1 0 0 0 0
0 1 1 0 0 0 0 0
0 0 1 1 0 0 0 0
0 0 0 1 1 0 0 0
0 0 0 0 1 1 0 0
0 0 0 0 0 1 1 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
]

TERMINUS_BOLD_16_8.bitmaps[:, :, 30] = [
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
1 1 1 1 1 1 1 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
1 1 1 1 1 1 1 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
]

TERMINUS_BOLD_16_8.bitmaps[:, :, 31] = [
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 1 1 0 0 0 0 0
0 0 1 1 0 0 0 0
0 0 0 1 1 0 0 0
0 0 0 0 1 1 0 0
0 0 0 0 0 1 1 0
0 0 0 0 1 1 0 0
0 0 0 1 1 0 0 0
0 0 1 1 0 0 0 0
0 1 1 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
]

TERMINUS_BOLD_16_8.bitmaps[:, :, 32] = [
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 1 1 1 1 1 0 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
0 0 0 0 1 1 0 0
0 0 0 1 1 0 0 0
0 0 0 1 1 0 0 0
0 0 0 0 0 0 0 0
0 0 0 1 1 0 0 0
0 0 0 1 1 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
]

TERMINUS_BOLD_16_8.bitmaps[:, :, 33] = [
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 1 1 1 1 1 0 0
1 1 0 0 0 1 1 0
1 1 0 0 1 1 1 0
1 1 0 1 0 1 1 0
1 1 0 1 0 1 1 0
1 1 0 1 0 1 1 0
1 1 0 1 0 1 1 0
1 1 0 0 1 1 1 0
1 1 0 0 0 0 0 0
0 1 1 1 1 1 1 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
]

TERMINUS_BOLD_16_8.bitmaps[:, :, 34] = [
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 1 1 1 1 1 0 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 1 1 1 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
]

TERMINUS_BOLD_16_8.bitmaps[:, :, 35] = [
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
1 1 1 1 1 1 0 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 1 1 1 1 0 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 1 1 1 1 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
]

TERMINUS_BOLD_16_8.bitmaps[:, :, 36] = [
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 1 1 1 1 1 0 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 0 0 0
1 1 0 0 0 0 0 0
1 1 0 0 0 0 0 0
1 1 0 0 0 0 0 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
0 1 1 1 1 1 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
]

TERMINUS_BOLD_16_8.bitmaps[:, :, 37] = [
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
1 1 1 1 1 0 0 0
1 1 0 0 1 1 0 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 1 1 0 0
1 1 1 1 1 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
]

TERMINUS_BOLD_16_8.bitmaps[:, :, 38] = [
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
1 1 1 1 1 1 1 0
1 1 0 0 0 0 0 0
1 1 0 0 0 0 0 0
1 1 0 0 0 0 0 0
1 1 1 1 1 0 0 0
1 1 0 0 0 0 0 0
1 1 0 0 0 0 0 0
1 1 0 0 0 0 0 0
1 1 0 0 0 0 0 0
1 1 1 1 1 1 1 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
]

TERMINUS_BOLD_16_8.bitmaps[:, :, 39] = [
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
1 1 1 1 1 1 1 0
1 1 0 0 0 0 0 0
1 1 0 0 0 0 0 0
1 1 0 0 0 0 0 0
1 1 1 1 1 0 0 0
1 1 0 0 0 0 0 0
1 1 0 0 0 0 0 0
1 1 0 0 0 0 0 0
1 1 0 0 0 0 0 0
1 1 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
]

TERMINUS_BOLD_16_8.bitmaps[:, :, 40] = [
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 1 1 1 1 1 0 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 0 0 0
1 1 0 0 0 0 0 0
1 1 0 1 1 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
0 1 1 1 1 1 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
]

TERMINUS_BOLD_16_8.bitmaps[:, :, 41] = [
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 1 1 1 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
]

TERMINUS_BOLD_16_8.bitmaps[:, :, 42] = [
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 1 1 1 1 0 0
0 0 0 1 1 0 0 0
0 0 0 1 1 0 0 0
0 0 0 1 1 0 0 0
0 0 0 1 1 0 0 0
0 0 0 1 1 0 0 0
0 0 0 1 1 0 0 0
0 0 0 1 1 0 0 0
0 0 0 1 1 0 0 0
0 0 1 1 1 1 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
]

TERMINUS_BOLD_16_8.bitmaps[:, :, 43] = [
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 1 1 1 1 0
0 0 0 0 1 1 0 0
0 0 0 0 1 1 0 0
0 0 0 0 1 1 0 0
0 0 0 0 1 1 0 0
0 0 0 0 1 1 0 0
0 0 0 0 1 1 0 0
1 1 0 0 1 1 0 0
1 1 0 0 1 1 0 0
0 1 1 1 1 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
]

TERMINUS_BOLD_16_8.bitmaps[:, :, 44] = [
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 1 1 0 0
1 1 0 1 1 0 0 0
1 1 1 1 0 0 0 0
1 1 1 1 0 0 0 0
1 1 0 1 1 0 0 0
1 1 0 0 1 1 0 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
]

TERMINUS_BOLD_16_8.bitmaps[:, :, 45] = [
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
1 1 0 0 0 0 0 0
1 1 0 0 0 0 0 0
1 1 0 0 0 0 0 0
1 1 0 0 0 0 0 0
1 1 0 0 0 0 0 0
1 1 0 0 0 0 0 0
1 1 0 0 0 0 0 0
1 1 0 0 0 0 0 0
1 1 0 0 0 0 0 0
1 1 1 1 1 1 1 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
]

TERMINUS_BOLD_16_8.bitmaps[:, :, 46] = [
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
1 0 0 0 0 0 1 0
1 1 0 0 0 1 1 0
1 1 1 0 1 1 1 0
1 1 1 1 1 1 1 0
1 1 0 1 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
]

TERMINUS_BOLD_16_8.bitmaps[:, :, 47] = [
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 1 0 0 1 1 0
1 1 1 1 0 1 1 0
1 1 0 1 1 1 1 0
1 1 0 0 1 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
]

TERMINUS_BOLD_16_8.bitmaps[:, :, 48] = [
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 1 1 1 1 1 0 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
0 1 1 1 1 1 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
]

TERMINUS_BOLD_16_8.bitmaps[:, :, 49] = [
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
1 1 1 1 1 1 0 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 1 1 1 1 0 0
1 1 0 0 0 0 0 0
1 1 0 0 0 0 0 0
1 1 0 0 0 0 0 0
1 1 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
]

TERMINUS_BOLD_16_8.bitmaps[:, :, 50] = [
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 1 1 1 1 1 0 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 1 1 1 1 0
0 1 1 1 1 1 0 0
0 0 0 0 0 1 1 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
]

TERMINUS_BOLD_16_8.bitmaps[:, :, 51] = [
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
1 1 1 1 1 1 0 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 1 1 1 1 0 0
1 1 1 1 0 0 0 0
1 1 0 1 1 0 0 0
1 1 0 0 1 1 0 0
1 1 0 0 0 1 1 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
]

TERMINUS_BOLD_16_8.bitmaps[:, :, 52] = [
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 1 1 1 1 1 0 0
1 1 0 0 0 1 1 0
1 1 0 0 0 0 0 0
1 1 0 0 0 0 0 0
0 1 1 1 1 1 0 0
0 0 0 0 0 1 1 0
0 0 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
0 1 1 1 1 1 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
]

TERMINUS_BOLD_16_8.bitmaps[:, :, 53] = [
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
1 1 1 1 1 1 1 1
0 0 0 1 1 0 0 0
0 0 0 1 1 0 0 0
0 0 0 1 1 0 0 0
0 0 0 1 1 0 0 0
0 0 0 1 1 0 0 0
0 0 0 1 1 0 0 0
0 0 0 1 1 0 0 0
0 0 0 1 1 0 0 0
0 0 0 1 1 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
]

TERMINUS_BOLD_16_8.bitmaps[:, :, 54] = [
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
0 1 1 1 1 1 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
]

TERMINUS_BOLD_16_8.bitmaps[:, :, 55] = [
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
0 1 1 0 1 1 0 0
0 1 1 0 1 1 0 0
0 1 1 0 1 1 0 0
0 0 1 1 1 0 0 0
0 0 1 1 1 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
]

TERMINUS_BOLD_16_8.bitmaps[:, :, 56] = [
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 1 0 1 1 0
1 1 1 1 1 1 1 0
1 1 1 0 1 1 1 0
1 1 0 0 0 1 1 0
1 0 0 0 0 0 1 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
]

TERMINUS_BOLD_16_8.bitmaps[:, :, 57] = [
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
0 1 1 0 1 1 0 0
0 1 1 0 1 1 0 0
0 0 1 1 1 0 0 0
0 0 1 1 1 0 0 0
0 1 1 0 1 1 0 0
0 1 1 0 1 1 0 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
]

TERMINUS_BOLD_16_8.bitmaps[:, :, 58] = [
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
1 1 0 0 0 0 1 1
1 1 0 0 0 0 1 1
0 1 1 0 0 1 1 0
0 1 1 0 0 1 1 0
0 0 1 1 1 1 0 0
0 0 0 1 1 0 0 0
0 0 0 1 1 0 0 0
0 0 0 1 1 0 0 0
0 0 0 1 1 0 0 0
0 0 0 1 1 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
]

TERMINUS_BOLD_16_8.bitmaps[:, :, 59] = [
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
1 1 1 1 1 1 1 0
0 0 0 0 0 1 1 0
0 0 0 0 0 1 1 0
0 0 0 0 1 1 0 0
0 0 0 1 1 0 0 0
0 0 1 1 0 0 0 0
0 1 1 0 0 0 0 0
1 1 0 0 0 0 0 0
1 1 0 0 0 0 0 0
1 1 1 1 1 1 1 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
]

TERMINUS_BOLD_16_8.bitmaps[:, :, 60] = [
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 1 1 1 1 0 0
0 0 1 1 0 0 0 0
0 0 1 1 0 0 0 0
0 0 1 1 0 0 0 0
0 0 1 1 0 0 0 0
0 0 1 1 0 0 0 0
0 0 1 1 0 0 0 0
0 0 1 1 0 0 0 0
0 0 1 1 0 0 0 0
0 0 1 1 1 1 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
]

TERMINUS_BOLD_16_8.bitmaps[:, :, 61] = [
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 1 1 0 0 0 0 0
0 1 1 0 0 0 0 0
0 0 1 1 0 0 0 0
0 0 1 1 0 0 0 0
0 0 0 1 1 0 0 0
0 0 0 1 1 0 0 0
0 0 0 0 1 1 0 0
0 0 0 0 1 1 0 0
0 0 0 0 0 1 1 0
0 0 0 0 0 1 1 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
]

TERMINUS_BOLD_16_8.bitmaps[:, :, 62] = [
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 1 1 1 1 0 0
0 0 0 0 1 1 0 0
0 0 0 0 1 1 0 0
0 0 0 0 1 1 0 0
0 0 0 0 1 1 0 0
0 0 0 0 1 1 0 0
0 0 0 0 1 1 0 0
0 0 0 0 1 1 0 0
0 0 0 0 1 1 0 0
0 0 1 1 1 1 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
]

TERMINUS_BOLD_16_8.bitmaps[:, :, 63] = [
0 0 0 0 0 0 0 0
0 0 0 1 1 0 0 0
0 0 1 1 1 1 0 0
0 1 1 0 0 1 1 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
]

TERMINUS_BOLD_16_8.bitmaps[:, :, 64] = [
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
1 1 1 1 1 1 1 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
]

TERMINUS_BOLD_16_8.bitmaps[:, :, 65] = [
0 0 1 1 0 0 0 0
0 0 0 1 1 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
]

TERMINUS_BOLD_16_8.bitmaps[:, :, 66] = [
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 1 1 1 1 1 0 0
0 0 0 0 0 1 1 0
0 1 1 1 1 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
0 1 1 1 1 1 1 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
]

TERMINUS_BOLD_16_8.bitmaps[:, :, 67] = [
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
1 1 0 0 0 0 0 0
1 1 0 0 0 0 0 0
1 1 0 0 0 0 0 0
1 1 1 1 1 1 0 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 1 1 1 1 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
]

TERMINUS_BOLD_16_8.bitmaps[:, :, 68] = [
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 1 1 1 1 1 0 0
1 1 0 0 0 1 1 0
1 1 0 0 0 0 0 0
1 1 0 0 0 0 0 0
1 1 0 0 0 0 0 0
1 1 0 0 0 1 1 0
0 1 1 1 1 1 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
]

TERMINUS_BOLD_16_8.bitmaps[:, :, 69] = [
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 1 1 0
0 0 0 0 0 1 1 0
0 0 0 0 0 1 1 0
0 1 1 1 1 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
0 1 1 1 1 1 1 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
]

TERMINUS_BOLD_16_8.bitmaps[:, :, 70] = [
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 1 1 1 1 1 0 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 1 1 1 1 1 0
1 1 0 0 0 0 0 0
1 1 0 0 0 0 0 0
0 1 1 1 1 1 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
]

TERMINUS_BOLD_16_8.bitmaps[:, :, 71] = [
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 1 1 1 1 0
0 0 1 1 0 0 0 0
0 0 1 1 0 0 0 0
1 1 1 1 1 1 0 0
0 0 1 1 0 0 0 0
0 0 1 1 0 0 0 0
0 0 1 1 0 0 0 0
0 0 1 1 0 0 0 0
0 0 1 1 0 0 0 0
0 0 1 1 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
]

TERMINUS_BOLD_16_8.bitmaps[:, :, 72] = [
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 1 1 1 1 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
0 1 1 1 1 1 1 0
0 0 0 0 0 1 1 0
0 0 0 0 0 1 1 0
0 1 1 1 1 1 0 0
0 0 0 0 0 0 0 0
]

TERMINUS_BOLD_16_8.bitmaps[:, :, 73] = [
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
1 1 0 0 0 0 0 0
1 1 0 0 0 0 0 0
1 1 0 0 0 0 0 0
1 1 1 1 1 1 0 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
]

TERMINUS_BOLD_16_8.bitmaps[:, :, 74] = [
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 1 1 0 0 0
0 0 0 1 1 0 0 0
0 0 0 0 0 0 0 0
0 0 1 1 1 0 0 0
0 0 0 1 1 0 0 0
0 0 0 1 1 0 0 0
0 0 0 1 1 0 0 0
0 0 0 1 1 0 0 0
0 0 0 1 1 0 0 0
0 0 1 1 1 1 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
]

TERMINUS_BOLD_16_8.bitmaps[:, :, 75] = [
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 1 1 0
0 0 0 0 0 1 1 0
0 0 0 0 0 0 0 0
0 0 0 0 1 1 1 0
0 0 0 0 0 1 1 0
0 0 0 0 0 1 1 0
0 0 0 0 0 1 1 0
0 0 0 0 0 1 1 0
0 0 0 0 0 1 1 0
0 0 0 0 0 1 1 0
0 1 1 0 0 1 1 0
0 1 1 0 0 1 1 0
0 0 1 1 1 1 0 0
0 0 0 0 0 0 0 0
]

TERMINUS_BOLD_16_8.bitmaps[:, :, 76] = [
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
1 1 0 0 0 0 0 0
1 1 0 0 0 0 0 0
1 1 0 0 0 0 0 0
1 1 0 0 0 1 1 0
1 1 0 0 1 1 0 0
1 1 0 1 1 0 0 0
1 1 1 1 0 0 0 0
1 1 0 1 1 0 0 0
1 1 0 0 1 1 0 0
1 1 0 0 0 1 1 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
]

TERMINUS_BOLD_16_8.bitmaps[:, :, 77] = [
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 1 1 1 0 0 0
0 0 0 1 1 0 0 0
0 0 0 1 1 0 0 0
0 0 0 1 1 0 0 0
0 0 0 1 1 0 0 0
0 0 0 1 1 0 0 0
0 0 0 1 1 0 0 0
0 0 0 1 1 0 0 0
0 0 0 1 1 0 0 0
0 0 1 1 1 1 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
]

TERMINUS_BOLD_16_8.bitmaps[:, :, 78] = [
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
1 1 1 1 1 1 0 0
1 1 0 1 0 1 1 0
1 1 0 1 0 1 1 0
1 1 0 1 0 1 1 0
1 1 0 1 0 1 1 0
1 1 0 1 0 1 1 0
1 1 0 1 0 1 1 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
]

TERMINUS_BOLD_16_8.bitmaps[:, :, 79] = [
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
1 1 1 1 1 1 0 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
]

TERMINUS_BOLD_16_8.bitmaps[:, :, 80] = [
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 1 1 1 1 1 0 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
0 1 1 1 1 1 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
]

TERMINUS_BOLD_16_8.bitmaps[:, :, 81] = [
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
1 1 1 1 1 1 0 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 1 1 1 1 0 0
1 1 0 0 0 0 0 0
1 1 0 0 0 0 0 0
1 1 0 0 0 0 0 0
0 0 0 0 0 0 0 0
]

TERMINUS_BOLD_16_8.bitmaps[:, :, 82] = [
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 1 1 1 1 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
0 1 1 1 1 1 1 0
0 0 0 0 0 1 1 0
0 0 0 0 0 1 1 0
0 0 0 0 0 1 1 0
0 0 0 0 0 0 0 0
]

TERMINUS_BOLD_16_8.bitmaps[:, :, 83] = [
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
1 1 0 1 1 1 1 0
1 1 1 1 0 0 0 0
1 1 1 0 0 0 0 0
1 1 0 0 0 0 0 0
1 1 0 0 0 0 0 0
1 1 0 0 0 0 0 0
1 1 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
]

TERMINUS_BOLD_16_8.bitmaps[:, :, 84] = [
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 1 1 1 1 1 1 0
1 1 0 0 0 0 0 0
1 1 0 0 0 0 0 0
0 1 1 1 1 1 0 0
0 0 0 0 0 1 1 0
0 0 0 0 0 1 1 0
1 1 1 1 1 1 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
]

TERMINUS_BOLD_16_8.bitmaps[:, :, 85] = [
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 1 1 0 0 0 0
0 0 1 1 0 0 0 0
0 0 1 1 0 0 0 0
1 1 1 1 1 1 0 0
0 0 1 1 0 0 0 0
0 0 1 1 0 0 0 0
0 0 1 1 0 0 0 0
0 0 1 1 0 0 0 0
0 0 1 1 0 0 0 0
0 0 0 1 1 1 1 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
]

TERMINUS_BOLD_16_8.bitmaps[:, :, 86] = [
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
0 1 1 1 1 1 1 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
]

TERMINUS_BOLD_16_8.bitmaps[:, :, 87] = [
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
0 1 1 0 1 1 0 0
0 1 1 0 1 1 0 0
0 0 1 1 1 0 0 0
0 0 1 1 1 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
]

TERMINUS_BOLD_16_8.bitmaps[:, :, 88] = [
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 1 0 1 1 0
1 1 0 1 0 1 1 0
1 1 0 1 0 1 1 0
1 1 0 1 0 1 1 0
0 1 1 1 1 1 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
]

TERMINUS_BOLD_16_8.bitmaps[:, :, 89] = [
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
0 1 1 0 1 1 0 0
0 0 1 1 1 0 0 0
0 1 1 0 1 1 0 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
]

TERMINUS_BOLD_16_8.bitmaps[:, :, 90] = [
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
1 1 0 0 0 1 1 0
0 1 1 1 1 1 1 0
0 0 0 0 0 1 1 0
0 0 0 0 0 1 1 0
0 1 1 1 1 1 0 0
0 0 0 0 0 0 0 0
]

TERMINUS_BOLD_16_8.bitmaps[:, :, 91] = [
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
1 1 1 1 1 1 1 0
0 0 0 0 1 1 0 0
0 0 0 1 1 0 0 0
0 0 1 1 0 0 0 0
0 1 1 0 0 0 0 0
1 1 0 0 0 0 0 0
1 1 1 1 1 1 1 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
]

TERMINUS_BOLD_16_8.bitmaps[:, :, 92] = [
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 1 1 1 0 0
0 0 1 1 0 0 0 0
0 0 1 1 0 0 0 0
0 0 1 1 0 0 0 0
0 1 1 0 0 0 0 0
0 0 1 1 0 0 0 0
0 0 1 1 0 0 0 0
0 0 1 1 0 0 0 0
0 0 1 1 0 0 0 0
0 0 0 1 1 1 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
]

TERMINUS_BOLD_16_8.bitmaps[:, :, 93] = [
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 1 1 0 0 0
0 0 0 1 1 0 0 0
0 0 0 1 1 0 0 0
0 0 0 1 1 0 0 0
0 0 0 1 1 0 0 0
0 0 0 1 1 0 0 0
0 0 0 1 1 0 0 0
0 0 0 1 1 0 0 0
0 0 0 1 1 0 0 0
0 0 0 1 1 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
]

TERMINUS_BOLD_16_8.bitmaps[:, :, 94] = [
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 1 1 1 0 0 0 0
0 0 0 1 1 0 0 0
0 0 0 1 1 0 0 0
0 0 0 1 1 0 0 0
0 0 0 0 1 1 0 0
0 0 0 1 1 0 0 0
0 0 0 1 1 0 0 0
0 0 0 1 1 0 0 0
0 0 0 1 1 0 0 0
0 1 1 1 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
]

TERMINUS_BOLD_16_8.bitmaps[:, :, 95] = [
0 0 0 0 0 0 0 0
0 1 1 1 0 0 1 1
1 1 0 1 1 0 1 1
1 1 0 0 1 1 1 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
]