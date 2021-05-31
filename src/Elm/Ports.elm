port module Elm.Ports exposing (..)

import Elm.Model exposing (BibleGateway)


port getBibleGateway : BibleGateway -> Cmd msg


port recieveBibleGateway : ({ heading : String, passage : String } -> msg) -> Sub msg
