module Search exposing
  ( Model
  , Msg
  , init
  , update
  , view
  )

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


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Q q ->
      ( { model | colors = Color.search q, q = q }
      , Cmd.none
      )


view : Model -> Html Msg
view model =
  Html.div []
    [ Html.div
        [ Html.Attributes.style "text-align" "center"
        ]
        [ Html.input
            [ Html.Attributes.autofocus True
            , Html.Attributes.name "q"
            , Html.Attributes.type_ "search"
            , Html.Events.onInput Q
            ]
            []
        ]
    , Color.viewColors model.colors
    ]
