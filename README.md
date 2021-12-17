# SimpleDraw

This is a lightweight package that provides exact and efficient (for the most part) drawing methods for some simple shapes.

## Table of contents:

* [Getting Started](#getting-started)
* [Notes](#notes)
  - [API](#api)
  - [Draw with bounds checking](#draw-with-bounds-checking)
  - [Visualization](#visualization)
  - [Benchmarks](#benchmarks)
  - [Fonts](#fonts)

[List of shapes](#list-of-shapes):

1. [`Point`](#point)
1. [`Background`](#background)
1. [`VerticalLine`](#verticalline)
1. [`HorizontalLine`](#horizontalline)
1. [`Line`](#line)
1. [`ThickLine`](#thickline)
1. [`Circle`](#circle)
1. [`FilledCircle`](#filledcircle)
1. [`ThickCircle`](#thickcircle)
1. [`Rectangle`](#rectangle)
1. [`ThickRectangle`](#thickrectangle)
1. [`FilledRectangle`](#filledrectangle)
1. [`Bitmap`](#bitmap)
1. [`Character`](#character)
1. [`TextLine`](#textline)

## Getting Started

```julia
import SimpleDraw as SD

# create a canvas (could be any AbstractMatrix)
image = falses(32, 32) # (height, width)

# create the shape
shape = SD.Line(SD.Point(9, 5), SD.Point(24, 28))

# we will draw on the boolean image with the "color" true
color = true

# draw the shape on image
SD.draw!(image, shape, color)

# print the boolean image using Unicode block characters
SD.visualize(image)
```

<img src="https://user-images.githubusercontent.com/32610387/139564759-50d524b8-bd70-4a19-a143-1a75644ad929.png">

## Notes

### API

Being able to draw broadly requires three things:

1. `image`: A canvas to draw on. It could be any `AbstractMatrix`.
1. `shape`: The shape to be drawn. Also, `shape`s can be composed to create more complex `shape`s.
    ```julia
    struct MyComplexShape{I <: Integer} <: SD.AbstractShape
        line::SD.Line{I}
        circle::SD.Circle{I}
    end
    ```
    For now, all drawables and algorithms are integer-based.
1. `color`: The color to be draw the shape with.

With this in mind, this package provides the `draw!` function, which can be invoked as follows:

```julia
SD.draw!(image, shape, color)
```

### Draw with bounds-checking

By default, the `draw!` function draws the clipped shape, that is, it draws only those pixes that fall within the bounds of the image. So you don't have to worry about your program breaking because it is trying to draw something outside the bounds of the `image`. This is achieved in different ways for different shapes. For example:

1. In case of `Background`, we simply fill the entire array and don't need any explicit bounds checking.
1. In case of `VerticalLine` or `HorizontalLine`, we first clip the endpoints of the line to lie within the image and then draw the line with no further bounds checking.
1. In case of more complex shapes like `Circle`, we iterate through all the pixels of the `Circle` like we normally would, but draw only those pixels that lie within the bounds of the `image`.

### Visualization

The `visualize` function helps visualize a binary image inside the terminal using Unicode block characters to represent pixels. This is a quick tool to verify that your drawing algorithms are functioning as intended. This works well for low resolution images. You can maximize your terminal window and reduce the font size to visualize higher resolutions images.

### Benchmarks

In order to generate the benchmarks, clone this repository and start the julia REPL inside the `/benchmark` directory using the `Project.toml` and `Manifest.toml` files given there:

```
benchmark $ julia --project=.
```

And then execute the following:

```julia-repl
julia> include("benchmark.jl");

julia> generate_benchmark_file();

julia> generate_benchmark_file();
```

The `generate_benchmark_file()` function produces a markdown file whose name is a timestamp so that multiple calls to the function don't overwrite the same file. I usually run the `generate_benchmark_file()` function twice and take the result of the second one just to make sure that everything is already compiled before the second one is run.

For details on what exact shapes are drawn while generating these benchmarks, see `/benchmark/benchmarks.jl`.

Here are the benchmarks for `v0.2.0`:

Date: 2021_11_04_17_10_38 (yyyy_mm_dd_HH_MM_SS)

**Note:** The time in benchmarks is the median time.

| |64|256|1024|
|:---:|:---:|:---:|:---:|
|Point|4.022 ns<br>0 bytes|4.151 ns<br>0 bytes|4.149 ns<br>0 bytes|
|Background|173.898 ns<br>0 bytes|6.716 μs<br>0 bytes|233.739 μs<br>0 bytes|
|Line|185.178 ns<br>0 bytes|841.583 ns<br>0 bytes|3.419 μs<br>0 bytes|
|VerticalLine|22.484 ns<br>0 bytes|37.138 ns<br>0 bytes|94.983 ns<br>0 bytes|
|HorizontalLine|43.455 ns<br>0 bytes|909.604 ns<br>0 bytes|4.702 μs<br>0 bytes|
|ThickLine|9.998 μs<br>0 bytes|223.935 μs<br>0 bytes|8.741 ms<br>0 bytes|
|Circle|170.603 ns<br>0 bytes|1.205 μs<br>0 bytes|9.209 μs<br>0 bytes|
|ThickCircle|1.621 μs<br>0 bytes|66.197 μs<br>0 bytes|1.376 ms<br>0 bytes|
|FilledCircle|1.101 μs<br>0 bytes|9.043 μs<br>0 bytes|199.065 μs<br>0 bytes|
|Rectangle|91.700 ns<br>0 bytes|1.748 μs<br>0 bytes|11.386 μs<br>0 bytes|
|ThickRectangle|3.374 μs<br>0 bytes|54.228 μs<br>0 bytes|891.390 μs<br>0 bytes|
|FilledRectangle|4.393 μs<br>0 bytes|72.216 μs<br>0 bytes|1.179 ms<br>0 bytes|
|Cross|52.212 ns<br>0 bytes|945.432 ns<br>0 bytes|5.289 μs<br>0 bytes|
|HollowCross|71.390 ns<br>0 bytes|926.110 ns<br>0 bytes|4.900 μs<br>0 bytes|

### Fonts

This package supports bitmap fonts for [ASCII](https://en.wikipedia.org/wiki/ASCII) characters at this point. We use a subset of [Terminus Font](http://terminus-font.sourceforge.net/) for drawing the glyphs. Terminus Font is licensed under the SIL Open Font License, Version 1.1. The license is included as OFL.TXT in the `/src/fonts` directory in this repository, and is also available with a FAQ at [http://scripts.sil.org/OFL](http://scripts.sil.org/OFL).

## List of drawables

1. ### `Point`

    ```julia
    struct Point{I <: Integer} <: AbstractShape
        i::I
        j::I
    end
    ```

    <img src="https://user-images.githubusercontent.com/32610387/139564735-8f9d7b27-e254-430c-90d9-81b7eef65cdd.png">

1. ### `Background`

    ```julia
    struct Background <: AbstractShape end
    ```

    <img src="https://user-images.githubusercontent.com/32610387/139564738-1269502a-9fa2-448d-88af-e2a02ec9baf8.png">

1. ### `VerticalLine`

    ```julia
    struct VerticalLine{I <: Integer} <: AbstractShape
        i_min::I
        i_max::I
        j::I
    end
    ```

    <img src="https://user-images.githubusercontent.com/32610387/139564744-cf7ecb09-cb1c-4820-a74b-e81536d489c6.png">

1. ### `HorizontalLine`

    ```julia
    struct HorizontalLine{I <: Integer} <: AbstractShape
        i::I
        j_min::I
        j_max::I
    end
    ```

    <img src="https://user-images.githubusercontent.com/32610387/139564748-8b8092ae-bb2f-4ae7-a76d-82f13aaaeb7a.png">

1. ### `Line`

    ```julia
    struct Line{I <: Integer} <: AbstractShape
        point1::Point{I}
        point2::Point{I}
    end
    ```

    <img src="https://user-images.githubusercontent.com/32610387/139564759-50d524b8-bd70-4a19-a143-1a75644ad929.png">

1. ### `ThickLine`

    ```julia
    struct ThickLine{I <: Integer} <: AbstractShape
        point1::Point{I}
        point2::Point{I}
        diameter::I
    end
    ```

    <img src="https://user-images.githubusercontent.com/32610387/144703038-3c3904da-044d-4bae-a9ac-b6a0ae7f5545.png">

1. ### `Circle`

    ```julia
    struct Circle{I <: Integer} <: AbstractCircle
        position::Point{I}
        diameter::I
    end
    ```

    <img src="https://user-images.githubusercontent.com/32610387/144611658-fa47d384-85c7-4024-9421-cd1cff2c175a.png">

1. ### `ThickCircle`

    ```julia
    struct ThickCircle{I <: Integer} <: AbstractCircle
        position::Point{I}
        diameter::I
        thickness::I
    end
    ```

    <img src="https://user-images.githubusercontent.com/32610387/144611729-74a4cf1f-82de-4e3d-ae6d-874180330129.png">

1. ### `FilledCircle`

    ```julia
    struct FilledCircle{I <: Integer} <: AbstractCircle
        position::Point{I}
        diameter::I
    end
    ```

    <img src="https://user-images.githubusercontent.com/32610387/144611779-6d814e74-b797-41e0-84f7-83fcb5a650a9.png">

1. ### `Rectangle`

    ```julia
    struct Rectangle{I <: Integer} <: AbstractRectangle
        position::Point{I}
        height::I
        width::I
    end
    ```

    <img src="https://user-images.githubusercontent.com/32610387/139564833-cc6e8445-01da-4f6e-83a2-512e69d402dc.png">

1. ### `FilledRectangle`

    ```julia
    struct FilledRectangle{I <: Integer} <: AbstractRectangle
        position::Point{I}
        height::I
        width::I
    end
    ```

    <img src="https://user-images.githubusercontent.com/32610387/139564859-bd027f70-857d-47eb-a42d-30e402aaf6d6.png">

1. ### `ThickRectangle`

    ```julia
    struct ThickRectangle{I <: Integer} <: AbstractRectangle
        position::Point{I}
        height::I
        width::I
        thickness::I
    end
    ```

    <img src="https://user-images.githubusercontent.com/32610387/139564844-fb07ea5d-1ed5-422c-a2a5-067f1fb5c216.png">

1. ### `Bitmap`

    ```julia
    struct Bitmap{I, B <: AbstractMatrix{Bool}} <: AbstractShape
        position::Point{I}
        bitmap::B
    end
    ```

    <img src="https://user-images.githubusercontent.com/32610387/145029622-b0a236f4-09f4-4b70-bc72-bf3f12d16b95.png">

1. ### `Character`

    ```julia
    struct Character{I, C <: AbstractChar, F <: AbstractFont} <: AbstractShape
        position::Point{I}
        char::C
        font::F
    end
    ```

    <img src="https://user-images.githubusercontent.com/32610387/140615301-2a263b84-44ce-40ec-a081-8f465346f404.png">

1. ### `TextLine`

    ```julia
    struct TextLine{I, S, F <: AbstractFont} <: AbstractShape
        position::Point{I}
        text::S
        font::F
    end
    ```

    <img src="https://user-images.githubusercontent.com/32610387/141676460-3b38faed-f7b9-4b6e-8699-5f71b064e620.png">
