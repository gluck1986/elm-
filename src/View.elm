module View exposing (buildButton, buildMassColorInput, buildPosInput, view)

import Gravity exposing (Object)
import Html exposing (Attribute, Html, button, div, input, label, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import Model exposing (..)
import Scene exposing (..)


view : Model -> Html Msg
view model =
    div []
        [ div [ Html.Attributes.style "float" " left" ]
            ([]
                ++ List.indexedMap buildPosInput model.scene
                |> List.concat
            )
        , div [ Html.Attributes.style "float" " left" ]
            ([]
                ++ List.indexedMap buildMassColorInput model.scene
                |> List.concat
            )
        , div [ Html.Attributes.style "clear" "both" ] []
        , buildButton model.status
        , div
            []
            [ Scene.build_scene model ]
        ]


buildButton : Status -> Html Msg
buildButton status =
    case status of
        Play ->
            button [ onClick (SwitchStatus Stop) ] [ text "Stop" ]

        Stop ->
            button [ onClick (SwitchStatus Play) ] [ text "Play" ]


buildPosInput : Int -> Object -> List (Html Msg)
buildPosInput index object =
    [ div [ Html.Attributes.style "width" " 10px", Html.Attributes.style "height" "10px", Html.Attributes.style "background-color" object.color ] []
    , label []
        [ Html.text "x"
        , input
            [ Html.Attributes.class "form-control"
            , value (String.fromFloat object.pos.x)
            , onInput (EditPosX index)
            ]
            []
        ]
    , label []
        [ Html.text "y"
        , input
            [ Html.Attributes.class "form-control"
            , value (String.fromFloat object.pos.y)
            , onInput (EditPosY index)
            ]
            []
        ]
    , Html.hr [] []
    ]


buildMassColorInput : Int -> Object -> List (Html Msg)
buildMassColorInput index object =
    [ div [ Html.Attributes.style "width" " 10px", Html.Attributes.style "height" "10px", Html.Attributes.style "background-color" object.color ] []
    , label []
        [ Html.text "mass"
        , input
            [ Html.Attributes.class "form-control"
            , value (String.fromFloat object.mass)
            , onInput (EditMass index)
            ]
            []
        ]
    , label []
        [ Html.text "color"
        , input
            [ Html.Attributes.class "form-control"
            , value object.color
            ]
            []
        ]
    , Html.hr [] []
    ]
