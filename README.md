# SimpleDraw

This is a lightweight self-contained package that attempts to provide efficient drawing methods for some simple shapes. So far, in this package, all the shapes and drawing algorithms are integer-based, and all the drawing algorithms are single-threaded.

## Table of contents:

* [Getting Started](#getting-started)
* [Notes](#notes)
  - [API](#api)
  - [Basic drawing](#basic-drawing)
  - [Drawing optimizations](#drawing-optimizations)
  - [Visualization](#visualization)
  - [Benchmarks](#benchmarks)
* [References and License Information](#references-and-license-information)

[List of shapes](#list-of-shapes):

1. [`Point`](#point)
1. [`Background`](#background)
1. [`Line`](#line)
1. [`ThickLine`](#thickline)
1. [`Circle`](#circle)
1. [`FilledCircle`](#filledcircle)
1. [`ThickCircle`](#thickcircle)
1. [`Rectangle`](#rectangle)
1. [`FilledRectangle`](#filledrectangle)
1. [`ThickRectangle`](#thickrectangle)
1. [`FilledTriangle`](#filledtriangle)
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

<img src="https://user-images.githubusercontent.com/32610387/147943649-0c332388-589a-49db-984b-41dac44390a8.png">

## Notes

### API

This package does not export any names. All the types in [List of shapes](#list-of-shapes), along with the following functions can be considered as a part of the API:
1. `draw!`
1. `is_valid`
1. `get_i_min`
1. `get_i_max`
1. `get_j_min`
1. `get_j_max`

Everything else should be considered internal for now.

### `draw!`

Being able to draw broadly requires three things:

1. `image`: A canvas to draw on. It could be any `AbstractMatrix`.
1. `shape`: The geometric shape to be drawn. Note that primitive `shape`s can easily be composed to create more complex `shape`s. For example,
    ```julia
    struct MyComplexShape{I <: Integer} <: SD.AbstractShape
        line::SD.Line{I}
        circle::SD.Circle{I}
    end
    ```
1. `color`: The color to draw the shape with. This is what fills up the entries of the `image` matrix at appropriate positions, thereby drawing the geometric shape.

With this in mind, this package provides the `draw!` function, which is commonly invoked as follows:

```julia
SD.draw!(image, shape, color)
```

Under the hood, it calls other `draw!` methods that automatically take care of some basic optimizations (see [Drawing optimizations](#drawing-optimizations)). Then there are `draw!` methods of the form `SD.draw!(f, image, shape, color)` that are heavily used internally. Here, `f` can roughly be thought of as a drawing function applied to every pixel of the shape. This offers a lot of flexibility with the "brush-stroke" and significantly increases code reuse. At the same time, it does not adversely affect performance. Most users will not need to use these methods directly, but in case you do, please look up the source code as their usage is not very well documented as of now.

By default, the `draw!` function is safe, that is, it draws only those pixels of the shape that lie within the bounds of the image. So you don't have to worry about your program breaking even if it tries to draw something outside the bounds of the `image`. That being said, certain basic optimizations are already enabled for drawing most shapes. See [Drawing optimizations](#drawing-optimizations).

### Drawing optimizations

`DrawingOptimizationStyle` is trait whose subtypes are used to define generic `draw!` methods with different levels of optimization for drawing shapes:
1. `PUT_PIXEL`: Iterate through all the positions needed to draw the shape. For each position, if it lies within the bounds of the image, put a pixel at that position else don't do anything.
1. `CHECK_BOUNDS`: If the shape lies completely outside the bounds of the image, simply return `nothing`. If it lies completely inside the bounds of the image, then draw each pixel of the shape without any further bounds checking. If it is neither of the previous cases, fall back to the slow but safe method of drawing each pixel of the shape only if it lies within the bounds of the image.
1. `CLIP`: Some shapes like `VerticalLine`, `HorizontalLine`, `FilledRectangle` can be direcly clipped into shapes that completely lie within the bounds of the image. In such cases, perform the clipping and draw the clipped shape without any further bounds checking.
1. `PUT_PIXEL_INBOUNDS`: Iterate through all the positions needed to draw the shape. For each position, put a pixel at that position assuming it lies within the bounds of the image.

Use `get_drawing_optimization_style(shape)` to get which style of optimization is being used to draw a shape.

### Visualization

The `visualize` function helps in visualizing a boolean image directly inside the terminal. This is a quick and effective tool to verify whether a shape is being drawn as expected. This is particularly handy when you want to know about the exact coordinates of the pixels that are being drawn for a shape.

It uses Unicode block characters to represent a pixel. This works well for low resolution images. To visualize slightly higher resolution images, you can maximize your terminal window and reduce its font size.

### Benchmarks

Below are the benchmarks for `v0.3.0` of this package using julia `v1.7.1`.

Timestamp: 2022_01_05_19_10_52 (yyyy_mm_dd_HH_MM_SS)

Shapes are drawn on an image of type `Matrix{UInt32}` with a color of type `UInt32`

|shape type|image height|image width|median time|memory|shape|
:---|:---|:---|:---|:---|:---|
|Point|64|64|3.463 ns|0 bytes|SimpleDraw.Point{Int64}(33, 33)|
|Point|256|256|3.454 ns|0 bytes|SimpleDraw.Point{Int64}(129, 129)|
|Point|1024|1024|3.464 ns|0 bytes|SimpleDraw.Point{Int64}(513, 513)|
|Background|64|64|174.279 ns|0 bytes|SimpleDraw.Background()|
|Background|256|256|5.619 μs|0 bytes|SimpleDraw.Background()|
|Background|1024|1024|158.790 μs|0 bytes|SimpleDraw.Background()|
|Line|64|64|122.932 ns|0 bytes|SimpleDraw.Line{Int64}(SimpleDraw.Point{Int64}(9, 2), SimpleDraw.Point{Int64}(56, 63))|
|Line|256|256|488.272 ns|0 bytes|SimpleDraw.Line{Int64}(SimpleDraw.Point{Int64}(33, 2), SimpleDraw.Point{Int64}(224, 255))|
|Line|1024|1024|2.403 μs|0 bytes|SimpleDraw.Line{Int64}(SimpleDraw.Point{Int64}(129, 2), SimpleDraw.Point{Int64}(896, 1023))|
|ThickLine|64|64|1.485 μs|0 bytes|SimpleDraw.ThickLine{Int64}(SimpleDraw.Point{Int64}(9, 9), SimpleDraw.Point{Int64}(56, 56), 7)|
|ThickLine|256|256|74.086 μs|0 bytes|SimpleDraw.ThickLine{Int64}(SimpleDraw.Point{Int64}(33, 33), SimpleDraw.Point{Int64}(224, 224), 31)|
|ThickLine|1024|1024|2.424 ms|0 bytes|SimpleDraw.ThickLine{Int64}(SimpleDraw.Point{Int64}(129, 129), SimpleDraw.Point{Int64}(896, 896), 127)|
|Circle|64|64|149.877 ns|0 bytes|SimpleDraw.Circle{Int64}(SimpleDraw.Point{Int64}(2, 2), 62)|
|Circle|256|256|1.348 μs|0 bytes|SimpleDraw.Circle{Int64}(SimpleDraw.Point{Int64}(2, 2), 254)|
|Circle|1024|1024|8.180 μs|0 bytes|SimpleDraw.Circle{Int64}(SimpleDraw.Point{Int64}(2, 2), 1022)|
|FilledCircle|64|64|1.469 μs|0 bytes|SimpleDraw.FilledCircle{Int64}(SimpleDraw.Point{Int64}(2, 2), 62)|
|FilledCircle|256|256|11.294 μs|0 bytes|SimpleDraw.FilledCircle{Int64}(SimpleDraw.Point{Int64}(2, 2), 254)|
|FilledCircle|1024|1024|146.581 μs|0 bytes|SimpleDraw.FilledCircle{Int64}(SimpleDraw.Point{Int64}(2, 2), 1022)|
|ThickCircle|64|64|2.227 μs|0 bytes|SimpleDraw.ThickCircle{Int64}(SimpleDraw.Point{Int64}(2, 2), 62, 16)|
|ThickCircle|256|256|71.456 μs|0 bytes|SimpleDraw.ThickCircle{Int64}(SimpleDraw.Point{Int64}(2, 2), 254, 64)|
|ThickCircle|1024|1024|1.175 ms|0 bytes|SimpleDraw.ThickCircle{Int64}(SimpleDraw.Point{Int64}(2, 2), 1022, 256)|
|Rectangle|64|64|136.071 ns|0 bytes|SimpleDraw.Rectangle{Int64}(SimpleDraw.Point{Int64}(2, 2), 63, 63)|
|Rectangle|256|256|1.668 μs|0 bytes|SimpleDraw.Rectangle{Int64}(SimpleDraw.Point{Int64}(2, 2), 255, 255)|
|Rectangle|1024|1024|8.552 μs|0 bytes|SimpleDraw.Rectangle{Int64}(SimpleDraw.Point{Int64}(2, 2), 1023, 1023)|
|FilledRectangle|64|64|783.196 ns|0 bytes|SimpleDraw.FilledRectangle{Int64}(SimpleDraw.Point{Int64}(2, 2), 63, 63)|
|FilledRectangle|256|256|9.221 μs|0 bytes|SimpleDraw.FilledRectangle{Int64}(SimpleDraw.Point{Int64}(2, 2), 255, 255)|
|FilledRectangle|1024|1024|172.170 μs|0 bytes|SimpleDraw.FilledRectangle{Int64}(SimpleDraw.Point{Int64}(2, 2), 1023, 1023)|
|ThickRectangle|64|64|1.263 μs|0 bytes|SimpleDraw.ThickRectangle{Int64}(SimpleDraw.Point{Int64}(2, 2), 63, 63, 16)|
|ThickRectangle|256|256|7.531 μs|0 bytes|SimpleDraw.ThickRectangle{Int64}(SimpleDraw.Point{Int64}(2, 2), 255, 255, 64)|
|ThickRectangle|1024|1024|187.453 μs|0 bytes|SimpleDraw.ThickRectangle{Int64}(SimpleDraw.Point{Int64}(2, 2), 1023, 1023, 256)|
|Character|64|64|1.518 μs|0 bytes|SimpleDraw.Character{Int64, Char, SimpleDraw.Terminus_32_16}(SimpleDraw.Point{Int64}(2, 2), 'A', SimpleDraw.Terminus_32_16([0 0 … 0 0; 0 0 … 0 0; … ; 0 0 … 0 0; 0 0 … 0 0;;; 0 0 … 0 0; 0 0 … 0 0; … ; 0 0 … 0 0; 0 0 … 0 0;;; 0 0 … 0 0; 0 0 … 0 0; … ; 0 0 … 0 0; 0 0 … 0 0;;; … ;;; 0 0 … 0 0; 0 0 … 0 0; … ; 0 0 … 0 0; 0 0 … 0 0;;; 0 0 … 0 0; 0 0 … 0 0; … ; 0 0 … 0 0; 0 0 … 0 0;;; 0 0 … 0 0; 0 0 … 0 0; … ; 0 0 … 0 0; 0 0 … 0 0]))|
|Character|256|256|1.473 μs|0 bytes|SimpleDraw.Character{Int64, Char, SimpleDraw.Terminus_32_16}(SimpleDraw.Point{Int64}(2, 2), 'A', SimpleDraw.Terminus_32_16([0 0 … 0 0; 0 0 … 0 0; … ; 0 0 … 0 0; 0 0 … 0 0;;; 0 0 … 0 0; 0 0 … 0 0; … ; 0 0 … 0 0; 0 0 … 0 0;;; 0 0 … 0 0; 0 0 … 0 0; … ; 0 0 … 0 0; 0 0 … 0 0;;; … ;;; 0 0 … 0 0; 0 0 … 0 0; … ; 0 0 … 0 0; 0 0 … 0 0;;; 0 0 … 0 0; 0 0 … 0 0; … ; 0 0 … 0 0; 0 0 … 0 0;;; 0 0 … 0 0; 0 0 … 0 0; … ; 0 0 … 0 0; 0 0 … 0 0]))|
|Character|1024|1024|1.478 μs|0 bytes|SimpleDraw.Character{Int64, Char, SimpleDraw.Terminus_32_16}(SimpleDraw.Point{Int64}(2, 2), 'A', SimpleDraw.Terminus_32_16([0 0 … 0 0; 0 0 … 0 0; … ; 0 0 … 0 0; 0 0 … 0 0;;; 0 0 … 0 0; 0 0 … 0 0; … ; 0 0 … 0 0; 0 0 … 0 0;;; 0 0 … 0 0; 0 0 … 0 0; … ; 0 0 … 0 0; 0 0 … 0 0;;; … ;;; 0 0 … 0 0; 0 0 … 0 0; … ; 0 0 … 0 0; 0 0 … 0 0;;; 0 0 … 0 0; 0 0 … 0 0; … ; 0 0 … 0 0; 0 0 … 0 0;;; 0 0 … 0 0; 0 0 … 0 0; … ; 0 0 … 0 0; 0 0 … 0 0]))|
|TextLine|64|64|5.556 μs|0 bytes|SimpleDraw.TextLine{Int64, String, SimpleDraw.Terminus_32_16}(SimpleDraw.Point{Int64}(1, 1), "OMVJ", SimpleDraw.Terminus_32_16([0 0 … 0 0; 0 0 … 0 0; … ; 0 0 … 0 0; 0 0 … 0 0;;; 0 0 … 0 0; 0 0 … 0 0; … ; 0 0 … 0 0; 0 0 … 0 0;;; 0 0 … 0 0; 0 0 … 0 0; … ; 0 0 … 0 0; 0 0 … 0 0;;; … ;;; 0 0 … 0 0; 0 0 … 0 0; … ; 0 0 … 0 0; 0 0 … 0 0;;; 0 0 … 0 0; 0 0 … 0 0; … ; 0 0 … 0 0; 0 0 … 0 0;;; 0 0 … 0 0; 0 0 … 0 0; … ; 0 0 … 0 0; 0 0 … 0 0]))|
|TextLine|256|256|22.815 μs|0 bytes|SimpleDraw.TextLine{Int64, String, SimpleDraw.Terminus_32_16}(SimpleDraw.Point{Int64}(1, 1), "XVFYWDHWRMXBZDTT", SimpleDraw.Terminus_32_16([0 0 … 0 0; 0 0 … 0 0; … ; 0 0 … 0 0; 0 0 … 0 0;;; 0 0 … 0 0; 0 0 … 0 0; … ; 0 0 … 0 0; 0 0 … 0 0;;; 0 0 … 0 0; 0 0 … 0 0; … ; 0 0 … 0 0; 0 0 … 0 0;;; … ;;; 0 0 … 0 0; 0 0 … 0 0; … ; 0 0 … 0 0; 0 0 … 0 0;;; 0 0 … 0 0; 0 0 … 0 0; … ; 0 0 … 0 0; 0 0 … 0 0;;; 0 0 … 0 0; 0 0 … 0 0; … ; 0 0 … 0 0; 0 0 … 0 0]))|
|TextLine|1024|1024|93.881 μs|0 bytes|SimpleDraw.TextLine{Int64, String, SimpleDraw.Terminus_32_16}(SimpleDraw.Point{Int64}(1, 1), "ABIFZIJMRNFMIPNOMGPICUKEESMIRENGUKLTQIGJAGJAMLUGPKIMPYMQSNHOGXRQ", SimpleDraw.Terminus_32_16([0 0 … 0 0; 0 0 … 0 0; … ; 0 0 … 0 0; 0 0 … 0 0;;; 0 0 … 0 0; 0 0 … 0 0; … ; 0 0 … 0 0; 0 0 … 0 0;;; 0 0 … 0 0; 0 0 … 0 0; … ; 0 0 … 0 0; 0 0 … 0 0;;; … ;;; 0 0 … 0 0; 0 0 … 0 0; … ; 0 0 … 0 0; 0 0 … 0 0;;; 0 0 … 0 0; 0 0 … 0 0; … ; 0 0 … 0 0; 0 0 … 0 0;;; 0 0 … 0 0; 0 0 … 0 0; … ; 0 0 … 0 0; 0 0 … 0 0]))|

Follow these steps to reproduce similar benchmarks:

1. Clone the project

    ```
    $ git clone https://github.com/Sid-Bhatia-0/SimpleDraw.jl.git
    ```

1. Start the julia REPL inside the `/benchmark` directory

    ```
    benchmark $ julia
    ```

1. Activate and instantiate the project

    ```
    julia> import Pkg; Pkg.activate("."); Pkg.instantiate()
    ```

1. Exit the REP and run `generate_benchmarks.jl` with the `Project.toml` and `Manifest.toml` files in this directory

    ```
    benchmark $ julia --project=. generate_benchmarks.jl
    ```

This will print a bunch of outputs and produce a markdown file named with a timestamp containing the final benchmarks. Using a timestamp in the name helps ensure that running `generate_benchmarks.jl` multiple times does not overwrite the same file.

## List of shapes

1. ### `Point`

    ```julia
    struct Point{I <: Integer} <: AbstractShape
        i::I
        j::I
    end
    ```

    <img src="https://user-images.githubusercontent.com/32610387/147943555-5e6c4560-a02b-48b8-9638-c7c568936147.png">

1. ### `Background`

    ```julia
    struct Background <: AbstractShape end
    ```

    <img src="https://user-images.githubusercontent.com/32610387/147943624-244cbe86-1aac-4ad1-9285-4f35d38009c6.png">

1. ### `Line`

    ```julia
    struct Line{I <: Integer} <: AbstractLine
        point1::Point{I}
        point2::Point{I}
    end
    ```

    The line is not symmetric in general. Reversing the order of points may produce different outcomes.

    <img src="https://user-images.githubusercontent.com/32610387/147943649-0c332388-589a-49db-984b-41dac44390a8.png">

1. ### `ThickLine`

    ```julia
    struct ThickLine{I <: Integer} <: AbstractLine
        point1::Point{I}
        point2::Point{I}
        thickness::I
    end
    ```

    An instance of `ThickLine` is considered valid only if the following conditions hold true:
    * `thickness > 0`

    <img src="https://user-images.githubusercontent.com/32610387/148082257-79ded105-a737-4286-8d58-a5c821a41f14.png">

1. ### `Circle`

    ```julia
    struct Circle{I <: Integer} <: AbstractCircle
        position::Point{I}
        diameter::I
    end
    ```

    An instance of `Circle` is considered valid only if the following conditions hold true:
    * `diameter > 0`

    <img src="https://user-images.githubusercontent.com/32610387/147943714-72fa3f0a-daca-47ee-ae54-a92bfaf0d962.png">

1. ### `FilledCircle`

    ```julia
    struct FilledCircle{I <: Integer} <: AbstractCircle
        position::Point{I}
        diameter::I
    end
    ```

    An instance of `FilledCircle` is considered valid only if the following conditions hold true:
    * `diameter > 0`

    <img src="https://user-images.githubusercontent.com/32610387/147943755-2a4ebfb0-cb7d-4a19-83cb-925dbf259022.png">

1. ### `ThickCircle`

    ```julia
    struct ThickCircle{I <: Integer} <: AbstractCircle
        position::Point{I}
        diameter::I
        thickness::I
    end
    ```

    An instance of `ThickCircle` is considered valid only if the following conditions hold true:
    * `diameter > 0`
    * `thickness > 0`
    * if `diameter` is odd, then `2 * thickness <= diameter + 1`
    * if `diameter` is even, then `2 * thickness <= diameter`

    <img src="https://user-images.githubusercontent.com/32610387/147943783-883609bb-2f16-422b-a5c8-150878135c97.png">

1. ### `Rectangle`

    ```julia
    struct Rectangle{I <: Integer} <: AbstractRectangle
        position::Point{I}
        height::I
        width::I
    end
    ```

    An instance of `Rectangle` is considered valid only if the following conditions hold true:
    * `height > 0`
    * `width > 0`

    <img src="https://user-images.githubusercontent.com/32610387/147943835-44c41d80-8272-48e8-8122-adc56dc949ad.png">

1. ### `FilledRectangle`

    ```julia
    struct FilledRectangle{I <: Integer} <: AbstractRectangle
        position::Point{I}
        height::I
        width::I
    end
    ```

    An instance of `FilledRectangle` is considered valid only if the following conditions hold true:
    * `height > 0`
    * `width > 0`

    <img src="https://user-images.githubusercontent.com/32610387/147943862-5515ca23-234c-4f2e-b3f0-3a8b54e07c37.png">

1. ### `ThickRectangle`

    ```julia
    struct ThickRectangle{I <: Integer} <: AbstractRectangle
        position::Point{I}
        height::I
        width::I
        thickness::I
    end
    ```

    An instance of `ThickRectangle` is considered valid only if the following conditions hold true:
    * `height > 0`
    * `width > 0`
    * `thickness > 0`
    * `thickness <= min(height, width)`

    <img src="https://user-images.githubusercontent.com/32610387/147943890-badcce13-f1fd-4295-9ea3-37561b9821aa.png">

1. ### `FilledTriangle`

    ```julia
    struct FilledTriangle{I <: Integer} <: AbstractTriangle
        point1::Point{I}
        point2::Point{I}
        point3::Point{I}
    end
    ```

    <img src="https://user-images.githubusercontent.com/32610387/162975187-2eb6e57f-b693-4c9b-99f3-961c7b3aff18.png">

1. ### `Character`

    ```julia
    struct Character{I <: Integer, C <: AbstractChar, F <: AbstractFont} <: AbstractShape
        position::Point{I}
        char::C
        font::F
    end
    ```

    There are two monospace fonts available at this point - `TERMINUS_32_16` (height 32 pixels, width 16 pixels) and `TERMINUS_16_8` (height 16 pixels, width 8 pixels). Only glyphs for ASCII characters are available as of now.

    <img src="https://user-images.githubusercontent.com/32610387/147944083-56f45efc-1c7f-4f19-ae53-e17d5f8e51b6.png">

1. ### `TextLine`

    ```julia
    struct TextLine{I <: Integer, S, F <: AbstractFont} <: AbstractShape
        position::Point{I}
        text::S
        font::F
    end
    ```

    There are two monospace fonts available at this point - `TERMINUS_32_16` (height 32 pixels, width 16 pixels) and `TERMINUS_16_8` (height 16 pixels, width 8 pixels). Only glyphs for ASCII characters are available as of now.

    <img src="https://user-images.githubusercontent.com/32610387/147944102-2480436c-d9b8-47bb-9134-5537b4014791.png">

## References and License Information

1. Octant drawing: [https://en.wikipedia.org/w/index.php?title=Midpoint_circle_algorithm&oldid=1073593456](https://en.wikipedia.org/w/index.php?title=Midpoint_circle_algorithm&oldid=1073593456)
1. Line drawing: [https://en.wikipedia.org/w/index.php?title=Bresenham%27s_line_algorithm&oldid=1073834153](https://en.wikipedia.org/w/index.php?title=Bresenham%27s_line_algorithm&oldid=1073834153)
1. Fonts: This package supports bitmap fonts for [ASCII](https://en.wikipedia.org/wiki/ASCII) characters at this point. We use a subset of [Terminus Font](http://terminus-font.sourceforge.net/) for drawing the glyphs. Terminus Font is licensed under the SIL Open Font License, Version 1.1. The license is included as OFL.TXT in the `/src/fonts` directory in this repository, and is also available with a FAQ at [http://scripts.sil.org/OFL](http://scripts.sil.org/OFL).
1. Everything else is under [LICENSE](https://github.com/Sid-Bhatia-0/SimpleDraw.jl/blob/master/LICENSE).
