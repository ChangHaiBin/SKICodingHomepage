module App exposing (..)

-- Read more about this program in the official Elm guide:
-- https://guide.elm-lang.org/architecture/user_input/buttons.html

import Html exposing (..)
import Html.Attributes exposing (class, style)
import Html.Events exposing (onClick)
import Random
import Window exposing (..)


(=>) a b =
    ( a, b )


blueBackground_s =
    style [ "backgroundColor" => "#3498DB" ]


center_s =
    style [ "text-align" => "center" ]


width_s i =
    style [ "width" => (toString i ++ "%"), "margin-left" => "auto", "margin-right" => "auto" ]


whiteText_s =
    style [ "color" => "white" ]


blackText_s =
    style [ "color" => "black" ]


darkGrey_s =
    style [ "color" => "#777777" ]


arial_s =
    style [ "font-family" => "Arial" ]


italic_s =
    style [ "font-style" => "italic" ]


bold_s =
    style [ "font-weight" => "bold" ]


backgroundStyle =
    style
        [ "text-align" => "center"
        , "padding" => "10px 0px"
        , "width" => "100%"

        --, "margin-left" => "15%"
        --, "margin-right" => "15%"
        ]


size h padding =
    style
        [ "font-size" => (toString h ++ "px")
        , "padding" => (toString padding ++ "px 0")
        ]


jumbo =
    div [ arial_s, whiteText_s ]
        [ span [ size 120 16, italic_s, bold_s ] [ "SKI" |> text ]
        , span [ size 80 1, bold_s ] [ " Coding" |> text ]

        --, div [ size 26 8 ] [ text "Coding lessons for kids" ]
        , div [ size 20 8 ] [ text "Solve computer problem using Primary School Math!" ]
        , br [] []

        --, getStarted
        ]


introduction =
    div []
        [ h3 [ size 14 8, arial_s, darkGrey_s ]
            [ "SKI Coding School provides math-oriented coding programs form students aged 10 to 18. Our lesons include weekly coding classes, holiday intensive course, and Math Olympiad training." |> text ]
        ]



-- Read more about this program in the official Elm guide:
-- https://guide.elm-lang.org/architecture/effects/random.html


main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    { x : Int
    , y : Int
    }


init : ( Model, Cmd Msg )
init =
    ( { x = 1
      , y = 1
      }
    , Cmd.none
    )



-- UPDATE


type Msg
    = Roll
    | NewFace Int
    | Resize Int Int


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Roll ->
            ( model, Random.generate NewFace (Random.int 1 6) )

        NewFace newFace ->
            ( { model | x = newFace }, Cmd.none )

        Resize i j ->
            ( { x = i, y = j }, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Window.resizes (\qqq -> Resize qqq.height qqq.width)



-- VIEW


view : Model -> Html.Html Msg
view model =
    div []
        [ div [ blueBackground_s, center_s, width_s 100 ] [ jumbo ]
        , div [ center_s, width_s 80 ] [ introduction ]
        , div [] [ "ASDF" |> text ]
        , div []
            [ h1 [] [ text (toString model.x ++ "----" ++ toString model.y) ]
            , button [ onClick Roll ] [ text "Roll" ]
            ]
        ]
