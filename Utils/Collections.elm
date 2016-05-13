module Utils.Collections exposing (..)

import List exposing (map)

updateWhere : List a -> (a -> Bool) -> (a -> a) -> List a
updateWhere list finder transform =
  let
    update item =
      case finder item of
        True -> transform item
        False -> item
  in
  map update list
