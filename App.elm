import Html                 exposing (Html, div)
import Html.Attributes      exposing (style)
import Html.App             as App
import Chess.Board          exposing (Board, Square, startingBoard)
import Chess.Piece          exposing (Piece)
import Chess.View.HtmlBoard exposing (showBoard, showNotif)
import Chess.Events         exposing (..)

main =
  App.program { init = (startingBoard, Cmd.none), view = view, update = update, subscriptions = \_ -> Sub.none  }


view : Board -> Html Message
view model =
  div [style [("display", "flex")]] [
    showBoard model,
    showNotif model
  ]

update: Message -> Board -> (Board, Cmd Message)
update msg model =
  case msg of
    Select piece -> (model, Cmd.none)
    MoveTo square -> (model, Cmd.none)
