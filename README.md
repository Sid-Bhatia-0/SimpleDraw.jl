# SimpleDraw

This is a lightweight self-contained package that attempts to provide efficient drawing methods for some simple shapes. So far, in this package, all the shapes and drawing algorithms are integer-based, and all the drawing algorithms are single-threaded.

## Table of contents:

* [Getting Started](#getting-started)
* [Notes](#notes)
  - [API](#api)
  - [Basic drawing](#basic-drawing)
  - [Drawing optimizations](#drawing-optimizations)
  - [Visualization](#visualization)
  - [Fonts](#fonts)

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

This package does not export any names. The `draw!` function, along with all the types in [List of shapes](#list-of-shapes) can be considered as a part of the API. Everything else should be considered internal for now.

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

### Fonts

This package supports bitmap fonts for [ASCII](https://en.wikipedia.org/wiki/ASCII) characters at this point. We use a subset of [Terminus Font](http://terminus-font.sourceforge.net/) for drawing the glyphs. Terminus Font is licensed under the SIL Open Font License, Version 1.1. The license is included as OFL.TXT in the `/src/fonts` directory in this repository, and is also available with a FAQ at [http://scripts.sil.org/OFL](http://scripts.sil.org/OFL).

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

1. ### `Character`

    ```julia
    struct Character{I, C <: AbstractChar, F <: AbstractFont} <: AbstractShape
        position::Point{I}
        char::C
        font::F
    end
    ```

    When `font` is `TERMINUS_32_16`, then an instance of `Character` is considered valid only if `char` is a printable ascii character.

    <img src="https://user-images.githubusercontent.com/32610387/147944083-56f45efc-1c7f-4f19-ae53-e17d5f8e51b6.png">

1. ### `TextLine`

    ```julia
    struct TextLine{I, S, F <: AbstractFont} <: AbstractShape
        position::Point{I}
        text::S
        font::F
    end
    ```

    When `font` is `TERMINUS_32_16`, then an instance of `TextLine` is considered valid only if `text` is composed of printable ascii character.

    <img src="https://user-images.githubusercontent.com/32610387/147944102-2480436c-d9b8-47bb-9134-5537b4014791.png">
