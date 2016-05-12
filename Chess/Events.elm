module Chess.Events exposing (..)

import Chess.Piece  exposing (Piece)
import Chess.Board  exposing (Square)

type Message = Select Piece | MoveTo Square
