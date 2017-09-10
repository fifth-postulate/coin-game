module Game.Model exposing (Model, create, Player, other)


type Player
    = PlayerA
    | PlayerB


other : Player -> Player
other player =
    case player of
        PlayerA ->
            PlayerB

        PlayerB ->
            PlayerA


type alias Coin =
    Int


type alias Model =
    { rows : List Coin
    , currentPlayer : Player
    }


create : List Coin -> Model
create rows =
    { rows = rows, currentPlayer = PlayerA }
