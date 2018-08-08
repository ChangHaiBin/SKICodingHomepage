module Style exposing (..)

import Html.Attributes exposing (style)


(=>) a b =
    ( a, b )


style1_s =
    style
        [ "backgroundColor" => "#3498DB"
        , "color" => "#FFFFFF"
        , "font-family" => "Arial"
        ]


style2_s =
    style
        [ "backgroundColor" => "#DDDDDD"
        , "color" => "#444444"
        , "font-family" => "Arial"
        ]


style3_s =
    style
        [ "backgroundColor" => "#99DDDD"
        , "color" => "#444444"
        , "font-family" => "Arial"
        ]


blueBackground_s =
    style [ "backgroundColor" => "#3498DB" ]



--style [ "backgroundColor" => "#3498DB" ]


greyBackground_s =
    style [ "backgroundColor" => "#DDDDDD" ]


backgroundColor_s x =
    style [ "backgroundColor" => x ]


center_s =
    style [ "text-align" => "center" ]


left_s =
    style [ "text-align" => "left" ]


floatRight_s =
    style [ "float" => "right" ]


floatLeft_s =
    style [ "float" => "left" ]


right_s =
    style [ "text-align" => "right" ]


width_auto_s i =
    style [ "width" => (toString i ++ "%"), "margin-left" => "auto", "margin-right" => "auto" ]


width_px_auto_s i =
    style [ "width" => (toString i ++ "px"), "margin-left" => "auto", "margin-right" => "auto" ]


height_s i =
    style [ "height" => (toString i ++ "%") ]


height_px_s i =
    style [ "height" => (toString i ++ "px") ]


maxWidth_s i =
    style [ "max-width" => (toString i ++ "px") ]


whiteText_s =
    style [ "color" => "white" ]


lightGrey_s =
    style [ "color" => "#DDDDDD" ]


blackText_s =
    style [ "color" => "black" ]


darkGrey_s =
    style [ "color" => "#444444" ]


arial_s =
    style [ "font-family" => "Arial" ]


italic_s =
    style [ "font-style" => "italic" ]


bold_s =
    style [ "font-weight" => "bold" ]


fontSize_percent_s percent =
    style [ "font-size" => (toString percent ++ "%") ]


fontSize_s h =
    style [ "font-size" => (toString h ++ "px") ]


pad1_s each =
    style [ "padding" => (toString each ++ "px") ]


pad2_s tb lr =
    style [ "padding" => (toString tb ++ "px " ++ toString lr ++ "px") ]


pad3_s t lr b =
    style [ "padding" => (toString t ++ "px " ++ toString lr ++ "px " ++ toString b ++ "px") ]


pad4_s t r b l =
    style [ "padding" => (toString t ++ "px " ++ toString r ++ "px " ++ toString b ++ "px " ++ toString l ++ "px") ]


margin1_s each =
    style [ "margin" => (toString each ++ "px") ]


margin2_s tb lr =
    style [ "margin" => (toString tb ++ "px " ++ toString lr ++ "px") ]


margin3_s t lr b =
    style [ "margin" => (toString t ++ "px " ++ toString lr ++ "px " ++ toString b ++ "px") ]


margin4_s t r b l =
    style [ "margin" => (toString t ++ "px " ++ toString r ++ "px " ++ toString b ++ "px " ++ toString l ++ "px") ]


width_s i =
    style [ "width" => (toString i ++ "%") ]


width_px_s i =
    style [ "width" => (toString i ++ "px") ]
