module Game.Model exposing (Model, create, Player(..), other, finished, GameType(..))


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


type GameType
    = Normal
    | Misere


type alias Coin =
    Int


type alias Model =
    { position : List Coin
    , currentPlayer : Player
    , gameType: GameType
    }


create : List Coin -> GameType -> Model
create position gameType =
    { position = position, currentPlayer = PlayerA, gameType = gameType }


finished : Model -> Bool
finished model =
    List.all isZero model.position


isZero : Int -> Bool
isZero n =
    n == 0
