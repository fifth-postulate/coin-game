module Main exposing (..)

import Html
import Game.Model as GameModel
import Game.View as GameView


main : Program Never Model msg
main =
    Html.beginnerProgram
        { model = model
        , view = GameView.view
        , update = update
        }


type alias Model =
    GameModel.Model


model : Model
model =
    GameModel.create [ 2, 3, 4 ]


update : msg -> Model -> Model
update _ model =
    model
