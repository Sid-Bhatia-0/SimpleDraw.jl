struct Background <: AbstractShape end

@inline function draw!(image::AbstractMatrix, shape::Background, color)
    fill!(image, color)
    return nothing
end
