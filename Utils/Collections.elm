module Utils.Collections exposing (..)

import List exposing (map, take, drop, head)

type alias Predicate a = a -> Bool

updateIf : Predicate a -> (a -> a) -> (a -> a) -> a -> a
updateIf find matchTransform dontMatchTransform item =
  case find item of
    True -> matchTransform item
    False -> dontMatchTransform item

updateWhere : Predicate a -> (a -> a) -> (a -> a) -> List a -> List a
updateWhere find matchTransform dontMatchTransform list =
  map (updateIf find matchTransform dontMatchTransform) list

updateListWhere : Predicate a -> (a -> a) -> (a -> a) -> List (List a) -> List (List a)
updateListWhere find matchTransform dontMatchTransform list =
  let
    updates = \items -> map (updateIf find matchTransform dontMatchTransform) items
  in
  map updates list


getAt : Int -> List a -> Maybe a
getAt idx list =
  head (take idx (drop idx list))
