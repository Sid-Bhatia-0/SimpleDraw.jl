mutable struct Background{C} <: AbstractDrawable
    color::C
end

function draw!(image::AbstractMatrix, drawable::Background)
    image[:, :] .= drawable.color
    return nothing
end
