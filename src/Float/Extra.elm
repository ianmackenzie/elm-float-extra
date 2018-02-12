module Float.Extra exposing (equalWithin, interpolateFrom)

{-| Convenience functions for working with `Float` values. Examples assume that
this module has been imported using

    import Float.Extra as Float

@docs equalWithin, interpolateFrom

-}

{--Imports for verifying the examples:

   import Float.Extra as Float
-}


{-| Check if two values are equal within a given tolerance.

    Float.equalWithin 1e-6 1.9999 2.0001
    --> False

    Float.equalWithin 1e-3 1.9999 2.0001
    --> True

-}
equalWithin : Float -> Float -> Float -> Bool
equalWithin tolerance firstValue secondValue =
    abs (secondValue - firstValue) <= tolerance


{-| Interpolate from the first value to the second, based on a parameter that
ranges from zero to one. Passing a parameter value of zero will return the start
value and passing a parameter value of one will return the end value.

    Float.interpolateFrom 5 10 0.5
    --> 7.5

    Float.interpolateFrom 2 -2 0.75
    --> -1

Parameter values less than zero or greater than one can be used to extrapolate:

    Float.interpolateFrom 5 10 1.5
    --> 12.5

    Float.interpolateFrom 2 -2 -0.25
    --> 3

-}
interpolateFrom : Float -> Float -> Float -> Float
interpolateFrom start end parameter =
    if parameter <= 0.5 then
        start + parameter * (end - start)
    else
        end + (1 - parameter) * (start - end)
