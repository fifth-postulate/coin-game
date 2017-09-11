module Game.Model exposing (Model, create, Player(..), other)


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
    { position : List Coin
    , currentPlayer : Player
    }


create : List Coin -> Model
create position =
    { position = position, currentPlayer = PlayerA }


finished : Model -> Bool
finished model =
    List.all isZero model.position


isZero : Int -> Bool
isZero n =
    n == 0
