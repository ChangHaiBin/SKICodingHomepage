module SKICoding exposing (..)

-- Read more about this program in the official Elm guide:
-- https://guide.elm-lang.org/architecture/user_input/buttons.html

import Html exposing (..)
import Html.Attributes exposing (class, src, style)
import Html.Events exposing (onClick)
import Random
import Style exposing (..)
import Task exposing (perform)
import Window exposing (..)


style1 =
    style
        [ "display" => "inline-block"
        , "color" => "white"
        , "text-align" => "center"
        , "padding" => "14px 16px"
        , "text-decoration" => "none"
        ]


topLine =
    ul [ style [ "list-style-type" => "none", "margin" => "0", "padding" => "0", "overflow" => "hidden" ] ]
        [ li [ style1 ] [ "ASDF" |> text ]
        , li [ style1 ] [ "1234" |> text ]
        , li [ style1 ] [ "PPPPPP" |> text ]
        , li [ style1 ] [ "KKKK" |> text ]
        ]



{--
        div
        [ pad2_s 0 0, style1_s, width_s 100, style [ "backgroundColor" => "#AAAAAA" ], arial_s, left_s, pad4_s 20 0 20 0 ]
        [ span [ italic_s, bold_s, fontSize_percent_s 200, style [ "width" => "20%" ], floatLeft_s, pad2_s 20 20 ] [ "SKI " |> text ]
        , span [ floatRight_s, style [ "width" => "20%", "clear" => "left" ], pad2_s 20 20 ] [ "LINK2" |> text ]
        ]
        --}


jumbo =
    div [ arial_s, center_s, style [ "clear" => "right" ] ]
        [ span [ fontSize_percent_s 700, pad2_s 16 0, italic_s, bold_s, maxWidth_s 700 ]
            [ "SKI" |> text ]
        , span [ fontSize_percent_s 300, pad2_s 1 0, bold_s ]
            [ " Coding" |> text ]

        --, div [ size 26 8 ] [ text "Coding lessons for kids" ]
        , p [ fontSize_percent_s 100, pad2_s 8 0 ]
            [ text "Learn coding through Primary School Math!" ]
        , br [] []

        --, getStarted
        ]


introduction =
    div [ width_s 80, arial_s, maxWidth_s 700 ]
        [ h2 [ fontSize_percent_s 200, bold_s ] [ "Math-Oriented Coding Lessons..." |> text ]
        , p [ left_s, pad2_s 20 0 ]
            [ "SKI Coding School provides math-oriented coding programs for students aged 10 to 18. Our lesons include semester weekly coding classes and holiday intensive classes." |> text ]
        ]


aboutClass =
    div [ width_s 80, arial_s, left_s, maxWidth_s 700, fontSize_s 16 ]
        [ h2 [ fontSize_percent_s 200, center_s, pad2_s 10 0 ] [ "...for good Mathematics Students" |> text ]
        , p []
            [ "The lessons are designed for students who are well-versed in mathematics, e.g. participated in Math-Olympiad competition, or Secondary School and above." |> text ]
        , p []
            [ "This allows us to focus on the computational part of the coding, and to use primary school mathematics to solve real-life problems." |> text ]
        , p []
            [ "Parents with primary school kids are encouraged to contact us to schedule an assessment test. A supplement course is available for students that needs extra math background training." |> text
            ]
        ]


aboutTeacher =
    div [ arial_s, width_s 80, maxWidth_s 700, fontSize_s 16, left_s ]
        [ img [ src "myPhoto.jpg", center_s, style [ "alt" => "INSERT PHOTO HERE", "height" => "200", "width" => "200" ] ] []
        , h2 [ fontSize_s 36, bold_s ] [ "Instructor: Mr. Chang" |> text ]
        , h2 [ fontSize_s 28, bold_s ] [ "M.Sc. (Math), University of Michigan " |> text ]
        , h2 [ fontSize_s 28, bold_s ] [ "B.Sc. (Math, 1st Class Hons), NUS " |> text ]
        , p [ left_s ] [ "A passionate mathematics major, Mr. Chang believes that mathematics is a great tool to understand the world." |> text ]
        , p [ left_s ] [ "Mr. Chang's goal is to bring university-level coding skills to young children, to link their primary school math education to real-life problem-solving." |> text ]
        , p [ left_s ] [ "Mr. Chang previously taught Calculus in University of Michigan, and taught Math Olympiad to Primary School students in Singapore." |> text ]
        , p [ left_s ] [ "He is currently a Financial Engineer at Numerical Technologies, a risk-management software company." |> text ]
        ]


lessonInfo =
    div [ arial_s, width_s 80, left_s, maxWidth_s 700 ]
        [ h2 [ left_s, fontSize_s 36 ]
            [ "Lesson Info" |> text ]
        , div
            [ pad2_s 10 0, fontSize_s 16 ]
            [ h3 [ fontSize_s 28 ] [ "1-1 Lessons" |> text ]
            , p [] [ "Number of Lessons: 10" |> text ]
            , p [] [ "Length of each lesson: 1.5 hr" |> text ]
            , p [] [ "Price: S$ 600" |> text ]
            ]
        , p [] []
        , h3 [ pad4_s 50 0 0 0 ] [ "Group Lessons" |> text ]
        , p [] [ "Details coming soon." |> text ]
        ]


expectedResults =
    div [ arial_s, width_s 80, left_s, maxWidth_s 700 ]
        [ h2 [ center_s, fontSize_s 36 ] [ "Solve Complex Problems" |> text ]
        , p [ fontSize_s 16 ] [ "At the end of the program, your kid should be able to answer the following questions using math and computer:" |> text ]
        , ol [ style [ "type" => "1" ], left_s, fontSize_s 16 ]
            [ li [ pad2_s 10 0 ] [ "What is the sum of all prime numbers from 2 to 10000?" |> text ]
            , li [ pad2_s 10 0 ] [ "In a shopping list, you are given a list of products, the price for each item, and the quantity bought for each item. What is the total price of all item bought?" |> text ]
            , li [ pad2_s 10 0 ] [ "Starting from the origin, you are given a list of commands (e.g. walk North for 200m, walk SouthEast for 100m, etc.). Calculate the final location." |> text ]
            ]
        ]


contactUs =
    div [ width_s 80, arial_s, left_s, maxWidth_s 700 ]
        [ h1 [ bold_s ] [ "CONTACT US" |> text ]
        , h4 [] [ "Email: skicodingschool (AT) gmail.com" |> text ]
        , h4 [] [ "Phone/Whatsapp: +65 9821 1538" |> text ]
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


type ScreenSize
    = Mobile
    | Tablet
    | Desktop


type alias Model =
    { x : Int
    , i : Int
    , j : Int
    , screenSize : ScreenSize
    }


initialSizeCmd =
    Task.map2 (\i j -> ( i, j )) Window.height Window.width
        |> Task.perform (\( i, j ) -> Resize i j)


init : ( Model, Cmd Msg )
init =
    ( { x = 1
      , i = 0
      , j = 0
      , screenSize = Desktop
      }
    , initialSizeCmd
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
            let
                screenSize =
                    if j < 400 then
                        Mobile
                    else if j < 700 then
                        Tablet
                    else
                        Desktop
            in
            ( { model | screenSize = screenSize, i = i, j = j }, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Window.resizes (\qqq -> Resize qqq.height qqq.width)



-- VIEW


view : Model -> Html.Html Msg
view model =
    div [ fontSize_percent_s 100 ]
        [ div [ pad2_s 50 0, style1_s, center_s, width_s 100 ] [ jumbo ]
        , div [ pad2_s 50 0, style2_s, center_s, width_s 100, fontSize_percent_s 500 ] [ (toString model.i ++ "x" ++ toString model.j) |> text ]
        , div [ pad2_s 50 0, style2_s, center_s, width_s 100 ] [ introduction ]
        , div [ pad2_s 50 0, style3_s, center_s, width_s 100 ] [ aboutClass ]
        , div [ pad2_s 50 0, style2_s, center_s, width_s 100 ] [ expectedResults ]
        , div [ pad2_s 50 0, style3_s, center_s, width_s 100 ] [ aboutTeacher ]
        , div [ pad2_s 50 0, style2_s, center_s, width_s 100 ] [ lessonInfo ]
        , div [ pad2_s 50 0, style1_s, center_s, width_s 100 ] [ contactUs ]

        {--

        h6 [ center_s ] [ (toString model.i ++ "x" ++ toString model.j) |> text ]
        , h6 [ center_s ]
            [ (case model.screenSize of
                Mobile ->
                    "MOBILE"

                Tablet ->
                    "TABLET"

                Desktop ->
                    "DESKTOP"
              )
                |> text
            ]
        , div []
            [ h6 [] [ text (toString model.x) ]
            , button [ onClick Roll ] [ text "Roll" ]
            ]
            --}
        ]
