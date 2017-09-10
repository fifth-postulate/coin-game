module Main exposing (..)

import Html
import Game.Model as GameModel
import Game.View as GameView
import Game.Update as GameUpdate
import Message exposing (Message)


main : Program Never Model Message
main =
    Html.program
        { init = ( model, Cmd.none )
        , view = .game >> GameView.view
        , update = update
        , subscriptions = subscriptions
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


update : Message -> Model -> ( Model, Cmd Message )
update message model =
    case message of
        Message.Play action ->
            let
                result =
                    GameUpdate.update action model.game
            in
                case result of
                    Ok nextGame ->
                        noSideEffect { model | game = nextGame, error = Nothing }

                    Err error ->
                        noSideEffect { model | error = Just error }


noSideEffect : Model -> ( Model, Cmd Message )
noSideEffect model =
    ( model, Cmd.none )


subscriptions : Model -> Sub msg
subscriptions _ =
    Sub.none
