module Game.View exposing (view)

import Html
import Html.Attributes as Attribute
import Game.Model as Model


type alias Model =
    Model.Model


view : Model -> Html.Html msg
view model =
    let
        htmlRows =
            List.map viewRow model.rows
    in
        Html.div [ Attribute.class "game" ] htmlRows


viewRow : Int -> Html.Html msg
viewRow coinsInRow =
    let
        htmlCoin =
            Html.div [ Attribute.class "coin" ] [ Html.text "c" ]

        htmlCoins =
            List.repeat coinsInRow htmlCoin
    in
        Html.div [ Attribute.class "row" ] htmlCoins
