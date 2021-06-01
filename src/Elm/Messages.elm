module Elm.Messages exposing (..)

import Elm.Model exposing (Model)
import Elm.Ports exposing (..)


type Msg
    = NoOp
      --| BibleGatewaySearch
      --| SearchPassage String
    | BibleGateway BibleGatewayMsg
    | MainPoint MainPointMsg
      -- | ChangeMainPoint String
      -- | AddMainPoint
    | MyMsg { heading : String, passage : String }


type BibleGatewayMsg
    = BibleGatewaySearch
    | SearchPassage String


type MainPointMsg
    = ChangeMainPoint String
    | AddMainPoint


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        BibleGateway bMsg ->
            case bMsg of
                BibleGatewaySearch ->
                    ( model, getBibleGateway model.bibleGateway )

                SearchPassage passage ->
                    ( { model
                        | bibleGateway =
                            { url = model.bibleGateway.url
                            , passage = passage
                            , version = model.bibleGateway.version
                            , result = model.bibleGateway.result
                            }
                      }
                    , Cmd.none
                    )

        MainPoint mMsg ->
            case mMsg of
                ChangeMainPoint point ->
                    ( { model
                        | mainPoints =
                            model.mainPoints
                                |> (\mp -> { mp | point = point })
                      }
                    , Cmd.none
                    )

                AddMainPoint ->
                    ( { model
                        | mainPoints =
                            model.mainPoints
                                |> (\ps -> { ps | points = ps.point :: ps.points })
                      }
                    , Cmd.none
                    )

        MyMsg result ->
            ( { model
                | bibleGateway =
                    { url = model.bibleGateway.url
                    , passage = model.bibleGateway.passage
                    , version = model.bibleGateway.version
                    , result = List.append model.bibleGateway.result [ ( result.heading, result.passage ) ]
                    }
              }
            , Cmd.none
            )

        _ ->
            ( model, Cmd.none )
