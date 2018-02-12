module Tests exposing (..)

import Expect
import Float.Extra as Float
import Fuzz
import Test exposing (Test)


interpolateFrom : Test
interpolateFrom =
    Test.describe "interpolateFrom"
        [ Test.fuzz2
            Fuzz.float
            Fuzz.float
            "'Float.interpolateFrom a b 0' returns a"
            (\a b -> Float.interpolateFrom a b 0 |> Expect.equal a)
        , Test.fuzz2
            Fuzz.float
            Fuzz.float
            "'Float.interpolateFrom a b 1' returns b"
            (\a b -> Float.interpolateFrom a b 1 |> Expect.equal b)
        ]
