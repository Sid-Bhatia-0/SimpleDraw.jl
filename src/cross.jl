struct Cross{I <: Integer} <: AbstractShape
    center::Point{I}
    radius::I
end

struct HollowCross{I <: Integer} <: AbstractShape
    center::Point{I}
    radius::I
end

function draw!(image::AbstractMatrix, shape::Cross{I}, color) where {I}
    center = shape.center
    i_center = center.i
    j_center = center.j
    radius = shape.radius

    zero_value = zero(I)
    one_value = one(I)

    if radius < zero_value
        return nothing
    end

    i_min = i_center - radius
    j_min = j_center - radius

    i_max = i_center + radius
    j_max = j_center + radius

    i_min_image = firstindex(image, 1)
    i_max_image = lastindex(image, 1)

    j_min_image = firstindex(image, 2)
    j_max_image = lastindex(image, 2)

    if i_max < i_min_image || i_min > i_max_image || j_max < j_min_image || j_min > j_max_image
        return nothing
    end

    if radius == zero_value
        draw!(image, center, color)
        return nothing
    end

    if i_min >= i_min_image && j_min >= j_min_image && i_max <= i_max_image && j_max <= j_max_image
        draw_unchecked!(image, shape, color)
        return nothing
    end

    draw!(image, HorizontalLine(i_center, j_min, j_max), color)
    draw!(image, VerticalLine(i_min, i_max, j_center), color)

    return nothing
end

function draw_unchecked!(image::AbstractMatrix, shape::Cross, color)
    center = shape.center
    i_center = center.i
    j_center = center.j
    radius = shape.radius

    draw_unchecked!(image, HorizontalLine(i_center, j_center - radius, j_center + radius), color)
    draw_unchecked!(image, VerticalLine(i_center - radius, i_center + radius, j_center), color)

    return nothing
end

function draw!(image::AbstractMatrix, shape::HollowCross{I}, color) where {I}
    center = shape.center
    i_center = center.i
    j_center = center.j
    radius = shape.radius

    zero_value = zero(I)
    one_value = one(I)

    if radius < one_value
        return nothing
    end

    i_min = i_center - radius
    j_min = j_center - radius

    i_max = i_center + radius
    j_max = j_center + radius

    i_min_image = firstindex(image, 1)
    i_max_image = lastindex(image, 1)

    j_min_image = firstindex(image, 2)
    j_max_image = lastindex(image, 2)

    if i_max < i_min_image || i_min > i_max_image || j_max < j_min_image || j_min > j_max_image
        return nothing
    end

    if i_min >= i_min_image && j_min >= j_min_image && i_max <= i_max_image && j_max <= j_max_image
        draw_unchecked!(image, shape, color)
        return nothing
    end

    draw!(image, HorizontalLine(i_center, j_min, j_center - one_value), color)
    draw!(image, VerticalLine(i_min, i_center - one_value, j_center), color)
    draw!(image, VerticalLine(i_center + one_value, i_max, j_center), color)
    draw!(image, HorizontalLine(i_center, j_center + one_value, j_max), color)

    return nothing
end

function draw_unchecked!(image::AbstractMatrix, shape::HollowCross{I}, color) where {I}
    center = shape.center
    i_center = center.i
    j_center = center.j
    radius = shape.radius

    one_value = one(I)

    i_min = i_center - radius
    i_max = i_center + radius

    j_min = j_center - radius
    j_max = j_center + radius

    draw_unchecked!(image, HorizontalLine(i_center, j_min, j_center - one_value), color)
    draw_unchecked!(image, VerticalLine(i_min, i_center - one_value, j_center), color)
    draw_unchecked!(image, VerticalLine(i_center + one_value, i_max, j_center), color)
    draw_unchecked!(image, HorizontalLine(i_center, j_center + one_value, j_max), color)

    return nothing
end

get_bounding_box(shape::Cross) = get_bounding_box(Circle(shape.center, shape.radius))
get_bounding_box(shape::HollowCross) = get_bounding_box(Circle(shape.center, shape.radius))
