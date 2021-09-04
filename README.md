# SimpleDraw

This package provides fast drawing methods for the following simple shapes:

1. Line
1. Circle
1. FilledCircle
1. Rectangle
1. FilledRectangle

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

<img src="https://user-images.githubusercontent.com/32610387/123078332-7d471680-d438-11eb-9216-0f0b41efdbd6.png">

### Circle

```julia
mutable struct Circle{I <: Integer, C} <: AbstractDrawable
    i_center::I
    j_center::I
    radius::I
    color::C
end
```

<img src="https://user-images.githubusercontent.com/32610387/123078423-95b73100-d438-11eb-8329-546982bbb00c.png">

### FilledCircle

```julia
mutable struct FilledCircle{I <: Integer, C} <: AbstractDrawable
    i_center::I
    j_center::I
    radius::I
    color::C
end
```

<img src="https://user-images.githubusercontent.com/32610387/123078474-a2d42000-d438-11eb-88cf-d0635380a21f.png">

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

<img src="https://user-images.githubusercontent.com/32610387/123078509-ac5d8800-d438-11eb-814f-b7fa32857878.png">

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

<img src="https://user-images.githubusercontent.com/32610387/123078547-b67f8680-d438-11eb-94be-af77c473d0e9.png">
