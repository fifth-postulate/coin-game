module Game.Model exposing (Model, Action(..), Error, create, update)


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


type Action
    = Play Int Int


type Error
    = NonExistingRow
    | NonPositiveCoins
    | ToManyCoins


update : Model -> Action -> Result Error Model
update model action =
    case action of
        Play row coins ->
            if coins <= 0 then
                Err NonPositiveCoins
            else
                case model.rows @ row of
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
                                case replace model.rows row remainingCoins of
                                    Just nextRows ->
                                        Ok { model | currentPlayer = nextPlayer }

                                    Nothing ->
                                        Err NonExistingRow


(@) : List a -> Int -> Maybe a
(@) list index =
    if index <= 0 then
        List.head list
    else
        case List.tail list of
            Just tail ->
                (@) tail (index - 1)

            Nothing ->
                Nothing
infixr 9 @


replace : List a -> Int -> a -> Maybe (List a)
replace list index element =
    if 0 <= index && index < List.length list then
        Just
            ((List.take index list)
                ++ [ element ]
                ++ (List.drop (index + 1) list)
            )
    else
        Nothing
