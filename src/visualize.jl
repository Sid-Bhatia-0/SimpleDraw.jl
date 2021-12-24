function get_axis_label(i::Integer)
    if 0 <= i <= 9
        return "0$(i)"
    elseif 10 <= i <= 99
        return "$(i)"
    else
        return "  "
    end
end

function visualize(io::IO, image::AbstractMatrix{Bool})
    height, width = size(image)

    print(io, "  ")
    for j in 1:width
        print(io, get_axis_label(j))
    end
    println(io)

    for i in 1:height
        print(io, get_axis_label(i))

        for j in 1:width
            if image[i, j]
                print(io, "██")
            else
                if iseven(i + j)
                    print(io, "░░")
                else
                    print(io, "▒▒")
                end
            end
        end
        println(io)
    end

    return nothing
end

visualize(image::AbstractMatrix) = visualize(stdout, image)
