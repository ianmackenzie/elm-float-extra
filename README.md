This package contains some basic utilities for working with `Float` values in
[Elm](http://elm-lang.org). The current (very limited) API can be summed up by a
few examples:

```elm
import Float.Extra as Float

Float.equalWithin 1e-6 1.9999 2.0001
--> False

Float.equalWithin 1e-3 1.9999 2.0001
--> True

Float.interpolateFrom 5 10 0.6
--> 8

Float.interpolateFrom 10 5 0.1
--> 9.5

Float.range { start = 0, end = 1, steps = 5 }
--> [ 0, 0.2, 0.4, 0.6, 0.8, 1 ]

Float.range { start = 20, end = 30, steps = 4 }
--> [ 20, 22.5, 25, 27.5, 30 ]
```

Currently the only functions that have been implemented are ones that were
needed by the `elm-interval` and `elm-geometry` packages, but I'm happy to
consider pull requests for other generally-useful functionality. Please
[open a new issue](https://github.com/ianmackenzie/elm-float-extra/issues)
before starting work, though, so we can discuss different approaches!
