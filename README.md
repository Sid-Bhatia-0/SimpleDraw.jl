# SimpleDraw

This is a lightweight package that provides exact and efficient (for the most part) drawing methods for some simple shapes.

**Note: This README reflects the most up to date information about the master branch. The README for the last released version can be found [here](https://github.com/Sid-Bhatia-0/SimpleDraw.jl/tree/00cd11b5d5492beefa33827947aa201f743faa42).**

## Table of contents:

* [Getting Started](#getting-started)
* [Notes](#notes)
  - [API](#api)
  - [Draw with bounds checking](#draw-with-bounds-checking)
  - [Visualization](#visualization)

[List of shapes](#list-of-shapes):

1. [`Point`](#point)
1. [`Background`](#background)
1. [`VerticalLine`](#verticalline)
1. [`HorizontalLine`](#horizontalline)
1. [`Line`](#line)
1. [`ThickLine`](#thickline)
1. [`Circle`](#circle)
1. [`ThickCircle`](#thickcircle)
1. [`FilledCircle`](#filledcircle)
1. [`Rectangle`](#rectangle)
1. [`ThickRectangle`](#thickrectangle)
1. [`FilledRectangle`](#filledrectangle)
1. [`Cross`](#cross)
1. [`HollowCross`](#hollowcross)
1. [`PolyLine`](#polyline)

## Getting Started

```julia
import SimpleDraw as SD

# create a canvas (could be any AbstractMatrix)
image = falses(16, 16)

# create the shape
shape = SD.Line(SD.Point(5, 2), SD.Point(12, 15))

# we will draw on the boolean image with the "color" true
color = true

# draw the shape on image
SD.draw!(image, shape, color)

# print the boolean image using Unicode block characters
SD.visualize(image)
```

<img src="https://user-images.githubusercontent.com/32610387/137005406-6b9db65f-1a14-4008-85b8-92db93a02ad1.png" width = "400px">

## Notes

### API

Being able to draw broadly requires three things:

1. `image`: A canvas to draw on. It could be any `AbstractMatrix`.
1. `shape`: The shape to be drawn. Also, `shape`s can be composed to create more complex `shape`s.
    ```julia
    mutable struct MyComplexShape{I <: Integer} <: SD.AbstractShape
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

By default, all the drawing algorithms only draw within the bounds of the given image. So you don't have to worry about your program breaking because it is trying to draw something outside the bounds of the `image`. This is achieved in different ways for different shapes:

1. In case of `Background`, we simply fill the entire array and don't need any explicit bounds checking
1. In case of `Line`, we first clip the endpoints of the line to lie within the image and then draw the line with no further bounds checking.
1. In case of more complex shapes like `Circle`, we iterate through all the pixels of the `Circle` like we normally would, but draw only those pixels that lie within the bounds of the `image`.

### Visualization

The `visualize` function helps visualize a binary image inside the terminal using Unicode block characters to represent pixels. This is a quick tool to verify that your drawing algorithms are functioning as intended. This works well for low resolution images. You can maximize your terminal window and reduce the font size to visualize higher resolutions images.

## List of drawables

1. ### `Point`

    ```julia
    mutable struct Point{I <: Integer} <: AbstractShape
        i::I
        j::I
    end
    ```

    <img src="https://user-images.githubusercontent.com/32610387/137005163-a5ef6a22-3888-4005-bf98-fbe93c6342de.png" width = "400px">

1. ### `Background`

    ```julia
    struct Background <: AbstractShape end
    ```

    <img src="https://user-images.githubusercontent.com/32610387/137005363-9434627a-e3fb-4377-a955-1acebf337d09.png" width = "400px">

1. ### `VerticalLine`

    ```julia
    mutable struct VerticalLine{I <: Integer} <: AbstractShape
        i_start::I
        i_end::I
        j::I
    end
    ```

    <img src="https://user-images.githubusercontent.com/32610387/138334944-85f8b4de-5358-4105-9757-ba19c3feb78a.png">

1. ### `HorizontalLine`

    ```julia
    mutable struct HorizontalLine{I <: Integer} <: AbstractShape
        i::I
        j_start::I
        j_end::I
    end
    ```

    <img src="https://user-images.githubusercontent.com/32610387/138334953-781246cd-2039-4ccb-9913-74beb608a559.png">

1. ### `Line`

    ```julia
    mutable struct Line{I <: Integer} <: AbstractShape
        point1::Point{I}
        point2::Point{I}
    end
    ```

    <img src="https://user-images.githubusercontent.com/32610387/137005406-6b9db65f-1a14-4008-85b8-92db93a02ad1.png" width = "400px">

1. ### `ThickLine`

    ```julia
    mutable struct ThickLine{I <: Integer} <: AbstractShape
        point1::Point{I}
        point2::Point{I}
        brush_radius::I
    end
    ```

    <img src="https://user-images.githubusercontent.com/32610387/137580331-7883bdb1-8e6b-433c-81e5-c77c2910da4b.png" width = "400px">

1. ### `Circle`

    ```julia
    mutable struct Circle{I <: Integer} <: AbstractShape
        center::Point{I}
        radius::I
    end
    ```

    <img src="https://user-images.githubusercontent.com/32610387/137005414-1691f633-4ab5-441a-8308-c04b4791ff8a.png" width = "400px">

1. ### `ThickCircle`

    ```julia
    mutable struct ThickCircle{I <: Integer} <: AbstractShape
        center::Point{I}
        radius::I
        thickness::I
    end
    ```

    <img src="https://user-images.githubusercontent.com/32610387/138155225-c16356c4-8255-45b8-9b63-f7d43d5d73e9.png">

1. ### `FilledCircle`

    ```julia
    mutable struct FilledCircle{I <: Integer} <: AbstractShape
        center::Point{I}
        radius::I
    end
    ```

    <img src="https://user-images.githubusercontent.com/32610387/137005436-70d662f8-4182-4ba7-8c9b-d7eeec51ee3b.png" width = "400px">

1. ### `Rectangle`

    ```julia
    mutable struct Rectangle{I <: Integer} <: AbstractShape
        top_left::Point{I}
        height::I
        width::I
    end
    ```

    <img src="https://user-images.githubusercontent.com/32610387/137005464-c4efba73-9e30-4626-b05c-87fad58542cb.png" width = "400px">

1. ### `ThickRectangle`

    ```julia
    mutable struct ThickRectangle{I <: Integer} <: AbstractShape
        top_left::Point{I}
        height::I
        width::I
        thickness::I
    end
    ```

    <img src="https://user-images.githubusercontent.com/32610387/137974579-fad34a2f-9e7e-4045-b1b0-255244b90e23.png">

1. ### `FilledRectangle`

    ```julia
    mutable struct FilledRectangle{I <: Integer} <: AbstractShape
        top_left::Point{I}
        height::I
        width::I
    end
    ```

    <img src="https://user-images.githubusercontent.com/32610387/137005489-481c84a8-bc92-49b8-9cbd-1f9266d4cbae.png" width = "400px">

1. ### `Cross`

    ```julia
    mutable struct Cross{I <: Integer} <: AbstractShape
        center::Point{I}
        radius::I
    end
    ```

    <img src="https://user-images.githubusercontent.com/32610387/137005504-c7776d6d-d94c-4651-b2ac-e88d01f0ffea.png" width = "400px">

1. ### `HollowCross`

    ```julia
    mutable struct HollowCross{I <: Integer} <: AbstractShape
        center::Point{I}
        radius::I
    end
    ```

    <img src="https://user-images.githubusercontent.com/32610387/137005548-d5bdb2ab-1d7c-4a91-9ed4-a178dd9b6d10.png" width = "400px">

1. ### `PolyLine`

    ```julia
    mutable struct PolyLine{I <: Integer} <: AbstractShape
        points::Vector{Point{I}}
    end
    ```

    <img src="https://user-images.githubusercontent.com/32610387/137520922-0005f057-040f-4a9e-8fd7-93873dca6f73.png" width = "400px">
