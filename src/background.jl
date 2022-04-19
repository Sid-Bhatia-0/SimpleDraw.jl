struct Background <: AbstractShape end

get_drawing_optimization_style(::Background) = PUT_PIXEL_INBOUNDS

get_i_min(shape::Background) = error("i_min for $(shape) depends upon the type of image. Cannot determine it solely based on the shape")
get_i_max(shape::Background) = error("i_max for $(shape) depends upon the type of image. Cannot determine it solely based on the shape")

get_j_min(shape::Background) = error("j_min for $(shape) depends upon the type of image. Cannot determine it solely based on the shape")
get_j_max(shape::Background) = error("j_max for $(shape) depends upon the type of image. Cannot determine it solely based on the shape")

function draw!(f::F, image::AbstractMatrix, shape::Background, color) where {F <: Function}
    for j in axes(image, 2)
        for i in axes(image, 1)
            f(image, i, j, color)
        end
    end

    return nothing
end
