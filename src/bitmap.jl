struct Bitmap{I <: Integer, B <: AbstractMatrix{Bool}} <: AbstractShape
    position::Point{I}
    bitmap::B
end

is_valid(shape::Bitmap) = !isempty(shape.bitmap)

get_i_min(shape::Bitmap) = shape.position.i
get_i_max(shape::Bitmap) = shape.position.i + size(shape.bitmap, 1) - one(shape.position.i)

get_j_min(shape::Bitmap) = shape.position.j
get_j_max(shape::Bitmap) = shape.position.j + size(shape.bitmap, 2) - one(shape.position.j)

move_i(shape::Bitmap, i) = Bitmap(move_i(shape.position, i), shape.bitmap)
move_j(shape::Bitmap, j) = Bitmap(move_j(shape.position, j), shape.bitmap)

function clip(image, shape::Bitmap)
    position = shape.position
    bitmap = shape.bitmap

    # assuming shape is not outbounds, !isempty(shape.image), and it has an overlap region with the image

    i_min_shape, i_max_shape = get_i_extrema(shape)
    i_min_image, i_max_image = get_i_extrema(image)

    I = typeof(i_min_shape)

    j_min_shape, j_max_shape = get_j_extrema(shape)
    j_min_image, j_max_image = get_j_extrema(image)

    delta_i_min = i_min_image - i_min_shape
    if delta_i_min > zero(delta_i_min)
        i_new_position = i_min_image
        i_begin = firstindex(bitmap, 1) + delta_i_min
    else
        i_new_position = position.i
        i_begin = firstindex(bitmap, 1)
    end

    delta_i_max = i_max_shape - i_max_image
    if delta_i_max > zero(delta_i_max)
        i_end = lastindex(bitmap, 1) - delta_i_max
    else
        i_end = lastindex(bitmap, 1)
    end

    delta_j_min = j_min_image - j_min_shape
    if delta_j_min > zero(delta_j_min)
        j_new_position = j_min_image
        j_begin = firstindex(bitmap, 2) + delta_j_min
    else
        j_new_position = position.j
        j_begin = firstindex(bitmap, 2)
    end

    delta_j_max = j_max_shape - j_max_image
    if delta_j_max > zero(delta_j_max)
        j_end = lastindex(bitmap, 2) - delta_j_max
    else
        j_end = lastindex(bitmap, 2)
    end

    return Bitmap(Point(i_new_position, j_new_position), @view bitmap[i_begin:i_end, j_begin:j_end])
end

get_drawing_optimization_style(::Bitmap) = CLIP

function _draw!(f::F, image, shape::Bitmap, color) where {F <: Function}
    @assert is_valid(shape) "Cannot draw invalid shape $(shape)"

    position = shape.position
    bitmap = shape.bitmap

    i_position = position.i
    j_position = position.j

    I = typeof(i_position)

    i_min, i_max = get_i_extrema(shape)
    j_min, j_max = get_j_extrema(shape)

    for j in j_min:j_max
        for i in i_min:i_max
            i_bitmap = i - i_position + one(I)
            j_bitmap = j - j_position + one(I)
            if bitmap[i_bitmap, j_bitmap]
                f(image, i, j, color)
            end
        end
    end

    return nothing
end
