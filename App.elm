import Html                 exposing (Html, div)
import Html.Attributes      exposing (style)
import Html.App             as App
import Chess.Board          exposing (Board, Square, startingBoard, selectSquare)
import Chess.Piece          exposing (Piece)
import Chess.View.HtmlBoard exposing (showBoard, showNotif)
import Chess.Events         exposing (..)

main =
  App.program { init = (startingBoard, Cmd.none), view = view, update = update, subscriptions = \_ -> Sub.none  }


view : Board -> Html Message
view board =
  div [style [("display", "flex")]] [
    showBoard board,
    showNotif board
  ]

update: Message -> Board -> (Board, Cmd Message)
update msg board =
  case msg of
    Select piece -> (selectSquare piece.col piece.row board, Cmd.none)
    MoveTo square -> (board, Cmd.none)
