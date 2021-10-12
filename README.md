# SimpleDraw

This is a lightweight package that provides fast drawing methods for some simple shapes.

**Note: This README reflects the most up to date information about the master branch. The README for the last released version can be found [here](https://github.com/Sid-Bhatia-0/SimpleDraw.jl/tree/00cd11b5d5492beefa33827947aa201f743faa42).**

## Table of contents:

* [Getting Started](#getting-started)
* [Notes](#notes)
  - [API](#api)
  - [Draw with bounds checking](#draw-with-bounds-checking)
  - [Visualization](#visualization)

[List of shapes](#list-of-shapes):

1. [`Background`](#background)
1. [`Line`](#line)
1. [`Circle`](#circle)
1. [`FilledCircle`](#filledcircle)
1. [`Rectangle`](#rectangle)
1. [`FilledRectangle`](#filledrectangle)
1. [`Cross`](#cross)
1. [`HollowCross`](#hollowcross)

## Getting Started

```julia
import SimpleDraw as SD

# create a canvas (could be any AbstractMatrix)
image = falses(17, 17)

# create the shape
shape = SD.Line(5, 2, 13, 16)

# we will draw on the boolean image with the "color" true
color = true

# draw the shape on image
SD.draw!(image, shape, color)

# print the boolean image using Unicode block characters
SD.visualize(image)
```

<img src="https://user-images.githubusercontent.com/32610387/123078332-7d471680-d438-11eb-9216-0f0b41efdbd6.png" width = "400px">

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

By default, all the drawing algorithms (except the one for `Background`, which doesn't require bounds-checking) utilize the `put_pixel!` function in order to draw each pixel. It will only draw a pixel if it is within the bounds of the `image`, so you don't have to worry about your program breaking because it is trying to draw something outside the bounds of the `image`.

### Visualization

The `visualize` function helps visualize a binary image inside the terminal using Unicode block characters to represent pixels. This is a quick tool to verify that your drawing algorithms are functioning as intended. This works well for low resolution images. You can maximize your terminal window and reduce the font size to visualize higher resolutions images.

## List of drawables

1. ### `Background`

    ```julia
    struct Background <: AbstractShape end
    ```

    <img src="https://user-images.githubusercontent.com/32610387/136918547-21c71eba-fcb8-4f8c-8261-9be0fa2410b4.png" width = "400px">

1. ### `Line`

    ```julia
    mutable struct Line{I <: Integer} <: AbstractShape
        i1::I
        j1::I
        i2::I
        j2::I
    end
    ```

    <img src="https://user-images.githubusercontent.com/32610387/123078332-7d471680-d438-11eb-9216-0f0b41efdbd6.png" width = "400px">

1. ### `Circle`

    ```julia
    mutable struct Circle{I <: Integer} <: AbstractShape
        i_center::I
        j_center::I
        radius::I
    end
    ```

    <img src="https://user-images.githubusercontent.com/32610387/123078423-95b73100-d438-11eb-8329-546982bbb00c.png" width = "400px">

1. ### `FilledCircle`

    ```julia
    mutable struct FilledCircle{I <: Integer} <: AbstractShape
        i_center::I
        j_center::I
        radius::I
    end
    ```

    <img src="https://user-images.githubusercontent.com/32610387/123078474-a2d42000-d438-11eb-88cf-d0635380a21f.png" width = "400px">

1. ### `Rectangle`

    ```julia
    mutable struct Rectangle{I <: Integer} <: AbstractShape
        i_top_left::I
        j_top_left::I
        height::I
        width::I
    end
    ```

    <img src="https://user-images.githubusercontent.com/32610387/123078509-ac5d8800-d438-11eb-814f-b7fa32857878.png" width = "400px">

1. ### `FilledRectangle`

    ```julia
    mutable struct FilledRectangle{I <: Integer} <: AbstractShape
        i_top_left::I
        j_top_left::I
        height::I
        width::I
    end
    ```

    <img src="https://user-images.githubusercontent.com/32610387/123078547-b67f8680-d438-11eb-94be-af77c473d0e9.png" width = "400px">

1. ### `Cross`

    ```julia
    mutable struct Cross{I <: Integer} <: AbstractShape
        i_center::I
        j_center::I
        radius::I
    end
    ```

    <img src="https://user-images.githubusercontent.com/32610387/136918598-ba83ae87-a514-42cb-9d78-01b1aa7135aa.png" width = "400px">

1. ### `HollowCross`

    ```julia
    mutable struct HollowCross{I <: Integer} <: AbstractShape
        i_center::I
        j_center::I
        radius::I
    end
    ```

    <img src="https://user-images.githubusercontent.com/32610387/136918626-e983bcb1-b722-4ba7-a449-fee5a198d40e.png" width = "400px">
