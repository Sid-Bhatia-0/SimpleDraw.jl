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
1. [`Polyline`](#polyline)

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

By default, the `draw!` function draws the clipped shape, that is, it draws only those pixes that fall within the bounds of the image. So you don't have to worry about your program breaking because it is trying to draw something outside the bounds of the `image`. This is achieved in different ways for different shapes. For example:

1. In case of `Background`, we simply fill the entire array and don't need any explicit bounds checking.
1. In case of `VerticalLine` or `HorizontalLine`, we first clip the endpoints of the line to lie within the image and then draw the line with no further bounds checking.
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

    <img src="https://user-images.githubusercontent.com/32610387/139564735-8f9d7b27-e254-430c-90d9-81b7eef65cdd.png">

1. ### `Background`

    ```julia
    struct Background <: AbstractShape end
    ```

    <img src="https://user-images.githubusercontent.com/32610387/139564738-1269502a-9fa2-448d-88af-e2a02ec9baf8.png">

1. ### `VerticalLine`

    ```julia
    mutable struct VerticalLine{I <: Integer} <: AbstractShape
        i_start::I
        i_end::I
        j::I
    end
    ```

    <img src="https://user-images.githubusercontent.com/32610387/139564744-cf7ecb09-cb1c-4820-a74b-e81536d489c6.png">

1. ### `HorizontalLine`

    ```julia
    mutable struct HorizontalLine{I <: Integer} <: AbstractShape
        i::I
        j_start::I
        j_end::I
    end
    ```

    <img src="https://user-images.githubusercontent.com/32610387/139564748-8b8092ae-bb2f-4ae7-a76d-82f13aaaeb7a.png">

1. ### `Line`

    ```julia
    mutable struct Line{I <: Integer} <: AbstractShape
        point1::Point{I}
        point2::Point{I}
    end
    ```

    <img src="https://user-images.githubusercontent.com/32610387/139564759-50d524b8-bd70-4a19-a143-1a75644ad929.png">

1. ### `ThickLine`

    ```julia
    mutable struct ThickLine{I <: Integer} <: AbstractShape
        point1::Point{I}
        point2::Point{I}
        brush_radius::I
    end
    ```

    <img src="https://user-images.githubusercontent.com/32610387/139564767-7be5f1a7-112e-4077-902e-29ad58a871f2.png">

1. ### `Circle`

    ```julia
    mutable struct Circle{I <: Integer} <: AbstractShape
        center::Point{I}
        radius::I
    end
    ```

    <img src="https://user-images.githubusercontent.com/32610387/139564772-f1d6eb10-0f52-4b65-9a08-f26447b53223.png">

1. ### `ThickCircle`

    ```julia
    mutable struct ThickCircle{I <: Integer} <: AbstractShape
        center::Point{I}
        radius::I
        thickness::I
    end
    ```

    <img src="https://user-images.githubusercontent.com/32610387/139564796-48abbce7-6378-4ceb-9859-300921c18c98.png">

1. ### `FilledCircle`

    ```julia
    mutable struct FilledCircle{I <: Integer} <: AbstractShape
        center::Point{I}
        radius::I
    end
    ```

    <img src="https://user-images.githubusercontent.com/32610387/139564810-757ee422-1d83-47a4-8894-b54f6d4bcf48.png">

1. ### `Rectangle`

    ```julia
    mutable struct Rectangle{I <: Integer} <: AbstractShape
        top_left::Point{I}
        height::I
        width::I
    end
    ```

    <img src="https://user-images.githubusercontent.com/32610387/139564833-cc6e8445-01da-4f6e-83a2-512e69d402dc.png">

1. ### `ThickRectangle`

    ```julia
    mutable struct ThickRectangle{I <: Integer} <: AbstractShape
        top_left::Point{I}
        height::I
        width::I
        thickness::I
    end
    ```

    <img src="https://user-images.githubusercontent.com/32610387/139564844-fb07ea5d-1ed5-422c-a2a5-067f1fb5c216.png">

1. ### `FilledRectangle`

    ```julia
    mutable struct FilledRectangle{I <: Integer} <: AbstractShape
        top_left::Point{I}
        height::I
        width::I
    end
    ```

    <img src="https://user-images.githubusercontent.com/32610387/139564859-bd027f70-857d-47eb-a42d-30e402aaf6d6.png">

1. ### `Cross`

    ```julia
    mutable struct Cross{I <: Integer} <: AbstractShape
        center::Point{I}
        radius::I
    end
    ```

    <img src="https://user-images.githubusercontent.com/32610387/139564870-27070ecc-e5b2-4c4e-a52e-a7b56bcd80d4.png">

1. ### `HollowCross`

    ```julia
    mutable struct HollowCross{I <: Integer} <: AbstractShape
        center::Point{I}
        radius::I
    end
    ```

    <img src="https://user-images.githubusercontent.com/32610387/139565013-ec55945c-eacd-441b-933d-91a6782ded1b.png">

1. ### `Polyline`

    ```julia
    mutable struct Polyline{I <: Integer} <: AbstractShape
        points::Vector{Point{I}}
    end
    ```

    <img src="https://user-images.githubusercontent.com/32610387/139564892-28b1874f-62eb-43d4-81a9-6fd893bd1fa7.png">
