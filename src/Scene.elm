module Scene exposing (build_scene)

import Gravity exposing (Object)
import Html exposing (Html)
import Model exposing (..)
import Svg exposing (..)
import Svg.Attributes exposing (..)


build_scene : Model -> Html Msg
build_scene model =
    svg [ Svg.Attributes.width "512", Svg.Attributes.height "512", Svg.Attributes.viewBox "0 0 512 512" ]
        (List.map
            buildObject
            model.scene
        )


buildObject : Object -> Svg Msg
buildObject object =
    Svg.circle [ cx (String.fromFloat object.pos.x), cy (String.fromFloat object.pos.y), r "5", Svg.Attributes.fill object.color ] []
