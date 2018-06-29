module App exposing (..)

-- Read more about this program in the official Elm guide:
-- https://guide.elm-lang.org/architecture/user_input/buttons.html

import Html exposing (..)
import Html.Attributes exposing (class, src, style)
import Html.Events exposing (onClick)
import Random
import Style exposing (..)
import Window exposing (..)


jumbo =
    div []
        [ span [ fontSize_s 120, pad2_s 16 0, italic_s, bold_s, maxWidth_s 700 ]
            [ "SKI" |> text ]
        , span [ fontSize_s 60, pad2_s 1 0, bold_s ]
            [ " Coding" |> text ]

        --, div [ size 26 8 ] [ text "Coding lessons for kids" ]
        , h4 [ pad2_s 8 0 ]
            [ text "Learn coding through Primary School Math!" ]
        , br [] []

        --, getStarted
        ]


introduction =
    div [ width_s 80, arial_s, maxWidth_s 700 ]
        [ h1 [] [ "Math-Oriented Coding Lessons..." |> text ]
        , h4 [ left_s ]
            [ "SKI Coding School provides math-oriented coding programs for students aged 10 to 18. Our lesons include semester weekly coding classes and holiday intensive classes." |> text ]
        ]


aboutClass =
    div [ width_s 80, arial_s, left_s, maxWidth_s 700 ]
        [ h1 [ center_s ] [ "...for good Mathematics Students" |> text ]
        , h4 []
            [ "The lessons are designed for students who are well-versed in mathematics, e.g. participated in Math-Olympiad competition, or Secondary School and above." |> text ]
        , h4 []
            [ "This allows us to focus on the computational part of the coding, and to use primary school mathematics to solve real-life problems." |> text ]
        , h4 []
            [ "Parents with primary school kids are encouraged to contact us to schedule an assessment test. A supplement course is available for students that needs extra math background training." |> text
            ]
        ]


aboutTeacher =
    div [ arial_s, width_s 80, maxWidth_s 700 ]
        [ img [ src "/myPhoto.jpg", center_s, style [ "alt" => "INSERT PHOTO HERE", "height" => "200", "width" => "200" ] ] []
        , h2 [] [ "Instructor: Mr. Chang" |> text ]
        , h3 [] [ "M.Sc. (Math), University of Michigan " |> text ]
        , h3 [] [ "B.Sc. (Math, 1st Class Hons), NUS " |> text ]
        , h5 [ left_s ] [ "A passionate mathematics major, Mr. Chang believes that mathematics is a great tool to understand the world." |> text ]
        , h5 [ left_s ] [ "Mr. Chang is passionate in bringing university-level coding skills to young children, to link their primary school math education to real-life problem-solving." |> text ]
        , h5 [ left_s ] [ "Mr. Chang previously taught Calculus in University of Michigan, and taught Math Olympiad to Primary School students in Singapore." |> text ]
        , h5 [ left_s ] [ "He is currently a Financial Engineer at Numerical Technologies, a risk-management software company." |> text ]
        ]


lessonInfo =
    div [ arial_s, width_px_s 400, left_s, maxWidth_s 700 ]
        [ h1 [ center_s ]
            [ "Lesson Info" |> text ]
        , div
            [ pad2_s 10 0 ]
            [ h1 [] [ "1-1 Lessons" |> text ]
            , h4 [] [ "Number of Lessons: 10" |> text ]
            , h4 [] [ "Length of each lesson: 1.5 hr" |> text ]
            , h4 [] [ "Price: S$ 600" |> text ]
            ]
        , h4 [] []
        , h1 [ pad4_s 50 0 0 0 ] [ "Group Lessons" |> text ]
        , h4 [] [ "Details coming soon." |> text ]
        ]


expectedResults =
    div [ arial_s, width_s 80, left_s, maxWidth_s 700 ]
        [ h2 [ center_s ] [ "Solve Complex Problems" |> text ]
        , h3 [] [ "At the end of the program, your kid should be able to answer the following questions using math and computer:" |> text ]
        , ol [ style [ "type" => "1" ], left_s ]
            [ li [ pad2_s 10 0 ] [ "What is the sum of all prime numbers from 2 to 10000?" |> text ]
            , li [ pad2_s 10 0 ] [ "In a shopping list, you are given a list of products, the price for each item, and the quantity bought for each item. What is the total price of all item bought?" |> text ]
            , li [ pad2_s 10 0 ] [ "Starting from the origin, you are given a list of commands (e.g. walk North for 200m, walk SouthEast for 100m, etc.). Calculate the final location." |> text ]
            ]
        ]


contactUs =
    div [ width_s 80, arial_s ]
        [ h1 [ bold_s ] [ "CONTACT US" |> text ]
        , h4 [] [ "Email: codingski (AT) gmail.com" |> text ]
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
    , screenSize : ScreenSize
    }


init : ( Model, Cmd Msg )
init =
    ( { x = 1
      , screenSize = Desktop
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
            let
                screenSize =
                    if j < 400 then
                        Mobile
                    else if j < 700 then
                        Tablet
                    else
                        Desktop
            in
            ( { model | screenSize = screenSize }, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Window.resizes (\qqq -> Resize qqq.height qqq.width)



-- VIEW


view : Model -> Html.Html Msg
view model =
    div []
        [ div [ pad2_s 50 0, style1_s, center_s, width_s 100 ] [ jumbo ]
        , div [ pad2_s 50 0, style2_s, center_s, width_s 100 ] [ introduction ]
        , div [ pad2_s 50 0, style3_s, center_s, width_s 100 ] [ aboutClass ]
        , div [ pad2_s 50 0, style2_s, center_s, width_s 100 ] [ expectedResults ]
        , div [ pad2_s 50 0, style3_s, center_s, width_s 100 ] [ aboutTeacher ]
        , div [ pad2_s 50 0, style2_s, center_s, width_s 100 ] [ lessonInfo ]
        , div [ pad2_s 50 0, style1_s, center_s, width_s 100 ] [ contactUs ]

        {--
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

            --}
        {--div []
            [ h6 [] [ text (toString model.x) ]
            , button [ onClick Roll ] [ text "Roll" ]
            ]
            --}
        ]
