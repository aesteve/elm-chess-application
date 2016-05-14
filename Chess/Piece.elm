module Chess.Piece exposing (..)

import Chess.Color exposing (Color)
import List        exposing (map)

type Figure = Rook | Knight | Bishop | Queen | King | Pawn

type alias Piece = {figure: Figure, color: Color}

moves : Figure -> Int -> Int -> List (Int, Int)
moves figure col row =
  case figure of
    Rook -> map (\i -> (i, row)) [1..8]
    _ -> []
