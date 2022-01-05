include("benchmark.jl")

println("####################################################")
println("Ingore the first set of benchmarks. They are run so as to make sure that everything is compiled once.")
println("####################################################")
generate_benchmark_file(file_name = tempname())

println("####################################################")
println("Everything has been compiled once. The following are the final benchmarks.")
println("####################################################")
generate_benchmark_file()
