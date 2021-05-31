module Elm.View exposing (..)

import Bootstrap.Button as Button
import Bootstrap.CDN as CDN
import Bootstrap.Form.Input as Input
import Bootstrap.Form.InputGroup as InputGroup
import Bootstrap.Grid as Grid
import Bootstrap.Table as Table
import Browser.Events exposing (onKeyDown)
import Elm.Messages as Msgs exposing (..)
import Elm.Model exposing (BibleGateway, MainPoints, Model)
import Hotkeys exposing (onEnter, onEnterSend, onKeyCode)
import Html exposing (Html)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)


view : Model -> Html Msg
view model =
    Grid.container []
        [ CDN.stylesheet -- creates an inline style node with the Bootstrap CSS
        , Grid.row []
            [ Grid.col [] (mainPointsColumn model)
            , Grid.col [] (bibleGatewayColumn model)
            ]
        ]


mainPointsColumn : Model -> List (Html Msg)
mainPointsColumn model =
    [ Html.h1 [] [ Html.text "Main Points" ]
    , InputGroup.config
        (InputGroup.text
            [ Input.id "main-points"
            , Input.placeholder "Enter main point..."
            , Input.small
            , Input.onInput ChangeMainPoint
            ]
        )
        |> InputGroup.small
        |> InputGroup.successors
            [ InputGroup.button [ Button.primary, Button.onClick AddMainPoint ] [ Html.text "Add" ] ]
        |> InputGroup.view
    , mainPointsTable model.mainPoints
    ]
        |> List.map (Html.map Msgs.MainPoint)


mainPointsTable : MainPoints -> Html msg
mainPointsTable mPoints =
    Table.table
        { options = []
        , thead =
            Table.thead [ Table.headAttr (style "color" "white") ]
                [ Table.tr []
                    [ Table.th [] [ Html.text "#" ]
                    , Table.th [] [ Html.text "Main Point" ]
                    , Table.th [] [ Html.text "Play/Remove" ]
                    ]
                ]
        , tbody =
            let
                mainPointsList : List String -> List (Table.Row msg)
                mainPointsList l =
                    case l of
                        [] ->
                            []

                        x :: xs ->
                            Table.tr []
                                [ Table.td [] [ Html.text "1" ]
                                , Table.td [] [ Html.text x ]
                                , Table.td [] [ Html.text "Icon" ]
                                ]
                                :: mainPointsList xs
            in
            Table.tbody [ style "color" "white" ] (mainPointsList mPoints.points)
        }


bibleGatewayColumn : Model -> List (Html Msg)
bibleGatewayColumn model =
    [ Html.h1 [] [ Html.text "Bible Gateway" ]
    , InputGroup.config
        (InputGroup.text
            [ Input.id "biblegateway-scripture"
            , Input.placeholder "Enter Bible Gateway scripture..."
            , Input.small
            , Input.onInput SearchPassage
            ]
        )
        |> InputGroup.small
        |> InputGroup.successors
            [ InputGroup.button [ Button.primary, Button.onClick BibleGatewaySearch ] [ Html.text "Search" ] ]
        |> InputGroup.view
    , bibleGatewayTable model.bibleGateway
    ]
        |> List.map (Html.map Msgs.BibleGateway)


bibleGatewayTable : BibleGateway -> Html msg
bibleGatewayTable bibleGateway =
    Table.table
        { options = []
        , thead =
            Table.thead [ Table.headAttr (style "color" "white") ]
                [ Table.tr []
                    [ Table.th [] [ Html.text "#" ]
                    , Table.th [] [ Html.text "Passage" ]
                    , Table.th [] [ Html.text "Play/Remove" ]
                    ]
                ]
        , tbody =
            let
                passageList : List ( String, String ) -> List (Table.Row msg)
                passageList l =
                    case l of
                        [] ->
                            []

                        x :: xs ->
                            Table.tr []
                                [ Table.td [] [ Html.text "1" ]
                                , Table.td [] [ Html.text (Tuple.first x), Html.text " ", Html.text (Tuple.second x) ]
                                , Table.td [] [ Html.text "Icon" ]
                                ]
                                :: passageList xs
            in
            Table.tbody [ style "color" "white" ] (passageList bibleGateway.result)
        }
