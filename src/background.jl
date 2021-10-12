struct Background <: AbstractShape end

function draw!(image::AbstractMatrix, shape::Background, color)
    image[:, :] .= color
    return nothing
end
