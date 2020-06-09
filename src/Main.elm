module Main exposing (main)


-- elm/browser
import Browser

-- elm/html
import Html exposing (Html)
import Html.Attributes


type alias Model =
  ()


type alias Msg =
  ()


init : Model
init =
  ()


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
    _ ->
      model


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


viewMain : Model -> Html msg
viewMain _ =
  Html.main_ [] []
