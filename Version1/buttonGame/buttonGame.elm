module SKICoding exposing (..)

-- Read more about this program in the official Elm guide:
-- https://guide.elm-lang.org/architecture/user_input/buttons.html

import Char
import Helper exposing (combineResult, indexAt, numToString)
import Html exposing (..)
import Html.Attributes as Attr exposing (class, placeholder, src, style)
import Html.Events exposing (keyCode, on, onClick, onInput)
import Keyboard
import Random
import Style exposing (..)
import WordList exposing (wordList)


style10_s : Attribute msg
style10_s =
    style
        [ "backgroundColor" => "#FFFFFF"
        , "color" => "#000000"
        , "font-family" => "Arial"
        ]



-- Read more about this program in the official Elm guide:
-- https://guide.elm-lang.org/architecture/effects/random.html


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


listMapi : (Int -> a -> result) -> List a -> List result
listMapi f xs =
    let
        len =
            xs |> List.length
    in
    List.map2 f (List.range 0 (len - 1)) xs


mapij : (Int -> Int -> a -> result) -> List (List a) -> List (List result)
mapij f xss =
    listMapi (listMapi << f) xss


contains : a -> List a -> Bool
contains x xs =
    xs
        |> List.any ((==) x)


type alias Model =
    { grid : List (List Bool)
    , nCol : Int
    , nRow : Int
    , status : Bool
    , userInput : Maybe Int
    , errorMessage : String
    }


init : ( Model, Cmd Msg )
init =
    let
        nRow =
            5

        nCol =
            5
    in
    ( { grid =
            List.repeat nRow (List.repeat nCol False)
      , nCol = nCol
      , nRow = nRow
      , status = False
      , userInput = Nothing
      , errorMessage = ""
      }
      --, Random.generate NewWord (Random.int 0 ((wordList |> List.length) - 1))
    , Cmd.none
    )



-- UPDATE


type Msg
    = Roll
    | Change Int Int
    | ResetGame
    | UpdateUserInput String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Roll ->
            let
                wordLength =
                    wordList |> List.length
            in
            --( model, Random.generate NewWord (Random.int 0 (wordLength - 1)) )
            ( model, Cmd.none )

        Change i j ->
            let
                candidates =
                    [ ( i, j ), ( i + 1, j ), ( i - 1, j ), ( i, j + 1 ), ( i, j - 1 ) ]
                        |> List.filter
                            (\( x, y ) ->
                                0 <= x && x < model.nRow && 0 <= y && y < model.nCol
                            )

                newGrid =
                    model.grid
                        |> mapij
                            (\x y val ->
                                if candidates |> contains ( x, y ) then
                                    not val
                                else
                                    val
                            )

                newStatus =
                    newGrid
                        |> List.all (List.all identity)
            in
            ( { model | grid = newGrid, status = newStatus }, Cmd.none )

        ResetGame ->
            case model.userInput of
                Nothing ->
                    ( model, Cmd.none )

                Just i ->
                    let
                        nRow =
                            i

                        nCol =
                            i

                        newGrid =
                            List.repeat i (List.repeat i False)

                        newStatus =
                            False
                    in
                    ( { model | grid = newGrid, nRow = nRow, nCol = nCol, status = newStatus }, Cmd.none )

        UpdateUserInput s ->
            s
                |> String.toInt
                |> Result.andThen
                    (\i ->
                        if i <= 0 || i > 10 then
                            Result.Err "Please input a range between 1 to 10"
                        else
                            Result.Ok i
                    )
                |> (\temp ->
                        case temp of
                            Result.Err errorMessage ->
                                ( { model | errorMessage = errorMessage, userInput = Nothing }, Cmd.none )

                            Result.Ok i ->
                                ( { model
                                    | errorMessage = ""
                                    , userInput = Just i
                                  }
                                , Cmd.none
                                )
                   )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



--Sub.batch        [ Keyboard.downs KeyMsg ]
-- Window.resizes (\qqq -> Resize qqq.height qqq.width)
-- VIEW


color i j grid =
    indexAt i grid
        |> Maybe.andThen (indexAt j)
        |> Maybe.map
            (\tf ->
                if tf then
                    backgroundColor_s "#2E8B57"
                else
                    backgroundColor_s "#EEEEEE"
            )
        |> Maybe.withDefault (backgroundColor_s "#000000")


view : Model -> Html.Html Msg
view model =
    div [ fontSize_percent_s 150 ]
        [ div [ pad2_s 50 0, style10_s, center_s, width_s 100 ]
            [ div [ arial_s, center_s, style [ "clear" => "right" ] ]
                [ span [ fontSize_percent_s 100, pad2_s 16 0, bold_s, maxWidth_s 700 ]
                    [ "Button Pressing Game" |> text ]
                , p [] [ "Each button will modify the color of itself" |> text ]
                , p [] [ "and its neighbors (up, down, left, right)" |> text ]
                , p []
                    (model.grid
                        |> listMapi
                            (\i xs ->
                                div []
                                    (xs
                                        |> listMapi
                                            (\j x ->
                                                button [ width_px_s 50, height_px_s 50, margin2_s 5 5, color i j model.grid, onClick (Change i j) ] []
                                            )
                                    )
                            )
                    )
                , p []
                    [ (if model.status then
                        "You Win!"
                       else
                        "Keep trying"
                      )
                        |> text
                    ]
                , p []
                    [ input
                        [ placeholder "Input"
                        , onInput UpdateUserInput
                        , Attr.type_ "number"
                        , Attr.min "1"
                        , Attr.max "99"
                        ]
                        []
                    ]
                , p [] [ button [ onClick ResetGame ] [ text "Change Size" ] ]
                ]
            ]
        ]
