module Elm.Subscriptions exposing (..)

import Elm.Messages exposing (Msg(..))
import Elm.Model exposing (Model)
import Elm.Ports exposing (..)


subscriptions : Model -> Sub Msg
subscriptions _ =
    recieveBibleGateway messageDecoder


messageDecoder : { heading : String, passage : String } -> Msg
messageDecoder result =
    MyMsg result
