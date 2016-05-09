module Chess.Piece where

import Chess.Color exposing (Color)

type Figure = Rook | Knight | Bishop | Queen | King | Pawn

type alias Piece = {figure: Figure, color: Color}