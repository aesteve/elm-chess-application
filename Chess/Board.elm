module Chess.Board exposing (..)

import Chess.Piece      exposing (..)
import Chess.Color      exposing (..)
import List             exposing (..)
import Dict             exposing (Dict, values)

type alias Square = {color: Color, piece: Maybe Piece}
squareColor : Int -> Int -> Color
squareColor col row = case row % 2 == col % 2 of -- it's the opposite of normal algo since I'm indexing from 1 to 8
    True -> Black
    False -> White


type alias Board = List(List Square)

startingBoard : Board
startingBoard =
    [
        createFigureLine White 1,
        createPawnLine White 2,
        createEmptyLine 3,
        createEmptyLine 4,
        createEmptyLine 5,
        createEmptyLine 6,
        createPawnLine Black 7,
        createFigureLine Black 8
    ]

baseFigurePos : Dict Int Figure
baseFigurePos = Dict.fromList
  [
    (1, Rook),
    (2, Knight),
    (3, Bishop),
    (4, Queen),
    (5, King),
    (6, Bishop),
    (7, Knight),
    (8, Rook)
  ]

createSquare : Int -> Color -> Int -> Figure -> Square
createSquare row color col figure =
  let piece = Just { figure = figure, color = color } in
  { color = squareColor col row, piece = piece }

createFigureLine : Color -> Int -> List Square
createFigureLine color row =
  -- Dict.map (\pos figure -> {color = squareColor pos row, piece = Just({figure = figure, color = color})}) baseFigurePos |> values
  baseFigurePos |> Dict.map(createSquare row color) |> values


createPawnLine : Color -> Int -> List Square
createPawnLine color row =
    createLine row (Just {figure = Pawn, color = color})

createEmptyLine : Int -> List Square
createEmptyLine row =
    createLine row Nothing

createLine : Int -> Maybe Piece -> List Square
createLine row piece =
    let for = flip map in
    for [1..8] <| \col -> { color = squareColor col row, piece = piece }
    -- map (\col -> {color = squareColor col row, piece = piece}) [1..8]
