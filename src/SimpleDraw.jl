module SimpleDraw

abstract type AbstractShape end

@inline function put_pixel!(image, i, j, color)
    if checkbounds(Bool, image, i, j)
        put_pixel_unchecked!(image, i, j, color)
    end

    return nothing
end

@inline function put_pixel_unchecked!(image, i, j, color)
    @inbounds image[i, j] = color
    return nothing
end

is_valid(::AbstractShape) = true

include("point.jl")
include("background.jl")
include("line.jl")
include("symmetry.jl")
include("circle.jl")
include("rectangle.jl")
include("bitmap.jl")
include("character.jl")
include("text.jl")
include("visualize.jl")

end
