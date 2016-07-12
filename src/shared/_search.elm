module Shared.Search exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, style, autofocus, tabindex, type', placeholder)
import Html.Events exposing (onInput)

type alias Model =
    {search : String}

init =
   Model  ""

type Msg 
    = Search String


(=>) = (,)

view : Model -> Html Msg
view model   =
    section [ class "uk-width-small-2-3 uk-container-center" ]
        [ div [ class "uk-block uk-block-large" ] 
            [ searchForm
            ]
        ]



searchForm = 
    div 
        [ class "uk-form uk-form-icon"
        , style [ "width" => "100%"]
        ] 
        [ i [ class "uk-icon uk-icon-search"] []
        , input [ type' "text"
                , onInput Search 
                , autofocus True
                , tabindex 1
                , placeholder "Search Book Event"
                , class "uk-form-large uk-width-1-1"
                , style 
                    [ "height" => "3em"
                    ] 
                ] []
        ] 