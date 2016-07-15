module Meetups.View exposing (..)

import Html.App as App
import Html exposing (..)
import Html.Attributes as Attr exposing (class, style, src, type', placeholder, tabindex, autofocus, href)
import Html.Events exposing (onSubmit, onInput)

import String
import Regex exposing (regex, caseInsensitive)

import Meetup.Main exposing (Meetup)
import Meetups.Model exposing (Model)
import Meetups.Messages exposing (Msg(..))

import Errors.Main as Errors


(=>) : a -> b -> ( a, b )
(=>) = (,) 



listView :Model -> Html Msg
listView model =
    section []
        [ searchView 
        , headerView model.search
        , meetupsList model
        , App.map ErrMsg (Errors.view model.errors)
        ] 




-- Meetup Header view

headerView : String -> Html Msg
headerView sq =
    let 
        headingString = 
            if sq == "" then 
                [ text "Book meetups" ]
            else
                [ b [] [ text "Results for: "]
                , text sq
                ] 
    in                 
        section [ class "uk-width-small-3-4 uk-container-center" ]
            [ h1 [] headingString 
            ]



-- Meetup List view


meetupsList : Model -> Html Msg 
meetupsList model = 
    section [ class "uk-width-small-3-4 uk-container-center uk-grid"] <|
        if model.search == "" then 
            (List.map meetupThumView model.meetups )
        else 
            model.meetups
                |> List.filter (\s -> Regex.contains (caseInsensitive <| regex model.search) s.title)
                |> List.map meetupThumView





meetupThumView : Meetup -> Html Msg
meetupThumView meetup =
    div [ class "uk-width-medium-1-2 uk-width-large-1-3 uk-animation-fade" 
        , style ["margin-bottom" => "1rem"]
        ]
        [ div [ class "uk-panel uk-panel-box" ] 
            [ div 
                [ class "uk-panel-teaser"] 
                [ img [src meetup.cover] []]
            ,  h3 [class "uk-panel-title"] 
                [ a [ href <| "#meetup/" ++ toString meetup.id ]  
                    [text meetup.title]
                ]
            , p [] [text meetup.description]
            , button [ class "uk-button uk-button-primary uk-float-right"] 
                [ text "Join"]
            , membersComming meetup.members 
            ]
        ]

membersComming : List Int -> Html Msg
membersComming members =
    span [] [ text (String.join " | " (List.map toString members))]




--  Suarch view


searchView : Html Msg
searchView   =
    section [ class "uk-width-small-2-3 uk-container-center" ]
        [ div [ class "uk-block uk-block-large" ] 
            [ searchForm
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
        , input [ type' "text"
                , onInput SearchQuery 
                , autofocus True
                , tabindex 1
                , placeholder "Search meetup"
                , class "uk-form-large uk-width-1-1"
                --, style 
                --    [ "height" => "4em"
                --    , "width" => "100%"
                --    ] 
                ] []
        ] 
 