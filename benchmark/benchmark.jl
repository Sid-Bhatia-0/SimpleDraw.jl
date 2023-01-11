import BenchmarkTools as BT
import Dates
import SimpleDraw as SD

const SHAPE_TYPES = [
                     SD.Background,
                     SD.Point,
                     SD.Line,
                     SD.ThickLine,
                     SD.Triangle,
                     SD.FilledTriangle,
                     SD.Rectangle,
                     SD.FilledRectangle,
                     SD.ThickRectangle,
                     SD.Circle,
                     SD.FilledCircle,
                     SD.ThickCircle,
                     SD.Bitmap,
                     SD.Character,
                     SD.TextLine,
                    ]

const SIZES = [64, 256, 1024]

get_shape(::Type{SD.Background}, n) = SD.Background()
get_shape(::Type{SD.Point}, n) = SD.Point(n ÷ 2 + 1, n ÷ 2 + 1)
get_shape(::Type{SD.Line}, n) = SD.Line(SD.Point(n ÷ 8 + 1, 2), SD.Point((7 * n) ÷ 8, n - 1))
get_shape(::Type{SD.ThickLine}, n) = SD.ThickLine(SD.Point(n ÷ 8 + 1, n ÷ 8 + 1), SD.Point((7 * n) ÷ 8, (7 * n) ÷ 8), (n ÷ 8) - 1)
get_shape(::Type{SD.Triangle}, n) = SD.Triangle(SD.Point(2, 2), SD.Point(n - 1, n ÷ 2), SD.Point(n ÷ 2, n -1))
get_shape(::Type{SD.FilledTriangle}, n) = SD.FilledTriangle(SD.Point(2, 2), SD.Point(n - 1, n ÷ 2), SD.Point(n ÷ 2, n -1))
get_shape(::Type{SD.Rectangle}, n) = SD.Rectangle(SD.Point(2, 2), n - 1, n - 1)
get_shape(::Type{SD.FilledRectangle}, n) = SD.FilledRectangle(SD.Point(2, 2), n - 1, n - 1)
get_shape(::Type{SD.ThickRectangle}, n) = SD.ThickRectangle(SD.Point(2, 2), n - 1, n - 1, n ÷ 4)
get_shape(::Type{SD.Circle}, n) = SD.Circle(SD.Point(2, 2), n - 2)
get_shape(::Type{SD.FilledCircle}, n) = SD.FilledCircle(SD.Point(2, 2), n - 2)
get_shape(::Type{SD.ThickCircle}, n) = SD.ThickCircle(SD.Point(2, 2), n - 2, n ÷ 4)

function get_shape(::Type{SD.Bitmap}, n)
    position = SD.Point(2, 2)
    bitmap = falses(n - 2, n - 2)
    for j in 1:size(bitmap, 2)
        for i in 1:size(bitmap, 1)
            bitmap[i, j] = iseven(i + j)
        end
    end

    return SD.Bitmap(position, bitmap)
end

get_shape(::Type{SD.Character}, n) = SD.Character(SD.Point(2, 2), 'A', SD.TERMINUS_32_16)

function get_shape(::Type{SD.TextLine}, n)
    str = ""
    for j in 1 : n ÷ 16
        str = str * Char(rand(65:90))
    end

    return SD.TextLine(SD.Point(1, 1), str, SD.TERMINUS_32_16)
end

function get_benchmarks(shape_types, sizes)
    benchmarks = Dict()

    color = 0x00ffffff
    for n in sizes
        image = zeros(typeof(color), n, n)
        for ShapeType in shape_types
            shape_name = nameof(ShapeType)
            shape = get_shape(ShapeType, n)
            benchmark = BT.@benchmark SD.draw!($(Ref(image))[], $(Ref(shape))[], $(Ref(color))[])
            memory, median_time = get_summary(benchmark)
            benchmarks[(shape_name, n)] = (shape, memory, median_time)
            println("############################")
            println("shape type = $(shape_name)")
            println("image height = $(n)")
            println("image width = $(n)")
            println("median_time = $(median_time)")
            println("memory = $(memory)")
            println("shape = $(Base.limitrepr(shape))")
        end
        fill!(image, zero(color))
    end

    return benchmarks
end

function get_summary(trial)
    median_trial = BT.median(trial)
    memory = BT.prettymemory(median_trial.memory)
    median_time = BT.prettytime(median_trial.time)
    return memory, median_time
end

function get_table(shape_types, sizes, benchmarks)
    table = "|shape type|"
    table = table * "image height|"
    table = table * "image width|"
    table = table * "median time|"
    table = table * "memory|"
    table = table * "shape|"
    table = table * "\n"

    table = table * ":---|"
    table = table * ":---|"
    table = table * ":---|"
    table = table * ":---|"
    table = table * ":---|"
    table = table * ":---|"
    table = table * "\n"

    for ShapeType in shape_types
        for n in sizes
            shape_name = nameof(ShapeType)
            shape, memory, median_time = benchmarks[(shape_name, n)]

            table = table * "|"
            table = table * "$(shape_name)|"
            table = table * "$(n)|"
            table = table * "$(n)|"
            table = table * "$(median_time)|"
            table = table * "$(memory)|"
            table = table * "$(Base.limitrepr(shape))|"
            table = table * "\n"
        end
    end

    return table
end

function generate_benchmark_file(; shape_types = SHAPE_TYPES, sizes = SIZES, file_name = nothing)
    date = Dates.format(Dates.now(), "yyyy_mm_dd_HH_MM_SS")

    if isnothing(file_name)
        file_name = date * ".md"
    end

    io = open(file_name, "w")

    println(io, "Timestamp: $(date) (yyyy_mm_dd_HH_MM_SS)")
    println(io)
    println(io, "Shapes are drawn on an image of type `Matrix{UInt32}` with a color of type `UInt32`")
    println(io)

    benchmarks = get_benchmarks(shape_types, sizes)

    table = get_table(shape_types, sizes, benchmarks)

    println(io, table)

    close(io)

    return nothing
end
