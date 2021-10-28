module SimpleDraw

abstract type AbstractShape end

@inline function put_pixel!(image, i, j, color)
    if checkbounds(Bool, image, i, j)
        put_pixel_inbounds!(image, i, j, color)
    end

    return nothing
end

@inline function put_pixel_inbounds!(image, i, j, color)
    @inbounds image[i, j] = color
    return nothing
end

include("point.jl")
include("background.jl")
include("line.jl")
include("circle.jl")
include("rectangle.jl")
include("cross.jl")
include("polyline.jl")
include("visualize.jl")

end
