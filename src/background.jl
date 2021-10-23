struct Background <: AbstractShape end

@inline draw!(image::AbstractMatrix, shape::Background, color) = draw_inbounds!(image, shape, color)

@inline function draw_inbounds!(image::AbstractMatrix, shape::Background, color)
    fill!(image, color)
    return nothing
end
