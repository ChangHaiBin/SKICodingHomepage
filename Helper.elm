module Helper exposing (..)

-- Read more about this program in the official Elm guide:
-- https://guide.elm-lang.org/architecture/user_input/buttons.html


combineResult : Result a a -> a
combineResult result =
    case result of
        Result.Err x ->
            x

        Result.Ok x ->
            x


numToString : number -> String
numToString i =
    case i of
        6 ->
            "A six-"

        7 ->
            "A seven-"

        8 ->
            "An eight-"

        9 ->
            "A nine-"

        10 ->
            "A ten-"

        11 ->
            "An eleven-"

        12 ->
            "A twelve-"

        13 ->
            "A thirteen-"

        14 ->
            "A fourteen-"

        _ ->
            "PLACEHOLDER"


indexAt : Int -> List a -> Maybe a
indexAt i xs =
    if i < 0 then
        Nothing
    else
        case ( i, xs ) of
            ( 0, x :: xs ) ->
                Just x

            ( _, [] ) ->
                Nothing

            ( _, x :: xs ) ->
                indexAt (i - 1) xs


resultFilter :
    (value -> Bool)
    -> (value -> a)
    -> Result a value
    -> Result a value
resultFilter boolF errorF =
    Result.andThen
        (\x ->
            if boolF x then
                Result.Ok x
            else
                Result.Err (errorF x)
        )


listContains : a -> List a -> Bool
listContains x xs =
    xs
        |> List.any ((==) x)


allFoundIn : List a -> List a -> Bool
allFoundIn xs ys =
    ys
        |> List.all (\y -> xs |> listContains y)


printUpperCharList : List Char -> String
printUpperCharList xs =
    xs
        |> List.reverse
        |> List.map (String.fromChar >> String.toUpper)
        |> List.foldl (\x y -> x ++ " " ++ y) " "


replaceIfNotFoundIn : a -> List a -> List a -> List a
replaceIfNotFoundIn replacement ys zs =
    zs
        |> List.map
            (\z ->
                if listContains z ys then
                    z
                else
                    replacement
            )
