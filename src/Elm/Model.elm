module Elm.Model exposing (..)


type alias Model =
    { search : String
    , bibleGateway : BibleGateway
    , mainPoints : MainPoints
    }


type alias BibleGateway =
    { url : String
    , passage : String
    , version : String
    , result : List ( String, String )
    }


type alias MainPoints =
    { point : String
    , points : List String
    }
