module Main exposing (main)

import Browser
import Gravity exposing (..)
import Model exposing (..)
import Task
import Time
import Update
import View


main =
    Browser.element { init = init, subscriptions = subscriptions, update = Update.update, view = View.view }


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model Stop
        [ Object "#EFEF09" (Vector 250 210) (Vector -0.002 0) (Vector 0 0) 400000000
        , Object "#EF09EF" (Vector 200 250) (Vector 0 0) (Vector 0 0) 500000000
        , Object "#09EFEF" (Vector 240 300) (Vector 0 0) (Vector 0 0) 500000000
        ]
        Time.utc
    , Task.perform AdjustTimeZone Time.here
    )


subscriptions : Model -> Sub Msg
subscriptions model =
    case model.status of
        Play ->
            Time.every 10 Tick

        Stop ->
            Sub.none
