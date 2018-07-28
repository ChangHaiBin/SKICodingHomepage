module SKICoding exposing (..)

-- Read more about this program in the official Elm guide:
-- https://guide.elm-lang.org/architecture/user_input/buttons.html

import Html exposing (..)
import Html.Attributes as Attr exposing (class, placeholder, src, style)
import Html.Events exposing (keyCode, on, onClick, onInput)
import Json.Decode as Json
import Random
import Style exposing (..)


style10_s : Attribute msg
style10_s =
    style
        [ "backgroundColor" => "#FFFFFF"
        , "color" => "#000000"
        , "font-family" => "Arial"
        ]


onKeyDown : (Int -> value) -> Attribute value
onKeyDown tagger =
    on "keydown" (Json.map tagger keyCode)



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


type alias Model =
    { answer : Int
    , response : String
    , userInput : String
    }


init : ( Model, Cmd Msg )
init =
    ( { answer = 50
      , response = "New Game. A number from 1 to 99 was chosen."
      , userInput = ""
      }
    , Random.generate NewGame (Random.int 1 99)
    )



-- UPDATE


combineResult : Result a a -> a
combineResult result =
    case result of
        Result.Err x ->
            x

        Result.Ok x ->
            x


type Msg
    = Roll
    | CheckAnswer
    | NewGame Int
    | UpdateUserInput String
    | KeyDown Int


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Roll ->
            ( model, Random.generate NewGame (Random.int 1 99) )

        NewGame answer ->
            ( { model
                | answer = answer
                , response = "New Game. A number from 1 to 99 was chosen."
              }
            , Cmd.none
            )

        UpdateUserInput userInput ->
            ( { model
                | userInput = userInput
              }
            , Cmd.none
            )

        CheckAnswer ->
            let
                response =
                    model.userInput
                        |> String.toInt
                        |> Result.mapError (\_ -> "Your input is not a valid integer.")
                        |> Result.andThen
                            (\a ->
                                if a < 1 || a > 99 then
                                    Result.Err "Your input exceeds the range of 1 to 99"
                                else
                                    Result.Ok a
                            )
                        |> Result.map
                            (\a ->
                                if model.answer > a then
                                    "The correct answer is more than " ++ toString a
                                else if model.answer < a then
                                    "The correct answer is less than " ++ toString a
                                else
                                    "The correct answer is " ++ toString a ++ ". You win!"
                            )
                        |> combineResult
            in
            ( { model | response = response }, Cmd.none )

        KeyDown key ->
            if key == 13 then
                ( model, Cmd.none |> Cmd.map (\_ -> CheckAnswer) )
            else
                ( model, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- Window.resizes (\qqq -> Resize qqq.height qqq.width)
-- VIEW


view : Model -> Html.Html Msg
view model =
    div [ fontSize_percent_s 100 ]
        [ div [ pad2_s 50 0, style10_s, center_s, width_s 100 ]
            [ div [ arial_s, center_s, style [ "clear" => "right" ] ]
                [ span [ fontSize_percent_s 200, pad2_s 16 0, bold_s, maxWidth_s 700 ]
                    [ "Number Guessing Game" |> text ]

                --, div [ size 26 8 ] [ text "Coding lessons for kids" ]
                , p [ fontSize_percent_s 100, pad2_s 8 0 ]
                    [ text "Guess a number between 1 to 99" ]
                , p []
                    [ input
                        [ placeholder "Input"
                        , onInput UpdateUserInput
                        , Attr.type_ "number"
                        , Attr.min "1"
                        , Attr.max "99"
                        , onKeyDown KeyDown
                        ]
                        []
                    , button [ onClick CheckAnswer ] [ text "GUESS" ]
                    ]
                , p [] [ text model.response ]
                , p []
                    [ button [ onClick Roll ] [ text "NEW GAME" ]
                    ]
                ]
            ]
        ]
