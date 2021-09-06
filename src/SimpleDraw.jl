module SimpleDraw

abstract type AbstractDrawable end

@inline function put_pixel!(image, i, j, color)
    if checkbounds(Bool, image, i, j)
        @inbounds image[i, j] = color
    end

    return nothing
end

include("background.jl")
include("line.jl")
include("circle.jl")
include("rectangle.jl")
include("visualize.jl")

end
