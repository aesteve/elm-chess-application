import Html                 exposing (Html, div)
import Html.Attributes      exposing (style)
import Html.App             as App
import Chess.Board          exposing (Board, startingBoard)
import Chess.View.HtmlBoard exposing (showBoard, showNotif)


main =
  App.program { init = (startingBoard, Cmd.none), view = view, update = update, subscriptions = \_ -> Sub.none  }


view : Board -> Html msg
view model =
    div [style [("display", "flex")]] [
        showBoard model,
        showNotif model
    ]

type Msg = SelectPiece | MoveTo

-- update: Msg -> Board -> (Board, Cmd ?)
update msg model =
    (model, Cmd.none)