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


type alias Model =
    { answer2 : String
    , response : String
    , userInput : String
    , userGuesses : List Char
    , numTries : Int
    }


init : ( Model, Cmd Msg )
init =
    ( { answer2 = "PlaceHolder"
      , response = "PlaceHolder."
      , userInput = ""
      , userGuesses = []
      , numTries = 6
      }
    , Random.generate NewWord (Random.int 0 ((wordList |> List.length) - 1))
    )



-- UPDATE


type Msg
    = Roll
    | CheckAnswer String
    | UpdateUserInput String
    | NewWord Int
    | KeyMsg Keyboard.KeyCode


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Roll ->
            let
                wordLength =
                    wordList |> List.length
            in
            ( model, Random.generate NewWord (Random.int 0 (wordLength - 1)) )

        KeyMsg keyCode ->
            let
                asdf =
                    keyCode |> Char.fromCode

                a =
                    1.0
            in
            if keyCode == 20 then
                ( model, Cmd.none )
            else
                ( model
                , Cmd.none
                )

        UpdateUserInput userInput ->
            ( { model
                | userInput = userInput
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
                | answer2 = selectedWord
                , response = "New Game. " ++ (selectedWord |> String.length |> numToString) ++ "letter word has been chosen."
                , userGuesses = []
                , numTries = 6
              }
            , Cmd.none
            )

        CheckAnswer guessWord ->
            let
                exactlyOne errorMessage xs =
                    case xs of
                        [ x ] ->
                            Result.Ok x

                        _ ->
                            Result.Err errorMessage

                resultFilter f errorMessage =
                    Result.andThen
                        (\y ->
                            if f y then
                                Result.Ok y
                            else
                                Result.Err errorMessage
                        )

                resultFilterCase f errorMessageFunc =
                    Result.andThen
                        (\y ->
                            if f y then
                                Result.Ok y
                            else
                                Result.Err (errorMessageFunc y)
                        )

                ( response2, newNumTries, newUserGuesses ) =
                    model.userInput
                        |> String.toLower
                        |> String.toList
                        |> exactlyOne ( "Please input one-character only.", model.numTries, model.userGuesses )
                        |> resultFilter (\x -> 'a' <= x && x <= 'z') ( "Please input a character between A to Z.", model.numTries, model.userGuesses )
                        |> resultFilterCase (\x -> model.userGuesses |> List.all ((/=) x)) (\x -> ( "You have already guessed the letter " ++ (x |> String.fromChar) ++ ".", model.numTries, model.userGuesses ))
                        |> Result.map
                            (\x ->
                                if model.answer2 |> String.contains (x |> String.fromChar) then
                                    ( "The answer contains the letter " ++ (x |> String.fromChar |> String.toUpper)
                                    , model.numTries
                                    , x :: model.userGuesses
                                    )
                                else
                                    ( "The answer does not contain the letter " ++ (x |> String.fromChar |> String.toUpper)
                                    , model.numTries - 1
                                    , x :: model.userGuesses
                                    )
                            )
                        |> combineResult

                response3 =
                    if
                        model.answer2
                            |> String.toList
                            |> List.all (\x -> newUserGuesses |> List.any ((==) x))
                    then
                        "The correct answer is " ++ (model.answer2 |> String.toUpper) ++ ". You win!"
                    else if newNumTries == 0 then
                        "The correct answer is " ++ (model.answer2 |> String.toUpper) ++ ". You lose!"
                    else
                        response2
            in
            ( { model
                | response = response3
                , numTries = newNumTries
                , userGuesses = newUserGuesses
              }
            , Cmd.none
            )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Keyboard.downs KeyMsg
        ]



-- Window.resizes (\qqq -> Resize qqq.height qqq.width)
-- VIEW


view : Model -> Html.Html Msg
view model =
    div [ fontSize_percent_s 200 ]
        [ div [ pad2_s 50 0, style10_s, center_s, width_s 100 ]
            [ div [ arial_s, center_s, style [ "clear" => "right" ] ]
                [ span [ fontSize_percent_s 100, pad2_s 16 0, bold_s, maxWidth_s 700 ]
                    [ "Word Guessing Game (HangMan)" |> text ]
                , p [] [ "This game only works on Desktop, not Mobile" |> text ]

                --, div [ size 26 8 ] [ text "Coding lessons for kids" ]
                , p [ fontSize_percent_s 100, pad2_s 8 0 ]
                    [ text "Guess any letter from A to Z" ]
                , p []
                    [ model.answer2
                        |> String.toList
                        |> List.map
                            (\x ->
                                if model.userGuesses |> List.any ((==) x) then
                                    x
                                else
                                    '_'
                            )
                        |> List.map String.fromChar
                        |> List.foldl (\y x -> x ++ " " ++ y) ""
                        |> String.toUpper
                        |> text
                    ]
                , p []
                    [ input
                        [ placeholder "Input"
                        , onInput UpdateUserInput
                        ]
                        []
                    , button [ onClick (CheckAnswer model.userInput) ] [ text "GUESS" ]
                    ]
                , p [] [ text model.response ]
                , p [] [ text ("You have already guessed: " ++ (model.userGuesses |> List.map (String.fromChar >> String.toUpper) |> List.foldl (\x y -> x ++ " " ++ y) "")) ]
                , p [] [ text ("You have " ++ (model.numTries |> toString) ++ " chance(s) remaining.") ]
                , p []
                    [ button [ onClick Roll ] [ text "NEW GAME" ]
                    ]
                ]
            ]
        ]
