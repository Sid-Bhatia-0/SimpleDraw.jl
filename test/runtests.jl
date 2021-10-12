import SimpleDraw as SD
import Test

Test.@testset "SimpleDraw.jl" begin

    Test.@testset "Point" begin
        height = 16
        width = 16
        image = falses(height, width)
        shape = SD.Point(4, 8)
        color = true
        SD.draw!(image, shape, color)
        Test.@test image == BitArray([
                                      0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                                      0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                                      0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                                      0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0
                                      0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                                      0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                                      0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                                      0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                                      0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                                      0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                                      0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                                      0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                                      0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                                      0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                                      0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                                      0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                                     ])
    end

    Test.@testset "Background" begin
        height = 16
        width = 16
        image = falses(height, width)
        shape = SD.Background()
        color = true
        SD.draw!(image, shape, color)
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
        shape = SD.Line(2, 2, height - 1, width - 1)
        color = true
        SD.draw!(image, shape, color)
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
        shape = SD.Circle(8, 8, 6)
        color = true
        SD.draw!(image, shape, color)
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
        shape = SD.FilledCircle(8, 8, 6)
        color = true
        SD.draw!(image, shape, color)
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
        shape = SD.Rectangle(2, 2, height - 2, width - 2)
        color = true
        SD.draw!(image, shape, color)
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
        shape = SD.FilledRectangle(2, 2, height - 2, width - 2)
        color = true
        SD.draw!(image, shape, color)
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

    Test.@testset "Cross" begin
        height = 16
        width = 16
        image = falses(height, width)
        shape = SD.Cross(8, 8, 4)
        color = true
        SD.draw!(image, shape, color)
        Test.@test image == BitArray([
                                      0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                                      0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                                      0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                                      0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0
                                      0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0
                                      0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0
                                      0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0
                                      0 0 0 1 1 1 1 1 1 1 1 1 0 0 0 0
                                      0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0
                                      0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0
                                      0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0
                                      0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0
                                      0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                                      0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                                      0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                                      0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                                     ])
    end

    Test.@testset "HollowCross" begin
        height = 16
        width = 16
        image = falses(height, width)
        shape = SD.HollowCross(8, 8, 4)
        color = true
        SD.draw!(image, shape, color)
        Test.@test image == BitArray([
                                      0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                                      0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                                      0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                                      0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0
                                      0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0
                                      0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0
                                      0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0
                                      0 0 0 1 1 1 1 0 1 1 1 1 0 0 0 0
                                      0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0
                                      0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0
                                      0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0
                                      0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0
                                      0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                                      0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                                      0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                                      0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                                     ])
    end
end
