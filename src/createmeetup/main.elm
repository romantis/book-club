module CreateMeetup.Main exposing(..)

import Html exposing(..)
import Html.Attributes as Attr exposing (class, classList, style, src, type', placeholder, tabindex, autofocus, href, for, id)
import Html.Events exposing (onInput, onClick)


(=>) = (,)

view =
    section [ class "uk-width-small-1-2 uk-container-center uk-block uk-block-large" ]
        [ h1 [] [ text "Create New Meetup"]
        , div [ class "uk-form uk-form-horizontal"]
            [ div [ class "uk-form-row"] 
                [ label [ class "uk-form-label", for "meetup-title"] [ text "Meetup title"]
                , div [ class "uk-form-control"] 
                    [ input 
                        [ type' "text"
                        , id "meetup-title"
                        , placeholder "meetup title"
                        ] []
                    ]
                ]
            , div [ class "uk-form-row"] 
                [ label [ class "uk-form-label", for "book"] [ text "Book"]
                , div [ class "uk-form-control"] 
                    [ input 
                        [ type' "text"
                        , id "book"
                        , placeholder "Book"
                        ] []
                    ]
                ]
            , div [ class "uk-form-row"] 
                [ label [ class "uk-form-label", for "meetup-date"] [ text "Date"]
                , div [ class "uk-form-control"] 
                    [ input 
                        [ type' "date"
                        , id "meetup-date"
                        ] []
                    ]
                ]
            , div [ class "uk-form-row"] 
                [ label [ class "uk-form-label", for "meetup-place"] [ text "Place"]
                , div [ class "uk-form-control"] 
                    [ input 
                        [ type' "text"
                        , id "meetup-place"
                        , placeholder "Place"
                        ] []
                    ]
                ]
            , div [ class "uk-form-row"] 
                [ label [ class "uk-form-label", for "meetup-cover"] [ text "Cover"]
                , div [ class "uk-form-control"] 
                    [ input 
                        [ type' "url"
                        , id "meetup-cover"
                        , placeholder "image url"
                        ] []
                    ]
                ]
            , div [ class "uk-form-row"] 
                [ label [ class "uk-form-label", for "meetup-description"] [ text "Description"]
                , div [ class "uk-form-control"] 
                    [ textarea 
                        [ class "uk-width-1-1"
                        , id "meetup-description"
                        ] []
                    ]
                ]
            , button 
                [ class "uk-button uk-button-primary uk-margin" 
                ] 
                [ text "Create"]
            ]
        ]

