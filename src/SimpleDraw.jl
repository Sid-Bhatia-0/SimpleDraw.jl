module SimpleDraw

abstract type AbstractShape end

include("line.jl")
include("circle.jl")
include("visualize.jl")

end
