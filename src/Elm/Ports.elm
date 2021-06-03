port module Elm.Ports exposing (..)

import Elm.Model exposing (BibleGateway)



--Ports allow communication between Elm and JavaScript.
--Ports are probably most commonly used for WebSockets and localStorage.
--Outgoing Messages (Cmd)
--Incoming Messages (Sub)


port getBibleGateway : BibleGateway -> Cmd msg


port recieveBibleGateway : ({ heading : String, passage : String } -> msg) -> Sub msg
