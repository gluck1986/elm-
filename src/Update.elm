module Update exposing (update)

import Gravity exposing (Object, Vector)
import Model exposing (..)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        AdjustTimeZone newZone ->
            ( { model | zone = newZone }
            , Cmd.none
            )

        EditPosX needleIndex x ->
            ( { model
                | scene =
                    List.indexedMap
                        (\index ->
                            \obj ->
                                if index == needleIndex then
                                    { obj | pos = Vector (Maybe.withDefault obj.pos.x (String.toFloat x)) obj.pos.y }

                                else
                                    obj
                        )
                        model.scene
              }
            , Cmd.none
            )

        EditPosY needleIndex y ->
            ( { model
                | scene =
                    List.indexedMap
                        (\index ->
                            \obj ->
                                if index == needleIndex then
                                    { obj | pos = Vector obj.pos.x (Maybe.withDefault obj.pos.y (String.toFloat y)) }

                                else
                                    obj
                        )
                        model.scene
              }
            , Cmd.none
            )

        EditMass needleIndex mass ->
            ( { model
                | scene =
                    List.indexedMap
                        (\index ->
                            \obj ->
                                if index == needleIndex then
                                    { obj | mass = Maybe.withDefault obj.mass (String.toFloat mass) }

                                else
                                    obj
                        )
                        model.scene
              }
            , Cmd.none
            )

        Tick _ ->
            ( { model
                | scene =
                    Gravity.process 10 model.scene
              }
            , Cmd.none
            )

        SwitchStatus status ->
            ( { model | status = status }
            , Cmd.none
            )
