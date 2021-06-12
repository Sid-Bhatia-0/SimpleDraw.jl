function visualize(io::IO, image::AbstractMatrix{Bool})
    height, width = size(image)
    for i in 1:height
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
