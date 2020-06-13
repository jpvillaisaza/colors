module Main exposing (main)

-- elm/browser
import Browser

-- elm/html
import Html exposing (Html)
import Html.Attributes
import Html.Events

import Color exposing (Color)


type alias Model =
  { colors : List Color
  , q : String
  }


type Msg
  = Q String


init : Model
init =
  { colors = []
  , q = ""
  }


main : Program () Model Msg
main =
  Browser.sandbox
    { init = init
    , update = update
    , view = view
    }


update : Msg -> Model -> Model
update msg model =
  case msg of
    Q q ->
      { model | colors = Color.search q, q = q }


view : Model -> Html Msg
view model =
  Html.div []
    [ viewHeader model
    , viewMain model
    , viewFooter model
    ]


viewFooter : Model -> Html msg
viewFooter _ =
  Html.footer []
    [ Html.a
        [ Html.Attributes.href "https://github.com/jpvillaisaza/colors"
        ]
        [ Html.text "GitHub"
        ]
    ]


viewHeader : Model -> Html msg
viewHeader _ =
  Html.header []
    [ Html.h1 []
        [ Html.text "Colors"
        ]
    ]


viewMain : Model -> Html Msg
viewMain model =
  Html.main_ []
    [ Html.input
        [ Html.Attributes.autofocus True
        , Html.Attributes.name "q"
        , Html.Attributes.type_ "search"
        , Html.Events.onInput Q
        ]
        []
    , Color.viewColors model.colors
    ]
