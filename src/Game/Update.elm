module Game.Update exposing (Action(..), Error(..), update)

import Game.Model exposing (Model, Player, other)
import Helper exposing ((@), replace)


type Action
    = Play Int Int


type Error
    = NonExistingRow
    | NonPositiveCoins
    | ToManyCoins


update : Action -> Model -> Result Error Model
update action model =
    case action of
        Play row coins ->
            if coins <= 0 then
                Err NonPositiveCoins
            else
                case model.position @ row of
                    Nothing ->
                        Err NonExistingRow

                    Just coinsInRow ->
                        if coins > coinsInRow then
                            Err ToManyCoins
                        else
                            let
                                nextPlayer =
                                    other model.currentPlayer

                                remainingCoins =
                                    coinsInRow - coins
                            in
                                case replace model.position row remainingCoins of
                                    Just nextPosition ->
                                        Ok { model | position = nextPosition, currentPlayer = nextPlayer }

                                    Nothing ->
                                        Err NonExistingRow
