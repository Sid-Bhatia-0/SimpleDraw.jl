struct Background <: AbstractShape end

get_drawing_optimization_style(::Background) = PUT_PIXEL_UNCHECKED

function draw!(f::Function, image::AbstractMatrix, shape::Background, color)
    for j in axes(image, 2)
        for i in axes(image, 1)
            f(image, i, j, color)
        end
    end

    return nothing
end
