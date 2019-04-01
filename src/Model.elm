module Model exposing (Model, Msg(..), ObjIndex, Status(..))

import Gravity exposing (Object)
import Time


type Status
    = Stop
    | Play


type alias ObjIndex =
    Int


type alias Model =
    { status : Status
    , scene : List Object
    , zone : Time.Zone
    }


type Msg
    = EditMass ObjIndex String
    | EditPosX ObjIndex String
    | EditPosY ObjIndex String
    | Tick Time.Posix
    | AdjustTimeZone Time.Zone
    | SwitchStatus Status
