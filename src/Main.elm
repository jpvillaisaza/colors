module Main exposing (main)

-- elm/browser
import Browser exposing (Document)

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


init : () -> ( Model, Cmd Msg )
init _ =
  ( { colors = []
    , q = ""
    }
  , Cmd.none
  )


main : Program () Model Msg
main =
  Browser.document
    { init = init
    , subscriptions = subscriptions
    , update = update
    , view = view
    }


subscriptions : Model -> Sub Msg
subscriptions _ =
  Sub.none


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    Q q ->
      ( { model | colors = Color.search q, q = q }
      , Cmd.none
      )


view : Model -> Document Msg
view model =
  let
    body =
      [ viewHeader model
      , viewMain model
      , viewFooter model
      ]
  in
    { body = body
    , title = "Colors"
    }


viewFooter : Model -> Html Msg
viewFooter _ =
  Html.footer []
    [ Html.a
        [ Html.Attributes.href "https://github.com/jpvillaisaza/colors"
        ]
        [ Html.text "GitHub"
        ]
    ]


viewHeader : Model -> Html Msg
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
