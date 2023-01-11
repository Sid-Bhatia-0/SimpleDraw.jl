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

1. [`Background`](#background)
1. [`Point`](#point)
1. [`Line`](#line)
1. [`ThickLine`](#thickline)
1. [`Triangle`](#triangle)
1. [`FilledTriangle`](#filledtriangle)
1. [`Rectangle`](#rectangle)
1. [`FilledRectangle`](#filledrectangle)
1. [`ThickRectangle`](#thickrectangle)
1. [`Circle`](#circle)
1. [`FilledCircle`](#filledcircle)
1. [`ThickCircle`](#thickcircle)
1. [`Bitmap`](#bitmap)
1. [`Image`](#image)
1. [`Character`](#character)
1. [`TextLine`](#textline)

## Getting Started

```julia
import SimpleDraw as SD

# create a canvas (could be any AbstractMatrix)
image = falses(32, 32) # (height, width)

# create the shape
shape = SD.Line(SD.Point(9, 5), SD.Point(14, 19))

# we will draw on the boolean image with the "color" true
color = true

# draw the shape on image
SD.draw!(image, shape, color)

# print the boolean image using Unicode block characters
SD.visualize(image)
```

<img src="https://user-images.githubusercontent.com/32610387/211235212-3ac45d97-8dde-45cf-9865-dbf322dda741.png">

## Notes

### API

The following types are part of the API.
1. All types in [List of shapes](#list-of-shapes)
1. The abstract type `AbstractShape`
1. The font constants `TERMINUS_16_8`, `TERMINUS_BOLD_16_8`, `TERMINUS_24_12`, `TERMINUS_BOLD_24_12`, `TERMINUS_32_16`, `TERMINUS_BOLD_32_16`.

The following functions are part of the API:
1. `draw!`
1. `is_valid`
1. `get_i_min`
1. `get_i_max`
1. `get_j_min`
1. `get_j_max`
1. `get_i_extrema`
1. `get_j_extrema`
1. `get_height`
1. `get_width`
1. `get_position`
1. `move_i`
1. `move_j`
1. `move`
1. `visualize`

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

Below are the benchmarks for `v0.4.0` of this package on a single CPU core using the following `versioninfo()`:

```
julia> versioninfo()
Julia Version 1.7.2
Commit bf53498635 (2022-02-06 15:21 UTC)
Platform Info:
  OS: Linux (x86_64-pc-linux-gnu)
  CPU: Intel(R) Core(TM) i7-6500U CPU @ 2.50GHz
  WORD_SIZE: 64
  LIBM: libopenlibm
  LLVM: libLLVM-12.0.1 (ORCJIT, skylake)
```

Timestamp: 2022_04_26_19_54_49 (yyyy_mm_dd_HH_MM_SS)

Shapes are drawn on an image of type `Matrix{UInt32}` with a color of type `UInt32`

|shape type|image height|image width|median time|memory|shape|
:---|:---|:---|:---|:---|:---|
|Point|64|64|4.876 ns|0 bytes|SimpleDraw.Point{Int64}(33, 33)|
|Point|256|256|5.323 ns|0 bytes|SimpleDraw.Point{Int64}(129, 129)|
|Point|1024|1024|4.893 ns|0 bytes|SimpleDraw.Point{Int64}(513, 513)|
|Background|64|64|208.221 ns|0 bytes|SimpleDraw.Background()|
|Background|256|256|6.966 μs|0 bytes|SimpleDraw.Background()|
|Background|1024|1024|186.605 μs|0 bytes|SimpleDraw.Background()|
|Line|64|64|146.553 ns|0 bytes|SimpleDraw.Line{Int64}(SimpleDraw.Point{Int64}(9, 2), SimpleDraw.Point{Int64}(56, 63))|
|Line|256|256|585.260 ns|0 bytes|SimpleDraw.Line{Int64}(SimpleDraw.Point{Int64}(33, 2), SimpleDraw.Point{Int64}(224, 255))|
|Line|1024|1024|2.937 μs|0 bytes|SimpleDraw.Line{Int64}(SimpleDraw.Point{Int64}(129, 2), SimpleDraw.Point{Int64}(896, 1023))|
|ThickLine|64|64|2.233 μs|0 bytes|SimpleDraw.ThickLine{Int64}(SimpleDraw.Point{Int64}(9, 9), SimpleDraw.Point{Int64}(56, 56), 7)|
|ThickLine|256|256|96.407 μs|0 bytes|SimpleDraw.ThickLine{Int64}(SimpleDraw.Point{Int64}(33, 33), SimpleDraw.Point{Int64}(224, 224), 31)|
|ThickLine|1024|1024|2.837 ms|0 bytes|SimpleDraw.ThickLine{Int64}(SimpleDraw.Point{Int64}(129, 129), SimpleDraw.Point{Int64}(896, 896), 127)|
|Circle|64|64|175.703 ns|0 bytes|SimpleDraw.Circle{Int64}(SimpleDraw.Point{Int64}(2, 2), 62)|
|Circle|256|256|1.381 μs|0 bytes|SimpleDraw.Circle{Int64}(SimpleDraw.Point{Int64}(2, 2), 254)|
|Circle|1024|1024|10.729 μs|0 bytes|SimpleDraw.Circle{Int64}(SimpleDraw.Point{Int64}(2, 2), 1022)|
|FilledCircle|64|64|1.843 μs|0 bytes|SimpleDraw.FilledCircle{Int64}(SimpleDraw.Point{Int64}(2, 2), 62)|
|FilledCircle|256|256|13.175 μs|0 bytes|SimpleDraw.FilledCircle{Int64}(SimpleDraw.Point{Int64}(2, 2), 254)|
|FilledCircle|1024|1024|178.987 μs|0 bytes|SimpleDraw.FilledCircle{Int64}(SimpleDraw.Point{Int64}(2, 2), 1022)|
|ThickCircle|64|64|2.652 μs|0 bytes|SimpleDraw.ThickCircle{Int64}(SimpleDraw.Point{Int64}(2, 2), 62, 16)|
|ThickCircle|256|256|74.406 μs|0 bytes|SimpleDraw.ThickCircle{Int64}(SimpleDraw.Point{Int64}(2, 2), 254, 64)|
|ThickCircle|1024|1024|1.407 ms|0 bytes|SimpleDraw.ThickCircle{Int64}(SimpleDraw.Point{Int64}(2, 2), 1022, 256)|
|Rectangle|64|64|121.121 ns|0 bytes|SimpleDraw.Rectangle{Int64}(SimpleDraw.Point{Int64}(2, 2), 63, 63)|
|Rectangle|256|256|1.950 μs|0 bytes|SimpleDraw.Rectangle{Int64}(SimpleDraw.Point{Int64}(2, 2), 255, 255)|
|Rectangle|1024|1024|11.081 μs|0 bytes|SimpleDraw.Rectangle{Int64}(SimpleDraw.Point{Int64}(2, 2), 1023, 1023)|
|FilledRectangle|64|64|1.147 μs|0 bytes|SimpleDraw.FilledRectangle{Int64}(SimpleDraw.Point{Int64}(2, 2), 63, 63)|
|FilledRectangle|256|256|10.747 μs|0 bytes|SimpleDraw.FilledRectangle{Int64}(SimpleDraw.Point{Int64}(2, 2), 255, 255)|
|FilledRectangle|1024|1024|194.078 μs|0 bytes|SimpleDraw.FilledRectangle{Int64}(SimpleDraw.Point{Int64}(2, 2), 1023, 1023)|
|ThickRectangle|64|64|1.809 μs|0 bytes|SimpleDraw.ThickRectangle{Int64}(SimpleDraw.Point{Int64}(2, 2), 63, 63, 16)|
|ThickRectangle|256|256|10.167 μs|0 bytes|SimpleDraw.ThickRectangle{Int64}(SimpleDraw.Point{Int64}(2, 2), 255, 255, 64)|
|ThickRectangle|1024|1024|211.408 μs|0 bytes|SimpleDraw.ThickRectangle{Int64}(SimpleDraw.Point{Int64}(2, 2), 1023, 1023, 256)|
|FilledTriangle|64|64|1.452 μs|0 bytes|SimpleDraw.FilledTriangle{Int64}(SimpleDraw.Point{Int64}(2, 2), SimpleDraw.Point{Int64}(63, 32), SimpleDraw.Point{Int64}(32, 63))|
|FilledTriangle|256|256|8.507 μs|0 bytes|SimpleDraw.FilledTriangle{Int64}(SimpleDraw.Point{Int64}(2, 2), SimpleDraw.Point{Int64}(255, 128), SimpleDraw.Point{Int64}(128, 255))|
|FilledTriangle|1024|1024|88.216 μs|0 bytes|SimpleDraw.FilledTriangle{Int64}(SimpleDraw.Point{Int64}(2, 2), SimpleDraw.Point{Int64}(1023, 512), SimpleDraw.Point{Int64}(512, 1023))|
|Character|64|64|2.550 μs|0 bytes|SimpleDraw.Character{Int64, Char, SimpleDraw.Terminus_32_16}(SimpleDraw.Point{Int64}(2, 2), 'A', SimpleDraw.Terminus_32_16([0 0 … 0 0; 0 0 … 0 0; … ; 0 0 … 0 0; 0 0 … 0 0;;; 0 0 … 0 0; 0 0 … 0 0; … ; 0 0 … 0 0; 0 0 … 0 0;;; 0 0 … 0 0; 0 0 … 0 0; … ; 0 0 … 0 0; 0 0 … 0 0;;; … ;;; 0 0 … 0 0; 0 0 … 0 0; … ; 0 0 … 0 0; 0 0 … 0 0;;; 0 0 … 0 0; 0 0 … 0 0; … ; 0 0 … 0 0; 0 0 … 0 0;;; 0 0 … 0 0; 0 0 … 0 0; … ; 0 0 … 0 0; 0 0 … 0 0]))|
|Character|256|256|2.550 μs|0 bytes|SimpleDraw.Character{Int64, Char, SimpleDraw.Terminus_32_16}(SimpleDraw.Point{Int64}(2, 2), 'A', SimpleDraw.Terminus_32_16([0 0 … 0 0; 0 0 … 0 0; … ; 0 0 … 0 0; 0 0 … 0 0;;; 0 0 … 0 0; 0 0 … 0 0; … ; 0 0 … 0 0; 0 0 … 0 0;;; 0 0 … 0 0; 0 0 … 0 0; … ; 0 0 … 0 0; 0 0 … 0 0;;; … ;;; 0 0 … 0 0; 0 0 … 0 0; … ; 0 0 … 0 0; 0 0 … 0 0;;; 0 0 … 0 0; 0 0 … 0 0; … ; 0 0 … 0 0; 0 0 … 0 0;;; 0 0 … 0 0; 0 0 … 0 0; … ; 0 0 … 0 0; 0 0 … 0 0]))|
|Character|1024|1024|2.552 μs|0 bytes|SimpleDraw.Character{Int64, Char, SimpleDraw.Terminus_32_16}(SimpleDraw.Point{Int64}(2, 2), 'A', SimpleDraw.Terminus_32_16([0 0 … 0 0; 0 0 … 0 0; … ; 0 0 … 0 0; 0 0 … 0 0;;; 0 0 … 0 0; 0 0 … 0 0; … ; 0 0 … 0 0; 0 0 … 0 0;;; 0 0 … 0 0; 0 0 … 0 0; … ; 0 0 … 0 0; 0 0 … 0 0;;; … ;;; 0 0 … 0 0; 0 0 … 0 0; … ; 0 0 … 0 0; 0 0 … 0 0;;; 0 0 … 0 0; 0 0 … 0 0; … ; 0 0 … 0 0; 0 0 … 0 0;;; 0 0 … 0 0; 0 0 … 0 0; … ; 0 0 … 0 0; 0 0 … 0 0]))|
|TextLine|64|64|7.386 μs|0 bytes|SimpleDraw.TextLine{Int64, String, SimpleDraw.Terminus_32_16}(SimpleDraw.Point{Int64}(1, 1), "LPDW", SimpleDraw.Terminus_32_16([0 0 … 0 0; 0 0 … 0 0; … ; 0 0 … 0 0; 0 0 … 0 0;;; 0 0 … 0 0; 0 0 … 0 0; … ; 0 0 … 0 0; 0 0 … 0 0;;; 0 0 … 0 0; 0 0 … 0 0; … ; 0 0 … 0 0; 0 0 … 0 0;;; … ;;; 0 0 … 0 0; 0 0 … 0 0; … ; 0 0 … 0 0; 0 0 … 0 0;;; 0 0 … 0 0; 0 0 … 0 0; … ; 0 0 … 0 0; 0 0 … 0 0;;; 0 0 … 0 0; 0 0 … 0 0; … ; 0 0 … 0 0; 0 0 … 0 0]))|
|TextLine|256|256|30.133 μs|0 bytes|SimpleDraw.TextLine{Int64, String, SimpleDraw.Terminus_32_16}(SimpleDraw.Point{Int64}(1, 1), "BDNMZIMCRQRSRHOG", SimpleDraw.Terminus_32_16([0 0 … 0 0; 0 0 … 0 0; … ; 0 0 … 0 0; 0 0 … 0 0;;; 0 0 … 0 0; 0 0 … 0 0; … ; 0 0 … 0 0; 0 0 … 0 0;;; 0 0 … 0 0; 0 0 … 0 0; … ; 0 0 … 0 0; 0 0 … 0 0;;; … ;;; 0 0 … 0 0; 0 0 … 0 0; … ; 0 0 … 0 0; 0 0 … 0 0;;; 0 0 … 0 0; 0 0 … 0 0; … ; 0 0 … 0 0; 0 0 … 0 0;;; 0 0 … 0 0; 0 0 … 0 0; … ; 0 0 … 0 0; 0 0 … 0 0]))|
|TextLine|1024|1024|121.349 μs|0 bytes|SimpleDraw.TextLine{Int64, String, SimpleDraw.Terminus_32_16}(SimpleDraw.Point{Int64}(1, 1), "EFXHBRDIFHLLIIBXJIDEXYSRJUDELCIMZIMXWOCHCFLHXSBLLMLMSZFVKSBEZTVA", SimpleDraw.Terminus_32_16([0 0 … 0 0; 0 0 … 0 0; … ; 0 0 … 0 0; 0 0 … 0 0;;; 0 0 … 0 0; 0 0 … 0 0; … ; 0 0 … 0 0; 0 0 … 0 0;;; 0 0 … 0 0; 0 0 … 0 0; … ; 0 0 … 0 0; 0 0 … 0 0;;; … ;;; 0 0 … 0 0; 0 0 … 0 0; … ; 0 0 … 0 0; 0 0 … 0 0;;; 0 0 … 0 0; 0 0 … 0 0; … ; 0 0 … 0 0; 0 0 … 0 0;;; 0 0 … 0 0; 0 0 … 0 0; … ; 0 0 … 0 0; 0 0 … 0 0]))|

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

1. ### `Background`

    ```julia
    struct Background <: AbstractShape end
    ```

    <img src="https://user-images.githubusercontent.com/32610387/147943624-244cbe86-1aac-4ad1-9285-4f35d38009c6.png">

1. ### `Point`

    ```julia
    struct Point{I <: Integer} <: AbstractShape
        i::I
        j::I
    end
    ```

    <img src="https://user-images.githubusercontent.com/32610387/147943555-5e6c4560-a02b-48b8-9638-c7c568936147.png">

1. ### `Line`

    ```julia
    struct Line{I <: Integer} <: AbstractLine
        point1::Point{I}
        point2::Point{I}
    end
    ```

    `Line(point1, point2)` will draw the same thing as `Line(point2, point1)` as they are always sorted internally. But note that the visual representation of the line may not symmetric with respect to the end points in general.

    <img src="https://user-images.githubusercontent.com/32610387/211235212-3ac45d97-8dde-45cf-9865-dbf322dda741.png">

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

1. ### `Triangle`

    ```julia
    struct Triangle{I <: Integer} <: AbstractTriangle
        point1::Point{I}
        point2::Point{I}
        point3::Point{I}
    end
    ```

    <img src="https://user-images.githubusercontent.com/32610387/211233788-899be8c0-ba0b-4fe7-b217-0818025a458a.png">

1. ### `FilledTriangle`

    ```julia
    struct FilledTriangle{I <: Integer} <: AbstractTriangle
        point1::Point{I}
        point2::Point{I}
        point3::Point{I}
    end
    ```

    <img src="https://user-images.githubusercontent.com/32610387/211234382-54eed8ca-f1a9-404a-ba85-2934acbb7da8.png">

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

1. ### `Bitmap`

    ```julia
    struct Bitmap{I <: Integer, B <: AbstractMatrix{Bool}} <: AbstractShape
        position::Point{I}
        bitmap::B
    end
    ```

    Can be used to draw a 1-bit image using some color on an image. For example, it is used for drawing character glyphs in `Character` or `TextLine`.

    <img src="https://user-images.githubusercontent.com/32610387/211419295-6d734b0e-5438-4d23-918f-f09db144f047.png">

    <img src="https://user-images.githubusercontent.com/32610387/211419311-80caada5-5c68-44d5-8ba0-3d8a23cc6c8e.png">

1. ### `Image`

    ```julia
    struct Image{I <: Integer, A} <: AbstractShape
        position::Point{I}
        image::A
    end
    ```

    Can be used to draw an existing image on top of an image at some position. No need to pass color explicitly, the sub-image should already be colored. Whereas in `Bitmap`, one needs to pass color explicitly and it can only be of a single color.

    <img src="https://user-images.githubusercontent.com/32610387/211422416-98c188a0-205a-49dc-8a4f-08cab3407af4.png">

    <img src="https://user-images.githubusercontent.com/32610387/211422426-2e2260b6-7588-45c5-8bc3-c151c4da1002.png">

1. ### `Character`

    ```julia
    struct Character{I <: Integer, C <: AbstractChar, F <: AbstractFont} <: AbstractShape
        position::Point{I}
        character::C
        font::F
    end
    ```

    There are 6 monospace ASCII fonts are available at this point:
    1. `TERMINUS_16_8` (height 16 pixels, width 8 pixels)
    2. `TERMINUS_BOLD_16_8` (height 16 pixels, width 8 pixels)
    3. `TERMINUS_24_12` (height 24 pixels, width 12 pixels)
    4. `TERMINUS_BOLD_24_12` (height 24 pixels, width 12 pixels)
    5. `TERMINUS_32_16` (height 32 pixels, width 16 pixels)
    6. `TERMINUS_BOLD_32_16` (height 32 pixels, width 16 pixels)

    Only glyphs for ASCII characters are available as of now.

    <img src="https://user-images.githubusercontent.com/32610387/147944083-56f45efc-1c7f-4f19-ae53-e17d5f8e51b6.png">

1. ### `TextLine`

    ```julia
    struct TextLine{I <: Integer, S, F <: AbstractFont} <: AbstractShape
        position::Point{I}
        text::S
        font::F
    end
    ```

    There are 6 monospace ASCII fonts are available at this point:
    1. `TERMINUS_16_8` (height 16 pixels, width 8 pixels)
    2. `TERMINUS_BOLD_16_8` (height 16 pixels, width 8 pixels)
    3. `TERMINUS_24_12` (height 24 pixels, width 12 pixels)
    4. `TERMINUS_BOLD_24_12` (height 24 pixels, width 12 pixels)
    5. `TERMINUS_32_16` (height 32 pixels, width 16 pixels)
    6. `TERMINUS_BOLD_32_16` (height 32 pixels, width 16 pixels)

    Only glyphs for ASCII characters are available as of now.

    <img src="https://user-images.githubusercontent.com/32610387/147944102-2480436c-d9b8-47bb-9134-5537b4014791.png">

## References and License Information

1. Octant drawing: [https://en.wikipedia.org/w/index.php?title=Midpoint_circle_algorithm&oldid=1073593456](https://en.wikipedia.org/w/index.php?title=Midpoint_circle_algorithm&oldid=1073593456)
1. Line drawing: [https://en.wikipedia.org/w/index.php?title=Bresenham%27s_line_algorithm&oldid=1073834153](https://en.wikipedia.org/w/index.php?title=Bresenham%27s_line_algorithm&oldid=1073834153)
1. Fonts: This package supports bitmap fonts for [ASCII](https://en.wikipedia.org/wiki/ASCII) characters at this point. We use a subset of [Terminus Font](http://terminus-font.sourceforge.net/) for drawing the glyphs. Terminus Font is licensed under the SIL Open Font License, Version 1.1. The license is included as OFL.TXT in the `/src/fonts` directory in this repository, and is also available with a FAQ at [http://scripts.sil.org/OFL](http://scripts.sil.org/OFL).
1. Everything else is under [LICENSE](https://github.com/Sid-Bhatia-0/SimpleDraw.jl/blob/master/LICENSE).
