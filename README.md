# SimpleDraw

This is a lightweight package that provides fast drawing methods for some simple shapes.

**Note: This README reflects the most up to date information about the master branch. The README for the last released version can be found [here](https://github.com/Sid-Bhatia-0/SimpleDraw.jl/tree/00cd11b5d5492beefa33827947aa201f743faa42).**

## Table of contents:

* [Getting Started](#getting-started)
* [Notes](#notes)
  - [API](#api)
  - [Draw with bounds checking](#draw-with-bounds-checking)
  - [Visualization](#visualization)

[List of drawables](#list-of-drawables):

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

# create the drawable
# true is the "color" for the boolean canvas
drawable = SD.Line(5, 2, 13, 16, true)

# draw the drawable on image
SD.draw!(image, drawable)

# print the boolean image using Unicode block characters
SD.visualize(image)
```

<img src="https://user-images.githubusercontent.com/32610387/132089909-fd6313af-b9be-4f61-8e53-387c699a83e4.png">

## Notes

### API

Being able to draw broadly requires two things: something to draw (`drawable`), and something to draw on (`image`). With this in mind, this package provides the `draw!` function, which can be invoked as follows:

```julia
SD.draw!(image, drawable)
```

Here, `image` is the canvas. It could be any `AbstractMatrix`. `drawable` contains the shape and color information for the object that needs to be drawn. Also, `drawable`s can easily be composed to create more complex `drawable`s. For example, like this:

```julia
import SimpleDraw as SD

mutable struct MyComplexDrawable{I, C} <: SD.AbstractDrawable
    background::SD.Background{C}
    line::SD.Line{I, C}
    circle::SD.Circle{I, C}
end

function SD.draw!(image::AbstractMatrix, drawable::MyComplexDrawable)
    SD.draw!(image, drawable.background)
    SD.draw!(image, drawable.line)
    SD.draw!(image, drawable.circle)
    return nothing
end
```

This allows full control over how you want to structure and draw your drawables.

Also, for now, all drawables and algorithms are integer-based.

### Draw with bounds checking

By default, all the drawing algorithms (except the one for `Background`) utilize the `put_pixel!` function in order to draw each pixel. It will only draw a pixel if it is within the bounds of the `image`, so you don't have to worry about your program breaking because it is trying to draw something outside the bounds of the `image`.

### Visualization

The `visualize` function helps visualize a binary image inside the terminal using Unicode block characters to represent pixels. This is a quick tool to verify that your drawing algorithms are functioning as intended. This works well for low resolution images. You can maximize your terminal window and reduce the font size to visualize higher resolutions images.

## List of drawables

1. ### `Background`

    ```julia
    mutable struct Background{C} <: AbstractDrawable
        color::C
    end
    ```

    <img src="https://user-images.githubusercontent.com/32610387/132227984-1a2bda30-0eff-4d7a-b16e-8584e7e57483.png">

1. ### `Line`

    ```julia
    mutable struct Line{I <: Integer, C} <: AbstractDrawable
        i1::I
        j1::I
        i2::I
        j2::I
        color::C
    end
    ```

    <img src="https://user-images.githubusercontent.com/32610387/132089909-fd6313af-b9be-4f61-8e53-387c699a83e4.png">

1. ### `Circle`

    ```julia
    mutable struct Circle{I <: Integer, C} <: AbstractDrawable
        i_center::I
        j_center::I
        radius::I
        color::C
    end
    ```

    <img src="https://user-images.githubusercontent.com/32610387/132089918-7b5e28b6-b934-40bf-80c1-95e5d531ba54.png">

1. ### `FilledCircle`

    ```julia
    mutable struct FilledCircle{I <: Integer, C} <: AbstractDrawable
        i_center::I
        j_center::I
        radius::I
        color::C
    end
    ```

    <img src="https://user-images.githubusercontent.com/32610387/132089928-52124907-8fc6-42a2-84d4-530b2de66399.png">

1. ### `Rectangle`

    ```julia
    mutable struct Rectangle{I <: Integer, C} <: AbstractDrawable
        i_top_left::I
        j_top_left::I
        height::I
        width::I
        color::C
    end
    ```

    <img src="https://user-images.githubusercontent.com/32610387/132089933-cc390f7c-9adc-4c82-b62f-4487f9c1ebef.png">

1. ### `FilledRectangle`

    ```julia
    mutable struct FilledRectangle{I <: Integer, C} <: AbstractDrawable
        i_top_left::I
        j_top_left::I
        height::I
        width::I
        color::C
    end
    ```

    <img src="https://user-images.githubusercontent.com/32610387/132089939-4871bd2e-eb4f-41ea-8550-98a97b14a3aa.png">

1. ### `Cross`

    ```julia
    mutable struct Cross{I <: Integer, C} <: AbstractDrawable
        i_center::I
        j_center::I
        radius::I
        color::C
    end
    ```

    <img src="https://user-images.githubusercontent.com/32610387/132384576-9afeae67-0c21-4cd8-9897-296b561ca62e.png">

1. ### `HollowCross`

    ```julia
    mutable struct HollowCross{I <: Integer, C} <: AbstractDrawable
        i_center::I
        j_center::I
        radius::I
        color::C
    end
    ```

    <img src="https://user-images.githubusercontent.com/32610387/132384583-3ee67eb8-b698-43e5-8103-708672d668e3.png">
