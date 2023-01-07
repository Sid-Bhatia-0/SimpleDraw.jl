struct FontInfo
    height::Int
    width::Int
    encodings
    font_file_name::String
    font_instance_name::String
end

function get_bitmap(font_info)
    height = font_info.height
    width = font_info.width
    encodings = font_info.encodings
    font_file_name = font_info.font_file_name

    bitmap = falses(height, width, length(encodings))

    lines = readlines(font_file_name)
    filter!(line -> (startswith(line, "ENCODING") || !isnothing(tryparse(UInt, "0x" * line))), lines)

    n = length(lines[2]) * 4

    if n == 8
        T = UInt8
    elseif n == 16
        T = UInt16
    elseif n == 32
        T = UInt32
    elseif n == 64
        T = UInt64
    elseif n == 128
        T = UInt128
    end

    first_encoding = first(encodings)

    for encoding in encodings
        i = findfirst(==("ENCODING $(encoding)"), lines)
        @assert !isnothing(i) "encoding $(i) not found"
        start_line = i + 1
        end_line = i + height
        relevant_lines = @view lines[start_line:end_line]
        fill_bitmap!(bitmap, relevant_lines, encoding - first_encoding + 1, T)
    end

    return bitmap
end

function fill_bitmap!(bitmap, lines, k, T)
    height, width, _ = size(bitmap)

    for i in 1:height
        line = lines[i]
        bits = bitstring(parse(T, "0x" * line))
        for j in 1:width
            bit = bits[j]
            if bit == '1'
                bitmap[i, j, k] = true
            else
                bitmap[i, j, k] = false
            end
        end
    end

    return nothing
end

function generate_julia_font_file(font_info)
    bitmap = get_bitmap(font_info)
    height, width, num_encodings = size(bitmap)
    font_instance_name = font_info.font_instance_name

    file = open("GLYPHS_" * font_instance_name * ".jl", "w")

    println(file, "const GLYPHS_$(font_instance_name) = falses($(height), $(width), $(num_encodings))")
    println(file)

    for k in 1:num_encodings
        println(file, "GLYPHS_$(font_instance_name)[:, :, $(k)] = [")

        for i in 1:height
            for j in 1:width
                if bitmap[i, j, k]
                    print(file, "1")
                else
                    print(file, "0")
                end

                if j != width
                    print(file, " ")
                else
                    print(file, "\n")
                end
            end
        end

        println(file, "]")
        if k != num_encodings
            println(file)
        end
    end

    close(file)

    return nothing
end
