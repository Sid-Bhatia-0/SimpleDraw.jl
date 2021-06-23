# SimpleDraw

This package provides fast drawing methods for the following simple shapes:

1. Line
1. Circle
1. FilledCircle
1. Rectangle
1. FilledRectangle

### Line

```
struct Line{I <: Integer} <: AbstractShape
    i1::I
    j1::I
    i2::I
    j2::I
end
```

### Circle

```
struct Circle{I <: Integer} <: AbstractShape
    i_center::I
    j_center::I
    radius::I
end
```

### FilledCircle

```
struct FilledCircle{I <: Integer} <: AbstractShape
    i_center::I
    j_center::I
    radius::I
end
```

### Rectangle

```
struct Rectangle{I <: Integer} <: AbstractShape
    i_top_left::I
    j_top_left::I
    height::I
    width::I
end
```

### FilledRectangle

```
struct FilledRectangle{I <: Integer} <: AbstractShape
    i_top_left::I
    j_top_left::I
    height::I
    width::I
end
```
