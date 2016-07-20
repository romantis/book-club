module CreateMeetup.Main exposing(..)

import Html exposing(..)
import Html.Attributes as Attr exposing (class, classList, style, src, type', placeholder, tabindex, autofocus, href, for, id)
import Html.Events exposing (onInput, onClick)

import Meetup.Main exposing (Meetup)

import Debug

type alias Model = 
    { meetup : Meetup
    --, validated : Bool
    }

init =
    Model (Meetup 0 "" "" "" 0 0 "" [])

type Msg 
    = NewMember
    | InputTitle String
    | InputBook String
    | InputDate String
    | InputPlace String 
    | InputCover String 
    | InputDescription String




update : Msg -> Model -> (Model , Cmd Msg)
update msg model = 
    case msg of
        NewMember ->
            ( model
            , Cmd.none
            )
        
        InputTitle title ->
            ( model
            , Cmd.none
            )
        
        InputBook book ->
            ( model
            , Cmd.none
            )
        
        InputDate date  ->
            ( model
            , Cmd.none
            )
        
        InputPlace place  ->
            ( model
            , Cmd.none
            )
        
        InputCover coverUrl ->
            ( model
            , Cmd.none
            )
        
        InputDescription description ->
            ( model
            , Cmd.none
            )



view :  Model -> Html Msg
view model =
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
                        , onInput InputTitle
                        ] []
                    ]
                ]
            , div [ class "uk-form-row"] 
                [ label [ class "uk-form-label", for "book-title"] [ text "Book Title"]
                , div [ class "uk-form-control"] 
                    [ input 
                        [ type' "text"
                        , id "book-title"
                        , placeholder "Book Title"
                        , onInput InputBook
                        ] []
                    ]
                ]
            , div [ class "uk-form-row"] 
                [ label [ class "uk-form-label", for "meetup-date"] [ text "Date"]
                , div [ class "uk-form-control"] 
                    [ input 
                        [ type' "date"
                        , id "meetup-date"
                        , onInput InputDate
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
                        , onInput InputPlace
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
                        , onInput InputCover
                        ] []
                    ]
                ]
            , div [ class "uk-form-row"] 
                [ label [ class "uk-form-label", for "meetup-description"] [ text "Description"]
                , div [ class "uk-form-control"] 
                    [ textarea 
                        [ class "uk-width-1-1"
                        , id "meetup-description"
                        , onInput InputDescription
                        ] []
                    ]
                ]
            , button 
                [ class "uk-button uk-button-primary uk-margin" 
                , onClick NewMember
                ] 
                [ text "Create"]
            ]
        ]

