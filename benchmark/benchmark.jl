import BenchmarkTools as BT
import Dates
import SimpleDraw as SD

const SHAPES = [
                SD.Point,
                SD.Background,
                SD.Line,
                SD.VerticalLine,
                SD.HorizontalLine,
                SD.ThickLine,
                SD.Circle,
                SD.ThickCircle,
                SD.FilledCircle,
                SD.Rectangle,
                SD.ThickRectangle,
                SD.FilledRectangle,
                SD.Cross,
                SD.HollowCross,
               ]

const SIZES = [64, 256, 1024]

get_shape(::Type{SD.Point}, n) = SD.Point(n ÷ 2, n ÷ 2)
get_shape(::Type{SD.Background}, n) = SD.Background()
get_shape(::Type{SD.VerticalLine}, n) = SD.VerticalLine(2, n - 1, n ÷ 2)
get_shape(::Type{SD.HorizontalLine}, n) = SD.HorizontalLine(n ÷ 2, 2, n - 1)
get_shape(::Type{SD.Line}, n) = SD.Line(SD.Point(3, 2), SD.Point(n - 2, n - 1))
get_shape(::Type{SD.ThickLine}, n) = SD.ThickLine(SD.Point(n ÷ 8, n ÷ 8), SD.Point(n - n ÷ 8 + 1, n - n ÷ 8 + 1), n ÷ 8)
get_shape(::Type{SD.Circle}, n) = SD.Circle(SD.Point(2, 2), n - 2)
get_shape(::Type{SD.ThickCircle}, n) = SD.ThickCircle(SD.Point(2, 2), n - 2, n ÷ 4)
get_shape(::Type{SD.FilledCircle}, n) = SD.FilledCircle(SD.Point(2, 2), n - 2)
get_shape(::Type{SD.Rectangle}, n) = SD.Rectangle(SD.Point(2, 2), n - 1, n - 1)
get_shape(::Type{SD.ThickRectangle}, n) = SD.ThickRectangle(SD.Point(2, 2), n - 1, n - 1, n ÷ 4)
get_shape(::Type{SD.FilledRectangle}, n) = SD.FilledRectangle(SD.Point(2, 2), n - 1, n - 1)
get_shape(::Type{SD.Cross}, n) = SD.Cross(SD.Point(2, 2), n - 2)
get_shape(::Type{SD.HollowCross}, n) = SD.HollowCross(SD.Point(2, 2), n - 2)

function get_benchmarks(shape_types, sizes)
    benchmarks = Dict()

    color = 0x00ffffff
    for n in sizes
        image = zeros(typeof(color), n, n)
        for Shape in shape_types
            shape = get_shape(Shape, n)
            benchmark = BT.@benchmark SD.draw!($(Ref(image))[], $(Ref(shape))[], $(Ref(color))[])
            benchmarks[(nameof(Shape), n)] = get_summary(benchmark)
            @info "(shape = $(nameof(Shape)), n = $(n)) benchmark complete"
        end
        fill!(image, zero(color))
    end

    return benchmarks
end

function get_summary(trial::BT.Trial)
    median_trial = BT.median(trial)
    memory = BT.prettymemory(median_trial.memory)
    median_time = BT.prettytime(median_trial.time)
    return memory, median_time
end

function get_table(shape_types, sizes, benchmarks)
    table = "| |"
    for n in sizes
        table = table * "$(n)|"
    end
    table = table * "\n"

    table = table * "|"
    for _ in 1:length(sizes)+1
        table = table * ":---:|"
    end
    table = table * "\n"

    for Shape in shape_types
        shape_name = nameof(Shape)
        table = table * "|"
        table = table * "$(shape_name)|"

        for n in sizes
            memory, median_time = benchmarks[(shape_name, n)]
            table = table * "$(median_time)<br>$(memory)|"
        end
        table = table * "\n"
    end

    return table
end

function generate_benchmark_file(; shape_types = SHAPES, sizes = SIZES, file_name = nothing)
    date = Dates.format(Dates.now(), "yyyy_mm_dd_HH_MM_SS")

    if isnothing(file_name)
        file_name = date * ".md"
    end

    io = open(file_name, "w")

    println(io, "Date: $(date) (yyyy_mm_dd_HH_MM_SS)")
    println(io)
    println(io, "**Note:** The time in benchmarks is the median time.")
    println(io)

    benchmarks = get_benchmarks(shape_types, sizes)

    table = get_table(shape_types, sizes, benchmarks)

    println(io, table)

    close(io)

    return nothing
end
