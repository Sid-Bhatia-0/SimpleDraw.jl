struct Background <: AbstractShape end

draw!(image::AbstractMatrix, shape::Background, color) = _draw!(image, shape, color)

function _draw!(image::AbstractMatrix, shape::Background, color)
    fill!(image, color)
    return nothing
end

function _draw!(f::Function, image::AbstractMatrix, shape::Background, color)
    for j in axes(image, 2)
        for i in axes(image, 1)
            f(image, i, j, color)
        end
    end

    return nothing
end
