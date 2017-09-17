module Game.View exposing (view)

import Html
import Html.Attributes as Attribute
import Html.Events as Event
import Message exposing (Message)
import Game.Model as GameModel exposing (Model)
import Game.Update as GameUpdate exposing (Action)


view : Model -> Html.Html Message
view model =
    let
        player =
            case model.currentPlayer of
                GameModel.PlayerA ->
                    "Player A"

                GameModel.PlayerB ->
                    "Player B"

        gameType =
            case model.gameType of
                GameModel.Normal ->
                    "normal"

                GameModel.Misere ->
                    "misere"

        htmlPlayer =
            Html.div
                [ Attribute.classList
                    [ ( "current-player", True )
                    , ( gameType, True )
                    , ( "finished", GameModel.finished model )
                    ]
                ]
                [ Html.text player ]

        htmlPosition =
            List.indexedMap viewRow model.position

        content =
            htmlPosition ++ [ htmlPlayer ]
    in
        Html.div [ Attribute.class "game" ] content


viewRow : Int -> Int -> Html.Html Message
viewRow row coinsInRow =
    let
        coins =
            List.reverse (List.range 1 coinsInRow)

        htmlCoins =
            List.map (viewCoin (GameUpdate.Play row)) coins
    in
        Html.div [ Attribute.class "row" ] htmlCoins


viewCoin : (Int -> Action) -> Int -> Html.Html Message
viewCoin play amount =
    let
        action =
            Message.Play (play amount)
    in
        Html.div [ Attribute.class "coin", Event.onClick action ] []
