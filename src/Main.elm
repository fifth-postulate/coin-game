port module Main exposing (..)

import Html
import Game.Model as GameModel
import Game.View as GameView
import Game.Update as GameUpdate
import Message exposing (Message)


main : Program Never Model Message
main =
    Html.program
        { init = (init [ 2, 3, 4 ] GameModel.Misere)
        , view = .game >> GameView.view
        , update = update
        , subscriptions = subscriptions
        }


type alias Model =
    { game : GameModel.Model
    , gameType : GameModel.GameType
    , error : Maybe GameUpdate.Error
    }


init : List Int -> GameModel.GameType -> ( Model, Cmd Message )
init position gameType =
    noSideEffect
        { game = GameModel.create position gameType
        , gameType = gameType
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

        Message.Reset position ->
            init position model.gameType

        Message.Type description ->
            let
                gameType =
                    case String.toLower description of
                        "misere" ->
                            GameModel.Misere

                        _ ->
                            GameModel.Normal

                position =
                    model.game.position
            in
                init position gameType


noSideEffect : Model -> ( Model, Cmd Message )
noSideEffect model =
    ( model, Cmd.none )


port reset : (List Int -> msg) -> Sub msg


port changeType : (String -> msg) -> Sub msg


subscriptions : Model -> Sub Message
subscriptions _ =
    Sub.batch
        [ reset Message.Reset
        , changeType Message.Type
        ]
