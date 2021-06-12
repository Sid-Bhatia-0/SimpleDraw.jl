import SimpleDraw as SD
import Test

Test.@testset "SimpleDraw.jl" begin
    height = 16
    width = 16
    image = falses(height, width)

    Test.@testset "Line" begin
        line = SD.Line(2, 2, height - 1, width - 1)
        SD.draw!(image, line, true)
        Test.@test image == BitArray([
                                      0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                                      0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                                      0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0
                                      0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0
                                      0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0
                                      0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0
                                      0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0
                                      0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0
                                      0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0
                                      0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0
                                      0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0
                                      0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0
                                      0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0
                                      0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0
                                      0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0
                                      0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                                     ])
    end
end
