include("benchmark.jl")

# run everything once to make sure everything is compiled
# throw away the results of this run
generate_benchmark_file(file_name = tempname())

# save the results of this run
generate_benchmark_file()
