struct Background <: AbstractShape end

function draw!(image::AbstractMatrix, shape::Background, color)
    fill!(image, color)
    return nothing
end
