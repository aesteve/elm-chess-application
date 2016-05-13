module Utils.Collections exposing (..)

import List exposing (map)

updateWhere : List a -> (a -> Bool) -> (a -> a) -> List a
updateWhere list find transform =
  let
    update item =
      case find item of
        True -> transform item
        False -> item
  in
  map update list
