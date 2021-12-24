struct TextLine{I, S, F <: AbstractFont} <: AbstractShape
    position::Point{I}
    text::S
    font::F
end

is_valid(shape::TextLine) = all(x -> has_char(shape.font, x), shape.text)

get_drawing_optimization_style(::TextLine) = PUT_PIXEL

function draw!(f::Function, image::AbstractMatrix, shape::TextLine, color)
    @assert is_valid(shape) "Cannot draw invalid shape $(shape)"

    position = shape.position
    text = shape.text
    font = shape.font

    bitmap = font.bitmap

    height = size(bitmap, 1)
    width = size(bitmap, 2)

    char_position = position

    for char in text
        draw!(f, image, Character(char_position, char, font), color)
        char_position = Point(char_position.i, char_position.j + width)
    end

    return nothing
end
