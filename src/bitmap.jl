struct Bitmap{I, B <: AbstractMatrix{Bool}} <: AbstractShape
    position::Point{I}
    bitmap::B
end

function is_outbounds(shape::Bitmap, image::AbstractMatrix)
    position = shape.position
    i_position = position.i
    j_position = position.j
    bitmap = shape.bitmap

    I = typeof(i_position)
    one_value = one(I)

    height = size(bitmap, 1)
    width = size(bitmap, 2)

    i_min = i_position
    j_min = j_position

    i_max = i_min + height - one_value
    j_max = j_min + width - one_value

    i_min_image = firstindex(image, 1)
    i_max_image = lastindex(image, 1)

    j_min_image = firstindex(image, 2)
    j_max_image = lastindex(image, 2)

    return i_max < i_min_image || i_min > i_max_image || j_max < j_min_image || j_min > j_max_image
end

function clip(shape::Bitmap, image::AbstractMatrix)
    position = shape.position
    i_position = position.i
    j_position = position.j
    bitmap = shape.bitmap

    I = typeof(i_position)
    one_value = one(I)

    i_min = i_position
    j_min = j_position

    height = size(bitmap, 1)
    width = size(bitmap, 2)

    i_max = i_min + height - one_value
    j_max = j_min + width - one_value

    i_min_image = firstindex(image, 1)
    i_max_image = lastindex(image, 1)

    j_min_image = firstindex(image, 2)
    j_max_image = lastindex(image, 2)

    clipped_height = min(i_max, i_max_image) - max(i_min, i_min_image) + one_value
    clipped_width = min(j_max, j_max_image) - max(j_min, j_min_image) + one_value
    clipped_bitmap = @view bitmap[begin:clipped_height, begin:clipped_width]

    return Bitmap(position, clipped_bitmap)
end

function draw!(image::AbstractMatrix, shape::Bitmap, color)
    if is_outbounds(shape, image)
        return nothing
    end

    _draw!(image, clip(shape, image), color)

    return nothing
end

_draw!(image::AbstractMatrix, shape::Bitmap, color) = _draw!(put_pixel_unchecked!, image, shape, color)

function _draw!(f::Function, image::AbstractMatrix, shape::Bitmap, color)
    position = shape.position
    i_position = position.i
    j_position = position.j
    bitmap = shape.bitmap

    I = typeof(i_position)
    one_value = one(I)

    height = size(bitmap, 1)
    width = size(bitmap, 2)

    i_min = i_position
    j_min = j_position

    i_max = i_min + height - one_value
    j_max = j_min + width - one_value

    for j in j_min:j_max
        for i in i_min:i_max
            i_bitmap = i - i_position + one_value
            j_bitmap = j - j_position + one_value
            if bitmap[i_bitmap, j_bitmap]
                f(image, i, j, color)
            end
        end
    end

    return nothing
end

function get_bounding_box(shape::Bitmap)
    position = shape.position
    bitmap = shape.bitmap

    height = size(bitmap, 1)
    width = size(bitmap, 2)

    return Rectangle(position, height, width)
end
