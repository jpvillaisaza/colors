module Color.Source exposing
  ( Source(..)
  , toString
  )


type Source
  = CMYK
  | Crayola
  | Munsell
  | NCS
  | Pantone
  | RGB


toString : Source -> String
toString source =
  case source of
    CMYK ->
      "CMYK"
    Crayola ->
      "Crayola"
    Munsell ->
      "Munsell"
    NCS ->
      "NCS"
    Pantone ->
      "Pantone"
    RGB ->
      "RGB"
