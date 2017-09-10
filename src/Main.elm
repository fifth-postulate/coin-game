module Main exposing (..)

import Html
import Game.Model as GameModel


main : Program Never Model msg
main =
    Html.beginnerProgram
        { model = model
        , view = view
        , update = update
        }


type alias Model =
    GameModel.Model


model : Model
model =
    GameModel.create [ 2, 3, 4 ]


view : Model -> Html.Html msg
view _ =
    Html.text "Hello, World!"


update : msg -> Model -> Model
update _ model =
    model
