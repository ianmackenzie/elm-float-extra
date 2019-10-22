# elm-float-extra

This package contains some basic utilities for working with `Float` values in
[Elm](http://elm-lang.org). I recommmend using it as:

```elm
import Float.Extra as Float
```

Functionality is provided for comparisons...

```elm
Float.equalWithin 1e-3 1.9999 2.0001
--> True

List.filter (Float.lessThan 1) [ 0, 0.5, 1, 1.5, 2 ]
--> [ 0, 0.5 ]
```

...interpolation...

```elm
Float.interpolateFrom 5 10 0.6
--> 8

Float.range { start = 20, end = 30, steps = 4 }
--> [ 20, 22.5, 25, 27.5, 30 ]
```

...and some constants:

```elm
Float.positiveInfinity
--> Infinity
```

## Contributing

Yes please! I'm very open to bug fixes and requests for new functionality.
Please [open a new
issue](https://github.com/ianmackenzie/elm-float-extra/issues) or send me
(**@ianmackenzie**) a message on the [Elm Slack](https://elmlang.herokuapp.com/)
before starting any major work, though, so we can discuss different approaches.
