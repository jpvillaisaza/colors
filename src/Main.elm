module Main exposing (main)

-- elm/browser
import Browser
import Browser.Navigation

-- elm/html
import Html exposing (Html)
import Html.Attributes
import Html.Events

-- elm/url
import Url exposing (Url)

import Color exposing (Color)
import Search


type alias Model =
  { key : Browser.Navigation.Key
  , page : Page
  , url : Url
  }


type Msg
  = SearchMsg Search.Msg
  | UrlChange Url
  | UrlRequest Browser.UrlRequest


type Page
  = Search Search.Model


init : () -> Url -> Browser.Navigation.Key -> ( Model, Cmd Msg )
init _ url key =
  ( { key = key
    , page = Search Search.init
    , url = url
    }
  , Cmd.none
  )


main : Program () Model Msg
main =
  Browser.application
    { init = init
    , onUrlChange = onUrlChange
    , onUrlRequest = onUrlRequest
    , subscriptions = subscriptions
    , update = update
    , view = view
    }


onUrlChange : Url -> Msg
onUrlChange =
  UrlChange


onUrlRequest : Browser.UrlRequest -> Msg
onUrlRequest =
  UrlRequest


subscriptions : Model -> Sub Msg
subscriptions _ =
  Sub.none


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    SearchMsg searchMsg ->
      case model.page of
        Search search ->
          let
            (searchNew, cmds) =
              Search.update searchMsg search
          in
            ( { model | page = Search searchNew }
            , Cmd.map SearchMsg cmds
            )

    UrlChange url ->
      ( { model | url = url }
      , Cmd.none
      )

    UrlRequest urlRequest ->
      case urlRequest of
        Browser.External url ->
          ( model
          , Browser.Navigation.load url
          )

        Browser.Internal url ->
          ( model
          , Browser.Navigation.pushUrl model.key (Url.toString url)
          )


view : Model -> Browser.Document Msg
view model =
  let
    body =
      [ Html.div
          [ Html.Attributes.style "font-family" "sans-serif"
          ]
          [ viewHeader model
          , viewMain model
          , viewFooter model
          ]
      ]
  in
    { body = body
    , title = "Colors"
    }


viewFooter : Model -> Html Msg
viewFooter _ =
  Html.footer
    [ Html.Attributes.style "text-align" "center"
    ]
    [ Html.a
        [ Html.Attributes.href "https://github.com/jpvillaisaza/colors"
        ]
        [ Html.text "GitHub"
        ]
    ]


viewHeader : Model -> Html Msg
viewHeader _ =
  Html.header
    [ Html.Attributes.style "text-align" "center"
    ]
    [ Html.h1 []
        [ Html.text "Colors"
        ]
    ]


viewMain : Model -> Html Msg
viewMain model =
  Html.main_
    []
    [ case model.page of
        Search search ->
          Html.map SearchMsg (Search.view search)
    ]
