struct Bitmap{I <: Integer, B <: AbstractMatrix{Bool}} <: AbstractShape
    position::Point{I}
    bitmap::B
end

get_i_min(shape::Bitmap) = shape.position.i
get_i_max(shape::Bitmap) = isempty(shape.bitmap) ? shape.position.i : shape.position.i + size(shape.bitmap, 1) - one(shape.position.i)

get_j_min(shape::Bitmap) = shape.position.j
get_j_max(shape::Bitmap) = isempty(shape.bitmap) ? shape.position.j : shape.position.j + size(shape.bitmap, 2) - one(shape.position.j)

move_i(shape::Bitmap, i) = Bitmap(move_i(shape.position, i), shape.bitmap)
move_j(shape::Bitmap, j) = Bitmap(move_j(shape.position, j), shape.bitmap)

function clip(image::AbstractMatrix, shape::Bitmap)
    position = shape.position
    bitmap = shape.bitmap

    if isempty(bitmap)
        return Bitmap(position, bitmap)
    end

    i_min_shape, i_max_shape = get_i_extrema(shape)
    i_min_image, i_max_image = get_i_extrema(image)

    I = typeof(i_min_shape)

    j_min_shape, j_max_shape = get_j_extrema(shape)
    j_min_image, j_max_image = get_j_extrema(image)

    clipped_height = min(i_max_shape, i_max_image) - max(i_min_shape, i_min_image) + one(I)
    clipped_width = min(j_max_shape, j_max_image) - max(j_min_shape, j_min_image) + one(I)

    clipped_bitmap = @view bitmap[begin:clipped_height, begin:clipped_width]

    return Bitmap(position, clipped_bitmap)
end

get_drawing_optimization_style(::Bitmap) = CLIP

function draw!(f::F, image::AbstractMatrix, shape::Bitmap, color) where {F <: Function}
    position = shape.position
    bitmap = shape.bitmap

    if isempty(bitmap)
        return nothing
    end

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
