struct Background <: AbstractShape end

@inline draw!(image::AbstractMatrix, shape::Background, color) = draw_unchecked!(image, shape, color)

@inline function draw_unchecked!(image::AbstractMatrix, shape::Background, color)
    @inbounds image[:, :] .= color
    return nothing
end
