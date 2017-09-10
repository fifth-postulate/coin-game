module Helper exposing ((@), replace)


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
