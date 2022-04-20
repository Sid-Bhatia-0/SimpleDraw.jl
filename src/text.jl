struct TextLine{I <: Integer, S, F <: AbstractFont} <: AbstractShape
    position::Point{I}
    text::S
    font::F
end

get_drawing_optimization_style(::TextLine) = PUT_PIXEL

function get_num_printable(shape::TextLine)
    num_printable = 0

    for character in shape.text
        if isprint(character)
            num_printable += 1
        end
    end

    return num_printable
end

get_i_min(shape::TextLine) = shape.position.i

function get_i_max(shape::TextLine)
    num_printable = get_num_printable(shape)

    if num_printable > zero(num_printable)
        return shape.position.i + get_height(shape.font) - one(shape.position.i)
    else
        return shape.position.i
    end
end

get_j_min(shape::TextLine) = shape.position.j

function get_j_max(shape::TextLine)
    num_printable = get_num_printable(shape)

    if num_printable > zero(num_printable)
        return shape.position.j + num_printable * get_width(shape.font) - one(shape.position.j)
    else
        return shape.position.j
    end
end

move_i(shape::TextLine, i) = TextLine(move_i(shape.position, i), shape.text, shape.font)
move_j(shape::TextLine, j) = TextLine(move_j(shape.position, j), shape.text, shape.font)

function draw!(f::F, image::AbstractMatrix, shape::TextLine, color) where {F <: Function}
    position = shape.position
    text = shape.text
    font = shape.font

    bitmap = font.bitmap

    height = size(bitmap, 1)
    width = size(bitmap, 2)

    char_position = position

    for character in text
        draw!(f, image, Character(char_position, character, font), color)
        if isprint(character)
            char_position = Point(char_position.i, char_position.j + width)
        end
    end

    return nothing
end
