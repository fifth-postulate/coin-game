module Main exposing (..)

import Html
import Game.Model as GameModel
import Game.View as GameView
import Game.Update as GameUpdate


main : Program Never Model GameUpdate.Action
main =
    Html.beginnerProgram
        { model = model
        , view = .game >> GameView.view
        , update = update
        }


type alias Model =
    { game : GameModel.Model
    , error : Maybe GameUpdate.Error
    }


model : Model
model =
    { game = GameModel.create [ 2, 3, 4 ]
    , error = Nothing
    }


update : GameUpdate.Action -> Model -> Model
update action model =
    let
        result =
            GameUpdate.update action model.game
    in
        case result of
            Ok nextGame ->
                { model | game = nextGame, error = Nothing }

            Err error ->
                { model | error = Just error }
