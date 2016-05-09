import Html exposing (div, button, text, table, tr, td)
import Html.Events exposing (onClick)
import Html.Attributes exposing (style)
import StartApp.Simple as StartApp
import Chess.Board exposing (Board, startingBoard)
import Chess.View.HtmlBoard exposing (showBoard, showNotif)


main =
  StartApp.start { model = chessBoard, view = view, update = update }


chessBoard : Board
chessBoard = startingBoard

view : Address -> Model -> Html
view address model =
    div [style [("display", "flex")]] [
        showBoard address model,
        showNotif model
    ]

type Action = Increment | Decrement


update action model =
    model