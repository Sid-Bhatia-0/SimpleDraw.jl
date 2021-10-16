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
        shape = SD.Line(SD.Point(2, 2), SD.Point(height - 1, width - 1))
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

        image = falses(height, width)
        shape = SD.Line(SD.Point(-1, -1), SD.Point(height + 2, width + 2))
        color = true
        SD.draw!(image, shape, color)
        Test.@test image == BitArray([
                                      1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
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
                                      0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1
                                     ])
    end

    Test.@testset "Circle" begin
        height = 16
        width = 16
        image = falses(height, width)
        shape = SD.Circle(SD.Point(8, 8), 6)
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
        shape = SD.FilledCircle(SD.Point(8, 8), 6)
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
        shape = SD.Rectangle(SD.Point(2, 2), height - 2, width - 2)
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
        shape = SD.FilledRectangle(SD.Point(2, 2), height - 2, width - 2)
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
        shape = SD.Cross(SD.Point(8, 8), 4)
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
        shape = SD.HollowCross(SD.Point(8, 8), 4)
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

    Test.@testset "PolyLine" begin
        height = 16
        width = 16
        image = falses(height, width)
        shape = SD.PolyLine([SD.Point(15, 2), SD.Point(12, 15), SD.Point(3, 12), SD.Point(6, 6)])
        color = true
        SD.draw!(image, shape, color)
        Test.@test image == BitArray([
                                      0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                                      0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                                      0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0
                                      0 0 0 0 0 0 0 0 0 1 1 1 0 0 0 0
                                      0 0 0 0 0 0 0 1 1 0 0 0 1 0 0 0
                                      0 0 0 0 0 1 1 0 0 0 0 0 1 0 0 0
                                      0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0
                                      0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0
                                      0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0
                                      0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0
                                      0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0
                                      0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 0
                                      0 0 0 0 0 0 0 0 1 1 1 1 0 0 0 0
                                      0 0 0 0 1 1 1 1 0 0 0 0 0 0 0 0
                                      0 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0
                                      0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                                     ])
    end
end
