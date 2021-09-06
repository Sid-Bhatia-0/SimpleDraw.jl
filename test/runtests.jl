import SimpleDraw as SD
import Test

Test.@testset "SimpleDraw.jl" begin

    Test.@testset "Line" begin
        height = 16
        width = 16
        image = falses(height, width)
        drawable = SD.Background(true)
        SD.draw!(image, drawable)
        Test.@test image == BitArray([
                                      1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
                                      1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
                                      1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
                                      1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
                                      1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
                                      1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
                                      1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
                                      1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
                                      1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
                                      1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
                                      1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
                                      1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
                                      1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
                                      1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
                                      1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
                                      1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
                                     ])
    end

    Test.@testset "Line" begin
        height = 16
        width = 16
        image = falses(height, width)
        drawable = SD.Line(2, 2, height - 1, width - 1, true)
        SD.draw!(image, drawable)
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

    Test.@testset "Circle" begin
        height = 16
        width = 16
        image = falses(height, width)
        drawable = SD.Circle(8, 8, 6, true)
        SD.draw!(image, drawable)
        Test.@test image == BitArray([
                                      0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                                      0 0 0 0 0 1 1 1 1 1 0 0 0 0 0 0
                                      0 0 0 0 1 0 0 0 0 0 1 0 0 0 0 0
                                      0 0 0 1 0 0 0 0 0 0 0 1 0 0 0 0
                                      0 0 1 0 0 0 0 0 0 0 0 0 1 0 0 0
                                      0 1 0 0 0 0 0 0 0 0 0 0 0 1 0 0
                                      0 1 0 0 0 0 0 0 0 0 0 0 0 1 0 0
                                      0 1 0 0 0 0 0 0 0 0 0 0 0 1 0 0
                                      0 1 0 0 0 0 0 0 0 0 0 0 0 1 0 0
                                      0 1 0 0 0 0 0 0 0 0 0 0 0 1 0 0
                                      0 0 1 0 0 0 0 0 0 0 0 0 1 0 0 0
                                      0 0 0 1 0 0 0 0 0 0 0 1 0 0 0 0
                                      0 0 0 0 1 0 0 0 0 0 1 0 0 0 0 0
                                      0 0 0 0 0 1 1 1 1 1 0 0 0 0 0 0
                                      0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                                      0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                                     ])
    end

    Test.@testset "FilledCircle" begin
        height = 16
        width = 16
        image = falses(height, width)
        drawable = SD.FilledCircle(8, 8, 6, true)
        SD.draw!(image, drawable)
        Test.@test image == BitArray([
                                      0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                                      0 0 0 0 0 1 1 1 1 1 0 0 0 0 0 0
                                      0 0 0 0 1 1 1 1 1 1 1 0 0 0 0 0
                                      0 0 0 1 1 1 1 1 1 1 1 1 0 0 0 0
                                      0 0 1 1 1 1 1 1 1 1 1 1 1 0 0 0
                                      0 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0
                                      0 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0
                                      0 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0
                                      0 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0
                                      0 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0
                                      0 0 1 1 1 1 1 1 1 1 1 1 1 0 0 0
                                      0 0 0 1 1 1 1 1 1 1 1 1 0 0 0 0
                                      0 0 0 0 1 1 1 1 1 1 1 0 0 0 0 0
                                      0 0 0 0 0 1 1 1 1 1 0 0 0 0 0 0
                                      0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                                      0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                                     ])
    end

    Test.@testset "Rectangle" begin
        height = 16
        width = 16
        image = falses(height, width)
        drawable = SD.Rectangle(2, 2, height - 2, width - 2, true)
        SD.draw!(image, drawable)
        Test.@test image == BitArray([
                                      0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                                      0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0
                                      0 1 0 0 0 0 0 0 0 0 0 0 0 0 1 0
                                      0 1 0 0 0 0 0 0 0 0 0 0 0 0 1 0
                                      0 1 0 0 0 0 0 0 0 0 0 0 0 0 1 0
                                      0 1 0 0 0 0 0 0 0 0 0 0 0 0 1 0
                                      0 1 0 0 0 0 0 0 0 0 0 0 0 0 1 0
                                      0 1 0 0 0 0 0 0 0 0 0 0 0 0 1 0
                                      0 1 0 0 0 0 0 0 0 0 0 0 0 0 1 0
                                      0 1 0 0 0 0 0 0 0 0 0 0 0 0 1 0
                                      0 1 0 0 0 0 0 0 0 0 0 0 0 0 1 0
                                      0 1 0 0 0 0 0 0 0 0 0 0 0 0 1 0
                                      0 1 0 0 0 0 0 0 0 0 0 0 0 0 1 0
                                      0 1 0 0 0 0 0 0 0 0 0 0 0 0 1 0
                                      0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0
                                      0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                                     ])
    end

    Test.@testset "FilledRectangle" begin
        height = 16
        width = 16
        image = falses(height, width)
        drawable = SD.FilledRectangle(2, 2, height - 2, width - 2, true)
        SD.draw!(image, drawable)
        Test.@test image == BitArray([
                                      0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                                      0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0
                                      0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0
                                      0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0
                                      0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0
                                      0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0
                                      0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0
                                      0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0
                                      0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0
                                      0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0
                                      0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0
                                      0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0
                                      0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0
                                      0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0
                                      0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0
                                      0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                                     ])
    end
end
