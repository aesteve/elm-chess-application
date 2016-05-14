module Chess.Board exposing (..)

import Chess.Piece       exposing (..)
import Chess.Color       exposing (..)
import Utils.Collections exposing (..)
import List              exposing (..)
import Dict              exposing (Dict, values)
import Debug             exposing (log)

type alias Square = { col: Int, row: Int, color: Color, piece: Maybe Piece, selected: Bool, available: Bool }

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
  { row = row, col = col, color = squareColor col row, piece = piece, selected = False, available = False }

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
  for [1..8] <| \col -> { col = col, row = row, color = squareColor col row, piece = piece, selected = False, available = False }
  -- map (\col -> {color = squareColor col row, piece = piece}) [1..8]

findSquare : Int -> Int -> Predicate Square
findSquare col row = \square ->
  square.col == col && square.row == row

getSquare : Int -> Int -> Board -> Maybe Square
getSquare col row board =
  let line = getAt col board in
  case line of
    Nothing -> Nothing
    Just theLine -> getAt row theLine

toggleSquare : Square -> Square
toggleSquare square =
  { square | selected = not square.selected }

unselectSquare : Square -> Square
unselectSquare square =
  { square | selected = False }

possibleMoves : Maybe Square -> List (Int, Int)
possibleMoves square =
  case square of
    Nothing -> []
    Just theSquare ->
      case theSquare.piece of
        Nothing -> []
        Just piece -> moves piece.figure theSquare.col theSquare.row

isSquareAvailable : List(Int, Int) -> Predicate Square
isSquareAvailable positions = \square ->
  let matching = \pos ->
    square.col == fst (log "matching ?" pos) && square.row == snd pos
  in
  any matching positions

setSquareAvailable : Square -> Square
setSquareAvailable square =
  log ("set square availeble" ++ (toString square))
  { square | available = True }

setSquareUnavailable : Square -> Square
setSquareUnavailable square =
  { square | available = False }


selectSquare : Int -> Int -> Board -> Board
selectSquare col row board =
  let availablePos = possibleMoves (getSquare col row board) in
  let selectedBoard = updateListWhere (findSquare col row) toggleSquare unselectSquare board in
  let availableBoard = updateListWhere (isSquareAvailable availablePos) setSquareAvailable setSquareUnavailable selectedBoard in
  availableBoard
