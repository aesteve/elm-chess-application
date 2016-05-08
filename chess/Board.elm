module Chess.Board where

import Dict             exposing (Dict)
import Html             exposing (Html, text, table, tr, td)
import Chess.Piece      exposing (..)
import Chess.Color      exposing (..)
import List             exposing (..)

type alias Square = {color: Color, piece: Maybe Piece}
squareColor : Int -> Int -> Color
squareColor col row = case row % 2 == col % 2 of
    True -> White
    False -> Black


type alias Board = List(List Square)

startingBoard : Board
startingBoard =
    [
        createFigureLine White 1,
        createPawnLine White 2,
        createEmptyLine 3,
        createEmptyLine 4,
        createEmptyLine 5,
        createEmptyLine 5,
        createEmptyLine 6,
        createPawnLine Black 7,
        createFigureLine Black 8
    ]

baseFigurePos : List (Int, Figure)
baseFigurePos = [(1, Rook), (2, Knight), (3, Bishop), (4, Queen), (5, King), (6, Bishop), (7, Knight), (8, Rook)]

createFigureLine : Color -> Int -> List Square
createFigureLine color row =
    map (\figurePos -> {color = squareColor (fst figurePos) row, piece = Just({figure = snd figurePos, color = color})}) baseFigurePos


createPawnLine : Color -> Int -> List Square
createPawnLine color row =
    createLine row (Just {figure = Pawn, color = color})

createEmptyLine : Int -> List Square
createEmptyLine row =
    createLine row Nothing

createLine : Int -> Maybe Piece -> List Square
createLine row piece =
    map (\col -> {color = squareColor col row, piece = piece}) [1..8]


showSquare : Square -> Html
showSquare square =
    td [] [
        case square.piece of
            Nothing -> text "x"
            Just val -> text (toString val.figure)
    ]

showLine : List(Square) -> Html
showLine line =
    tr [] (
        map showSquare line
    )


showBoard : Board -> Html
showBoard board =
    table [] (
        map showLine board
    )
