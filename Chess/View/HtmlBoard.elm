module Chess.View.HtmlBoard exposing (showBoard, showNotif)

import List             exposing (..)
import Html             exposing (Html, text, div, table, tr, td, img)
import Html.Attributes  exposing (style, src)
import Html.Events      exposing (onClick)
import Chess.Color      exposing (..)
import Chess.Board      exposing (Square, Board)
import Chess.Piece      exposing (Piece)

bgColor : Color -> String
bgColor color = case color of
    White -> "#FFCE9E"
    Black -> "#D18B47"

fgColor : Color -> String
fgColor color = case color of
    White -> "#FFFFFF"
    Black -> "#000000"

squareStyle square =
    style
    [
        ("backgroundColor", (bgColor square.color)),
        ("width", "85px"),
        ("height", "85px"),
        ("textAlign", "center"),
        ("verticalAlign", "middle")
    ]

imgStyle =
    style
    [
        ("width", "80px"),
        ("height", "80px"),
        ("cursor", "pointer")
    ]

showPiece: Piece -> Html msg
showPiece piece =
    let figure = "img/pieces/" ++ toString piece.color ++ "-" ++ toString piece.figure ++ ".png" in
    img [(src figure), imgStyle] []

showSquare : Square -> Html msg
showSquare square =
    td [squareStyle square] [
        case square.piece of
            Nothing -> text ""
            Just piece -> showPiece piece
    ]

showLine : List(Square) -> Html msg
showLine line =
    tr [] (
        map showSquare line
    )


showBoard : Board -> Html msg
showBoard board =
    table [] (
        map showLine (reverse board)
    )

showNotif : Board -> Html msg
showNotif board =
    div [style [("flex", "1")]] [

    ]