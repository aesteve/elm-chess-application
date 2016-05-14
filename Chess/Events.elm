module Chess.Events exposing (..)

import Chess.Board  exposing (Square)

type Message = Select Square | MoveTo Square
