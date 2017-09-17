module Message exposing (Message(..))

import Game.Update exposing (Action)


type Message
    = Play Action
    | Reset (List Int)
    | Type String
