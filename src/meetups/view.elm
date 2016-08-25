module Meetups.View exposing (..)

import Html.App as App
import Html exposing (..)
import Html.Attributes as Attr exposing (class, style, src, type', placeholder, tabindex, autofocus, href, for, id)
import Html.Events exposing (onSubmit, onInput, onClick)

import Date
import Time
import String
import Date.Format as Date
import Regex exposing (regex, caseInsensitive)

import Meetup.Main exposing (Meetup)
import Meetups.Model exposing (Model)
import Meetups.Messages exposing (Msg(..))

import Shared.RandomColor exposing (colorList, getColor)
import Shared.Helpers exposing (hrefClick)
import Errors.Main as Errors



(=>) : a -> b -> ( a, b )
(=>) = (,) 



listView :Model -> Html Msg
listView model =
    section [ class "bc-min-height"]
        [ searchView
        , searchQ model.search
        , meetupsList model
        , App.map ErrMsg (Errors.view model.errors)
        ] 




-- Meetup Header view

searchQ : String -> Html Msg
searchQ sq =
    let 
        headingString = 
            if sq == "" then 
                [ text "Upcoming meetups" ]
            else
                [ b [] [ text "Results for: "]
                , span [class "uk-text-primary"] [text sq]
                ] 
    in                 
        section [ class "uk-width-small-3-4 uk-container-center" ]
            [ h2 [] headingString 
            ]



-- Meetup List view


meetupsList : Model -> Html Msg 
meetupsList model = 
    section [ class "uk-width-small-3-4 uk-container-center uk-grid"] <|
        if model.search == "" then 
            (List.map meetupThumView model.meetups)
        else 
            model.meetups
                |> List.filter (\s -> Regex.contains (caseInsensitive <| regex model.search) s.title)
                |> List.map meetupThumView





meetupThumView : Meetup  -> Html Msg
meetupThumView meetup =
    let
        url = 
             "#" ++ "meetup/" ++ toString meetup.id
        rColor =
            List.length colorList
                |> (%) (Time.inMilliseconds meetup.date |> round)
                |> getColor
    in
        div [ class "uk-width-medium-1-2 uk-width-large-1-3 uk-animation-fade uk-margin-bottom" 
            ]
            [ div [ class "uk-panel uk-panel-box" ] 
                [ div 
                    [ class "uk-panel-teaser bg-carbon-fibre uk-vertical-align"
                    , style 
                        [ "background" => ("linear-gradient(transparent 60%, black)," ++  rColor)
                        , "height" => "200px"
                        ]
                    ] 
                    [ h3 [class "uk-panel-title uk-contrast uk-margin-left uk-vertical-align-bottom"] 
                        [ a [ hrefClick Navigate url 
                            , href url 
                            ]  
                            [text meetup.title]
                        ]
                    ]
                -- , hr [ class "uk-margin-remove"] []
                , p 
                    [ class "uk-text-muted uk-margin-remove"] 
                    [ i [class "uk-icon-calendar uk-margin-small-right"] []
                    , text (Date.format "%B %e, %Y at %k:%M" <| Date.fromTime meetup.date)
                    ]
                , p [] [text ((String.left 100 meetup.description) ++ " ...") ]
                , a 
                    [ class "uk-float-right"
                    , hrefClick Navigate url 
                    , href url
                    ] 
                    [ text "Details"]
                ]
            ]




--  Suarch view


searchView : Html Msg
searchView   =
    section [ class "bg-carbon-fibre uk-contrast" ]
        [ div [ class "uk-width-small-2-3 uk-container-center uk-block uk-block-large" ] 
            [ h1 
                [ class "uk-h2"
                , style ["color"=>"#35B3EE"]
                ] 
                [text "Search Book Meetups"] 
            , searchForm 
            ]
        ]


searchForm : Html Msg
searchForm = 
    form 
        [ class "uk-form uk-form-icon"
        , onSubmit FindMeetup
        , style [ "width" => "100%"]
        ] 
        [ i [ class "uk-icon uk-icon-search"] []
        , input [ type' "search"
                , onInput SearchQuery 
                , autofocus True
                , tabindex 1
                , placeholder "Search meetup"
                , class "uk-form-large uk-width-1-1"
                ] []
        ] 
