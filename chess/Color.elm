module Chess.Color where

-- | The 'Color' class represents one of the two colors ('Black' or 'White')
-- used in the game of Chess.
type Color = White | Black

bgColor : Color -> String
bgColor color = case color of
    White -> "#FFCE9E"
    Black -> "#D18B47"

fgColor : Color -> String
fgColor color = case color of
    White -> "#FFFFFF"
    Black -> "#000000"
