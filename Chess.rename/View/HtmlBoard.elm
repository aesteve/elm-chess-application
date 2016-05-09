module Chess.View.HtmlBoard where

import List             exposing (..)
import Html             exposing (Html, text, div, table, tr, td, img)
import Html.Attributes  exposing (style, src)
import Html.Events exposing (onClick)
import Chess.Color      exposing (..)
import Chess.Board      exposing (Square, Board)
import Chess.Piece      exposing (Piece)
import Signal           exposing (Address)

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

showPiece : Address Square -> Square -> Html
showPiece address square =
    let piece = square.piece in
    let figure = "img/pieces/" ++ toString piece.color ++ "-" ++ toString piece.figure ++ ".png" in
    img [(src figure), imgStyle, onClick address square] []

showSquare : Address Square -> Square -> Html
showSquare address square =
    td [squareStyle square] [
        case square.piece of
            Nothing -> text ""
            Just piece -> showPiece address square
    ]

showLine : Address Square -> List(Square) -> Html
showLine address line =
    tr [] (
        map (showSquare line address)
    )


showBoard : Address Square -> Board -> Html
showBoard address board =
    table [] (
        map (showLine (reverse board) address)
    )

showNotif : Board -> Html
showNotif board =
    div [style [("flex", "1")]] [

    ]