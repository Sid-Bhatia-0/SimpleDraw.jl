# Fonts

`extract_bitmaps.jl` is a helper script that parses a `.bdf` bitmap font file and generates a `.jl` file containing the bitmaps for the font glyphs as a `BitArray{3}`.

The script is very limited at this point and can only process fonts where the width of the font is a multiple of 4.

The generated julia file for a font is then included in `/src/character.jl` (after some modifications, if necessary).

Here is an example usage:

```julia-repl
julia> include("extract_bitmaps.jl")
generate_julia_font_file (generic function with 1 method)

julia> include("extract_bitmaps.jl");

julia> font_height = 16; font_width = 8; unicode_codepoints_to_take = 32:126;

julia> font_file = "../../fonts/terminus-font-4.49.1/ter-u16n.bdf";

julia> font_type_name = "Terminus_16_8"; font_instance_name = "TERMINUS_16_8";

julia> font_info = FontInfo(font_height, font_width, unicode_codepoints_to_take, font_file, font_type_name, font_instance_name)
FontInfo(16, 8, 32:126, "../../fonts/terminus-font-4.49.1/ter-u16n.bdf", "Terminus_16_8", "TERMINUS_16_8")

julia> generate_julia_font_file(font_info)

julia> 
```
