module Meetups.ThumbnailView exposing (view)

import Html exposing (..)
import Html.Attributes exposing (href, class, style)


import Date
import Time
import String
import Date.Format as Date

import Meetup.Main exposing (Meetup)
import Meetups.Messages exposing (Msg(..))

import Shared.RandomColor exposing (colorList, getColor)
import Shared.Helpers exposing (hrefClick) 



(=>) : a -> b -> ( a, b )
(=>) = (,) 


view : Meetup  -> Html Msg
view meetup =
    let
        url = 
             "/meetup/" ++ toString meetup.id
        rColor =
            List.length colorList
                |> (%) (Time.inMilliseconds meetup.date |> round)
                |> getColor
    in
        [ thumbnailTeaser meetup.title meetup.author url rColor
        , div [ class "uk-text-muted uk-margin-remove"] 
            [ p [ class "uk-float-right"] 
                [ i [ class "uk-icon-calendar uk-margin-small-right" ] []
                , text (Date.format "%b %e, %Y" <| Date.fromTime meetup.date)
                ]
            , p []
                [ i [ class "uk-icon-map-marker uk-margin-small-right" ] [] 
                , text (meetup.place.city ++ ", "++ meetup.place.country) 
                ]
            ]
        , p [] [text ((String.left 100 meetup.description) ++ " ...") ]
        , a 
            [ class "uk-float-right"
            , hrefClick Navigate url 
            , href url
            ] 
            [ text "Details"]
        ] |> thumbnailLayout 



thumbnailLayout : List (Html Msg) -> Html Msg
thumbnailLayout content =
    div 
        [ class "uk-width-medium-1-2 uk-width-large-1-3 uk-animation-fade uk-margin-bottom" ]
        [ div 
            [ class "uk-panel uk-panel-box" ]
            content
        ] 


thumbnailTeaser : String -> String -> String -> String -> Html Msg
thumbnailTeaser title author url rColor =
    div 
        [ class "uk-panel-teaser"
        , style 
            [ "height" => "auto"
            , "border-top" => ".5rem solid"
            , "border-top-color" => rColor
            ]
        ] 
        [ h3 [] 
            [ a [ hrefClick Navigate url 
                , href url
                , style 
                    [ "font-size" => "1.2em"
                    , "padding" => "0 .5em"
                    ] 
                ]  
                [ text title ]
            ]
        , i 
            [ style 
                ["margin" => "0 0 0.5em 1em"
                , "font-size" => "1.2rem"
                , "position" => "absolute"
                , "right" => "1rem"
                , "bottom" => ".3rem"
                , "color" => "rgba(255, 255,255, .8)"
                ]
            ] 
            [ text ("by " ++ author) ]
        ]

