# SimpleDraw

This package provides fast drawing methods for the following simple things:

1. Background
1. Line
1. Circle
1. FilledCircle
1. Rectangle
1. FilledRectangle

### Background

```julia
mutable struct Background{C} <: AbstractDrawable
    color::C
end
```

<img src="https://user-images.githubusercontent.com/32610387/132227984-1a2bda30-0eff-4d7a-b16e-8584e7e57483.png">

### Line

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

### Circle

```julia
mutable struct Circle{I <: Integer, C} <: AbstractDrawable
    i_center::I
    j_center::I
    radius::I
    color::C
end
```

<img src="https://user-images.githubusercontent.com/32610387/132089918-7b5e28b6-b934-40bf-80c1-95e5d531ba54.png">

### FilledCircle

```julia
mutable struct FilledCircle{I <: Integer, C} <: AbstractDrawable
    i_center::I
    j_center::I
    radius::I
    color::C
end
```

<img src="https://user-images.githubusercontent.com/32610387/132089928-52124907-8fc6-42a2-84d4-530b2de66399.png">

### Rectangle

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

### FilledRectangle

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
