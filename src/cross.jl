struct Cross{I <: Integer} <: AbstractShape
    center::Point{I}
    radius::I
end

struct HollowCross{I <: Integer} <: AbstractShape
    center::Point{I}
    radius::I
end

function draw!(image::AbstractMatrix, shape::Cross, color)
    center = shape.center
    i_center = center.i
    j_center = center.j
    radius = shape.radius

    i_start = i_center - radius
    i_end = i_center + radius

    j_start = j_center - radius
    j_end = j_center + radius

    if checkbounds(Bool, image, i_start, j_start) && checkbounds(Bool, image, i_end, j_end)
        draw_inbounds!(image, shape, color)
        return nothing
    end

    draw!(image, HorizontalLine(i_center, j_start, j_end), color)
    draw!(image, VerticalLine(i_start, i_end, j_center), color)

    return nothing
end

function draw_inbounds!(image::AbstractMatrix, shape::Cross, color)
    center = shape.center
    i_center = center.i
    j_center = center.j
    radius = shape.radius

    draw_inbounds!(image, HorizontalLine(i_center, j_center - radius, j_center + radius), color)
    draw_inbounds!(image, VerticalLine(i_center - radius, i_center + radius, j_center), color)

    return nothing
end

function draw!(image::AbstractMatrix, shape::HollowCross, color)
    center = shape.center
    i_center = center.i
    j_center = center.j
    radius = shape.radius

    i_start = i_center - radius
    i_end = i_center + radius

    j_start = j_center - radius
    j_end = j_center + radius

    if checkbounds(Bool, image, i_start, j_start) && checkbounds(Bool, image, i_end, j_end)
        draw_inbounds!(image, shape, color)
        return nothing
    end

    draw!(image, HorizontalLine(i_center, j_start, j_center - 1), color)
    draw!(image, VerticalLine(i_start, i_center - 1, j_center), color)
    draw!(image, VerticalLine(i_center + 1, i_end, j_center), color)
    draw!(image, HorizontalLine(i_center, j_center + 1, j_end), color)

    return nothing
end

function draw_inbounds!(image::AbstractMatrix, shape::HollowCross, color)
    center = shape.center
    i_center = center.i
    j_center = center.j
    radius = shape.radius

    i_start = i_center - radius
    i_end = i_center + radius

    j_start = j_center - radius
    j_end = j_center + radius

    draw_inbounds!(image, HorizontalLine(i_center, j_start, j_center - 1), color)
    draw_inbounds!(image, VerticalLine(i_start, i_center - 1, j_center), color)
    draw_inbounds!(image, VerticalLine(i_center + 1, i_end, j_center), color)
    draw_inbounds!(image, HorizontalLine(i_center, j_center + 1, j_end), color)

    return nothing
end
