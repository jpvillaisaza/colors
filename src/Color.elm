module Color exposing (..)

-- elm/html
import Html exposing (Html)
import Html.Attributes

import Color.Source exposing (Source(..))


type alias Color =
  { name : String
  , code : String
  , source : Source
  }


blues : List Color
blues =
  [ { name = "blue", code = "#333399", source = CMYK }
  , { name = "blue", code = "#1f75fe", source = Crayola }
  , { name = "blue", code = "#0087bd", source = NCS }
  , { name = "blue", code = "#0093af", source = Munsell }
  , { name = "blue", code = "#0018a8", source = Pantone }
  , { name = "blue", code = "#0000ff", source = RGB }
  ]


greens : List Color
greens =
  [ { name = "green", code = "#00a550", source = CMYK }
  , { name = "green", code = "#1cac78", source = Crayola }
  , { name = "green", code = "#009f6b", source = NCS }
  , { name = "green", code = "#00a877", source = Munsell }
  , { name = "green", code = "#00ad83", source = Pantone }
  , { name = "green", code = "#00ff00", source = RGB }
  ]


reds : List Color
reds =
  [ { name = "red", code = "#ed1c24", source = CMYK }
  , { name = "red", code = "#ee204d", source = Crayola }
  , { name = "red", code = "#f2003c", source = Munsell }
  , { name = "red", code = "#ed2939", source = Pantone }
  , { name = "red", code = "#c40233", source = NCS }
  , { name = "red", code = "#ff0000", source = RGB }
  ]


search : String -> List Color
search q =
  let
    contains color =
      String.contains (String.toLower q) color.name
        || String.contains (String.toLower q) (String.toLower (Color.Source.toString color.source))
  in
    if String.isEmpty q
      then []
      else
        List.concat
          [ List.filter contains reds
          , List.filter contains greens
          , List.filter contains blues
          ]


viewColor : Color -> Html msg
viewColor color =
  Html.div
    [ Html.Attributes.style "border" "1px solid black"
    , Html.Attributes.style "padding" "1em"
    ]
    [ Html.div
        [ Html.Attributes.style "background-color" color.code
        , Html.Attributes.style "height" "44px"
        , Html.Attributes.style "width" "44px"
        ]
        []
    , Html.div []
        [ Html.text color.name
        , Html.br [] []
        , Html.text (Color.Source.toString color.source)
        ]
    ]


viewColors : List Color -> Html msg
viewColors colors =
  Html.div
    [ Html.Attributes.style "display" "grid"
    , Html.Attributes.style "gap" "1rem"
    , Html.Attributes.style
        "grid-template-columns"
        "repeat(auto-fill, minmax(min(150px, 100%), 1fr))"
    ]
    (List.map viewColor colors)
