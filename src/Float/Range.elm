module Float.Range
    exposing
        ( Range
        , Resolution
        , from
        , map
        , maxStepSize
        , numSteps
        , toList
        )


type Resolution
    = MaxStepSize Float
    | NumSteps Int


type Range
    = Range Float Float Int
    | Empty


from : Float -> Float -> Resolution -> Range
from start end resolution =
    case resolution of
        NumSteps givenNumSteps ->
            if givenNumSteps > 0 then
                Range start end givenNumSteps
            else
                Empty

        MaxStepSize givenMaxStepSize ->
            let
                width =
                    abs (end - start)
            in
            if givenMaxStepSize >= width then
                Range start end 1
            else if givenMaxStepSize > 0 then
                -- Note that we must have width > givenMaxStepSize since the
                -- initial givenMaxStepSize >= width check failed - therefore
                -- the number of steps computed here will be > 1
                Range start end (ceiling (width / givenMaxStepSize))
            else
                Empty


map : (Float -> a) -> Range -> List a
map function range =
    case range of
        Range start end numSteps_ ->
            countdown
                (numSteps_ - 1)
                start
                ((end - start) / toFloat numSteps_)
                function
                [ function end ]

        Empty ->
            []


countdown : Int -> Float -> Float -> (Float -> a) -> List a -> List a
countdown index start stepSize function accumulated =
    if index == 0 then
        function start :: accumulated
    else
        countdown
            (index - 1)
            start
            stepSize
            function
            (function (start + toFloat index * stepSize) :: accumulated)


toList : Range -> List Float
toList range =
    map identity range


{-| Specify the number of steps to take between 0 and 1. Note that the number of
values in the range will be one greater than the number of steps!

    Range.values (Range.from 0 5 (Range.numSteps 1))
    --> [ 0, 5 ]

    Range.values (Range.from 0 1 (Range.numSteps 2))
    --> [ 0, 0.5, 1 ]

    Range.values (Range.from 0 1 (Range.numSteps 5))
    --> [ 0, 0.2, 0.4, 0.6, 0.8, 1 ]

Passing a negative or zero number of steps will result in an empty range:

    Range.values (Range.from 0 1 (Range.numSteps 0))
    --> []

-}
numSteps : Int -> Resolution
numSteps =
    NumSteps


{-| Specify the _maximum_ step size from one parameter value to the next. The
actual step size will be chosen to result in an even parameter spacing.

    Range.values (Range.from 0 1 (Range.maxStepSize 0.5))
    --> [ 0, 0.5, 1 ]

    Range.values (Range.from 0 1 (Range.maxStepSize 0.499))
    --> [ 0, 0.3333, 0.6667, 1 ]

    Range.values (Range.from 0 1 (Range.maxStepSize 1))
    --> [ 0, 1 ]

    Range.values (Range.from 0 1 (Range.maxStepSize 1.5))
    --> [ 0, 1 ]

Passing a negative or zero maximum step size will result in no values being
produced:

    Range.values (Range.from 0 1 (Range.maxStepSize 0))
    --> []

-}
maxStepSize : Float -> Resolution
maxStepSize =
    MaxStepSize
