module Game.View exposing (view)

import Html
import Html.Attributes as Attribute
import Html.Events as Event
import Game.Model exposing (Model)
import Game.Update as GameUpdate exposing (Action)


view : Model -> Html.Html Action
view model =
    let
        htmlRows =
            List.indexedMap viewRow model.rows
    in
        Html.div [ Attribute.class "game" ] htmlRows


viewRow : Int -> Int -> Html.Html Action
viewRow row coinsInRow =
    let
        coins =
            List.range 1 coinsInRow

        htmlCoins =
            List.map (viewCoin (GameUpdate.Play row)) coins
    in
        Html.div [ Attribute.class "row" ] htmlCoins


viewCoin : (Int -> Action) -> Int -> Html.Html Action
viewCoin play amount =
    let
        action =
            play amount
    in
        Html.div [ Attribute.class "coin", Event.onClick action ] []
