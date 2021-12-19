struct Background <: AbstractShape end

draw!(image::AbstractMatrix, shape::Background, color) = _draw!(put_pixel_unchecked!, image, shape, color)

function _draw!(f::Function, image::AbstractMatrix, shape::Background, color)
    for j in axes(image, 2)
        for i in axes(image, 1)
            f(image, i, j, color)
        end
    end

    return nothing
end
