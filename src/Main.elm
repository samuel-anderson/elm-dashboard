module Main exposing (..)

import Browser
import Elm.Messages exposing (Msg, update)
import Elm.Model exposing (Model)
import Elm.Subscriptions exposing (subscriptions)
import Elm.View exposing (view)


init : ( Model, Cmd Msg )
init =
    ( { search = ""
      , bibleGateway =
            { url = "https://www.biblegateway.com/passage/"
            , passage = ""
            , version = "NIV"
            , result = []
            }
      , mainPoints =
            { point = ""
            , points = []
            }
      }
    , Cmd.none
    )



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = subscriptions
        }
