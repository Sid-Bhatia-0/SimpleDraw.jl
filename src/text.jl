struct TextLine{I, S, F <: AbstractFont} <: AbstractShape
    position::Point{I}
    text::S
    font::F
end

function draw!(image::AbstractMatrix, shape::TextLine{I}, color) where {I}
    position = shape.position
    text = shape.text
    font = shape.font

    i_min = position.i
    j_min = position.j
    bitmap = font.bitmap

    height = size(bitmap, 1)
    width = size(bitmap, 2)

    char_position = position

    for char in text
        if isascii(char) && isprint(char)
            draw!(image, Character(char_position, char, font), color)
            char_position = Point(char_position.i, char_position.j + width)
        end
    end

    return nothing
end

function draw_unchecked!(image::AbstractMatrix, shape::TextLine{I}, color) where {I}
    position = shape.position
    text = shape.text
    font = shape.font

    i_min = position.i
    j_min = position.j
    bitmap = font.bitmap

    height = size(bitmap, 1)
    width = size(bitmap, 2)

    char_position = position

    for char in text
        if isascii(char) && isprint(char)
            draw_unchecked!(image, Character(char_position, char, font), color)
            char_position = Point(char_position.i, char_position.j + width)
        end
    end

    return nothing
end

function get_bounding_box(shape::TextLine{I}) where {I}
    position = shape.position
    text = shape.text
    font = shape.font

    i_min = position.i
    j_min = position.j

    height_character = size(font.bitmap, 1)
    width_character = size(font.bitmap, 2)

    char_position = position

    height_bounding_box = zero(I)
    width_bounding_box = zero(I)

    for char in text
        if isascii(char) && isprint(char)
            height_bounding_box = height_character
            width_bounding_box = width_bounding_box + width_character
        end
    end

    return Rectangle(position, height_bounding_box, width_bounding_box)
end
