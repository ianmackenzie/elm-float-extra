module Tests exposing (interpolateFrom, range)

import Expect exposing (Expectation)
import Float.Extra as Float
import Fuzz
import Test exposing (Test)


expectExactly : Float -> Float -> Expectation
expectExactly expected actual =
    actual |> Expect.within (Expect.Absolute 0.0) expected


interpolateFrom : Test
interpolateFrom =
    Test.describe "interpolateFrom"
        [ Test.fuzz2
            Fuzz.float
            Fuzz.float
            "'Float.interpolateFrom a b 0' returns a"
            (\a b -> Float.interpolateFrom a b 0 |> expectExactly a)
        , Test.fuzz2
            Fuzz.float
            Fuzz.float
            "'Float.interpolateFrom a b 1' returns b"
            (\a b -> Float.interpolateFrom a b 1 |> expectExactly b)
        ]


range : Test
range =
    Test.describe "range"
        [ Test.fuzz3
            Fuzz.float
            Fuzz.float
            (Fuzz.intRange 1 100)
            "Number of values is one greater than number of steps"
            (\start end steps ->
                Float.range { start = start, end = end, steps = steps }
                    |> List.length
                    |> Expect.equal (steps + 1)
            )
        , Test.fuzz3
            Fuzz.float
            Fuzz.float
            (Fuzz.intRange 1 100)
            "First value in range is equal to start value"
            (\start end steps ->
                Float.range { start = start, end = end, steps = steps }
                    |> List.head
                    |> Expect.equal (Just start)
            )
        , Test.fuzz3
            Fuzz.float
            Fuzz.float
            (Fuzz.intRange 1 100)
            "Last value in range is equal to end value"
            (\start end steps ->
                Float.range { start = start, end = end, steps = steps }
                    |> List.reverse
                    |> List.head
                    |> Expect.equal (Just end)
            )
        ]


greaterThan : Test
greaterThan =
    Test.describe "greaterThan"
        [ Test.fuzz
            Fuzz.float
            "Any number x should not be greater than x + 1"
            (\x ->
                Float.greaterThan x (x + 1)
                    |> Expect.equal False
            )
        , Test.fuzz
            Fuzz.float
            "Any number x should be greater than x - 1"
            (\x ->
                Float.greaterThan x (x - 1)
                    |> Expect.equal True
            )
        , Test.fuzz
            Fuzz.float
            "Any number x should not be greater than iself"
            (\x ->
                Float.greaterThan x x
                    |> Expect.equal False
            )
        ]


greaterThanOrEqualTo : Test
greaterThanOrEqualTo =
    Test.describe "greaterThanOrEqualTo"
        [ Test.fuzz
            Fuzz.float
            "Any number x should not be greater than or equal to x + 1"
            (\x ->
                Float.greaterThanOrEqualTo x (x + 1)
                    |> Expect.equal False
            )
        , Test.fuzz
            Fuzz.float
            "Any number x should be greater than or equal to x - 1"
            (\x ->
                Float.greaterThanOrEqualTo x (x - 1)
                    |> Expect.equal True
            )
        , Test.fuzz
            Fuzz.float
            "Any number x should be greater or equal to iself"
            (\x ->
                Float.greaterThanOrEqualTo x x
                    |> Expect.equal True
            )
        ]


lessThan : Test
lessThan =
    Test.describe "lessThan"
        [ Test.fuzz
            Fuzz.float
            "Any number x should be less than x + 1"
            (\x ->
                Float.lessThan x (x + 1)
                    |> Expect.equal True
            )
        , Test.fuzz
            Fuzz.float
            "Any number x should not be less than x - 1"
            (\x ->
                Float.lessThan x (x - 1)
                    |> Expect.equal False
            )
        , Test.fuzz
            Fuzz.float
            "Any number x should not be less than iself"
            (\x ->
                Float.lessThan x x
                    |> Expect.equal False
            )
        ]


lessThanOrEqualTo : Test
lessThanOrEqualTo =
    Test.describe "lessThanOrEqualTo"
        [ Test.fuzz
            Fuzz.float
            "Any number x should be less than or equal to x + 1"
            (\x ->
                Float.lessThan x (x + 1)
                    |> Expect.equal True
            )
        , Test.fuzz
            Fuzz.float
            "Any number x should not be less than or equal to  x - 1"
            (\x ->
                Float.lessThan x (x - 1)
                    |> Expect.equal False
            )
        , Test.fuzz
            Fuzz.float
            "Any number x should be less than or equal to iself"
            (\x ->
                Float.lessThan x x
                    |> Expect.equal True
            )
        ]
