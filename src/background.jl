struct Background <: AbstractShape end

@inline draw!(image::AbstractMatrix, shape::Background, color) = _draw!(image, shape, color)

@inline function _draw!(image::AbstractMatrix, shape::Background, color)
    fill!(image, color)
    return nothing
end
