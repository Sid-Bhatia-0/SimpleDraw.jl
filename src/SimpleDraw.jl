module SimpleDraw

include("abstract_shape.jl")
include("point.jl")
include("background.jl")
include("line.jl")
include("symmetry.jl")
include("circle.jl")
include("rectangle.jl")
include("triangle.jl")
include("bitmap.jl")
include("image.jl")
include("fonts/fonts.jl")
include("character.jl")
include("text.jl")
include("visualize.jl")

const SHAPE_TYPES = [
Point,
Background,
Line,
ThickLine,
Circle,
FilledCircle,
ThickCircle,
Rectangle,
FilledRectangle,
ThickRectangle,
FilledTriangle,
Character,
TextLine,
]

# export abstract shape types
export AbstractShape

# export concrete shape types
export Point
export Background
export Line
export ThickLine
export Circle
export FilledCircle
export ThickCircle
export Rectangle
export FilledRectangle
export ThickRectangle
export Triangle
export FilledTriangle
export Bitmap
export Image
export Character
export TextLine

# export font types and constants
export TERMINUS_16_8
export TERMINUS_BOLD_16_8
export TERMINUS_24_12
export TERMINUS_BOLD_24_12
export TERMINUS_32_16
export TERMINUS_BOLD_32_16

# export shape validation methods
export is_valid

# export shape position related methods
export get_i_min
export get_i_max
export get_j_min
export get_j_max
export get_i_extrema
export get_j_extrema
export get_height
export get_width
export get_position

# export shape translation methods
export move_i
export move_j
export move

# shape drawing methods
export draw!

# drawing visualization methods
export visualize

end
