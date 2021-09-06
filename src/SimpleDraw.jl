module SimpleDraw

abstract type AbstractDrawable end

include("background.jl")
include("line.jl")
include("circle.jl")
include("rectangle.jl")
include("visualize.jl")

end
