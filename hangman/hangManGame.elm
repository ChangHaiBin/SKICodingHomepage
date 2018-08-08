module SKICoding exposing (..)

-- Read more about this program in the official Elm guide:
-- https://guide.elm-lang.org/architecture/user_input/buttons.html

import Char
import Helper exposing (..)
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


type alias Model =
    { answer : String
    , response : String
    , userGuesses : List Char
    , numTries : Int
    , gameState : String
    , win : Bool
    }


init : ( Model, Cmd Msg )
init =
    ( { answer = "PlaceHolder"
      , response = "Guess any letter from A to Z."
      , userGuesses = []
      , numTries = 6
      , gameState = "PlaceHolder"
      , win = False
      }
    , Random.generate NewWord (Random.int 0 ((wordList |> List.length) - 1))
    )



-- UPDATE


type Msg
    = Roll
    | NewWord Int
    | KeyChar Char


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Roll ->
            let
                wordLength =
                    wordList |> List.length
            in
            ( model, Random.generate NewWord (Random.int 0 (wordLength - 1)) )

        KeyChar keyChar ->
            if model.numTries == 0 || model.win || not ('a' <= keyChar && keyChar <= 'z') then
                ( model, Cmd.none )
            else if model.userGuesses |> listContains keyChar then
                ( { model | response = "You have already guessed the letter " ++ (keyChar |> String.fromChar |> String.toUpper) }, Cmd.none )
            else
                let
                    newUserGuesses =
                        keyChar :: model.userGuesses

                    ( newNumTries, newResponse ) =
                        if model.answer |> String.toList |> listContains keyChar |> not then
                            ( model.numTries - 1, "The answer does NOT contain the letter " ++ (keyChar |> String.fromChar |> String.toUpper) )
                        else
                            ( model.numTries, "The answer contains the letter " ++ (keyChar |> String.fromChar |> String.toUpper) )

                    newWin =
                        model.answer |> String.toList |> allFoundIn newUserGuesses

                    newGameState =
                        if newNumTries == 0 then
                            "You lose! Answer: " ++ (model.answer |> String.toUpper)
                        else if newWin then
                            "You win! Answer: " ++ (model.answer |> String.toUpper)
                        else
                            model.gameState
                in
                ( { model
                    | numTries = newNumTries
                    , userGuesses = newUserGuesses
                    , response = newResponse
                    , gameState = newGameState
                    , win = newWin
                  }
                , Cmd.none
                )

        NewWord index ->
            let
                selectedWord =
                    wordList
                        |> indexAt index
                        |> Maybe.withDefault "test"
            in
            ( { model
                | answer = selectedWord
                , response = "New Game."
                , gameState = (selectedWord |> String.length |> numToString) ++ "letter word has been chosen."
                , userGuesses = []
                , numTries = 6
                , win = False
              }
            , Cmd.none
            )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Keyboard.downs (\keyCode -> KeyChar (keyCode |> Char.fromCode |> Char.toLower))
        ]



-- Window.resizes (\qqq -> Resize qqq.height qqq.width)
-- VIEW


view : Model -> Html.Html Msg
view model =
    div []
        [ div [ style [ "user-select" => "none" ], pad2_s 50 0, style10_s, center_s, width_s 100 ]
            [ div [ arial_s, center_s, style [ "clear" => "right" ] ]
                [ span [ fontSize_percent_s 150, pad2_s 16 0, bold_s, maxWidth_s 700 ] [ "Word Guessing Game (HangMan)" |> text ]
                , p [ fontSize_percent_s 100 ] [ "Use your keyboard (Desktop) or the buttons below (Mobile)" |> text ]
                , p [ fontSize_percent_s 200 ] [ model.answer |> String.toList |> replaceIfNotFoundIn '_' model.userGuesses |> printUpperCharList |> text ]
                , p []
                    [ div []
                        ([ 'a', 'b', 'c', 'd' ]
                            |> List.map (\x -> button [ fontSize_percent_s 150, width_px_s 50, height_px_s 50, margin2_s 5 5, backgroundColor_s "#EEEEEE", onClick (KeyChar x) ] [ text (x |> String.fromChar |> String.toUpper) ])
                        )
                    , div []
                        ([ 'e', 'f', 'g', 'h' ]
                            |> List.map (\x -> button [ fontSize_percent_s 150, width_px_s 50, height_px_s 50, margin2_s 5 5, backgroundColor_s "#EEEEEE", onClick (KeyChar x) ] [ text (x |> String.fromChar |> String.toUpper) ])
                        )
                    , div []
                        ([ 'i', 'j', 'k', 'l' ]
                            |> List.map (\x -> button [ fontSize_percent_s 150, width_px_s 50, height_px_s 50, margin2_s 5 5, backgroundColor_s "#EEEEEE", onClick (KeyChar x) ] [ text (x |> String.fromChar |> String.toUpper) ])
                        )
                    , div []
                        ([ 'm', 'n', 'o', 'p' ]
                            |> List.map (\x -> button [ fontSize_percent_s 150, width_px_s 50, height_px_s 50, margin2_s 5 5, backgroundColor_s "#EEEEEE", onClick (KeyChar x) ] [ text (x |> String.fromChar |> String.toUpper) ])
                        )
                    , div []
                        ([ 'q', 'r', 's', 't' ]
                            |> List.map (\x -> button [ fontSize_percent_s 150, width_px_s 50, height_px_s 50, margin2_s 5 5, backgroundColor_s "#EEEEEE", onClick (KeyChar x) ] [ text (x |> String.fromChar |> String.toUpper) ])
                        )
                    , div []
                        ([ 'u', 'v', 'w', 'x', 'y', 'z' ]
                            |> List.map (\x -> button [ fontSize_percent_s 150, width_px_s 50, height_px_s 50, margin2_s 5 5, backgroundColor_s "#EEEEEE", onClick (KeyChar x) ] [ text (x |> String.fromChar |> String.toUpper) ])
                        )
                    ]
                , p [ fontSize_percent_s 100 ] [ text model.response ]
                , p [ fontSize_percent_s 100 ] [ text ("Previous guess: " ++ (model.userGuesses |> List.reverse |> printUpperCharList)) ]
                , p [ fontSize_percent_s 100 ] [ text ("You have " ++ (model.numTries |> toString) ++ " chance(s) remaining.") ]
                , p [ fontSize_percent_s 100 ] [ text model.gameState ]
                , p [] [ button [ onClick Roll, fontSize_percent_s 100 ] [ text "NEW GAME" ] ]
                ]
            ]
        ]
