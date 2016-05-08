import Html exposing (div, button, text, table, tr, td)
import Html.Events exposing (onClick)
import Html.Attributes exposing (..)
import StartApp.Simple as StartApp
import Chess.Board exposing (..)

main =
  StartApp.start { model = chessBoard, view = view, update = update }


chessBoard : Board
chessBoard = startingBoard

view address model =
    showBoard model

type Action = Increment | Decrement


update action model =
    model