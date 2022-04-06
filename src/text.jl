struct TextLine{I, S, F <: AbstractFont} <: AbstractShape
    position::Point{I}
    text::S
    font::F
end

get_drawing_optimization_style(::TextLine) = PUT_PIXEL

function draw!(f::F, image::AbstractMatrix, shape::TextLine, color) where {F <: Function}
    position = shape.position
    text = shape.text
    font = shape.font

    bitmap = font.bitmap

    height = size(bitmap, 1)
    width = size(bitmap, 2)

    char_position = position

    for char in text
        draw!(f, image, Character(char_position, char, font), color)
        if isprint(char)
            char_position = Point(char_position.i, char_position.j + width)
        end
    end

    return nothing
end
