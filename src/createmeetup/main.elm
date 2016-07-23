module CreateMeetup.Main exposing(..)

import Html exposing(..)
import Html.Attributes as Attr exposing (class, classList, style, src, type', placeholder, for, id)
import Html.Events exposing (onInput, onClick)
import Date exposing (Date)
import String
import Time exposing (Time)
import Task

import Date.Format as Date

--import Meetup.Main exposing (Meetup)

import Debug

type alias Model = 
    { title : String
    , cover : String
    , description : String
    , place : String 
    , date : Time
    --I need this for validation inputDate
    , now : Date
    , validated : Bool
    }



init : Model
init =
    Model "" "" "" "" 0 ((Date.fromTime << toFloat) 0) False


type Msg 
    = CreateMeetup
    | InputTitle String
    | InputCover String 
    | InputDescription String
    | InputPlace String 
    | InputDate String
    | NowDateSuccess Date
    | NowDateFail String




update : Msg -> Model -> (Model , Cmd Msg)
update msg model = 
    case msg of
        CreateMeetup ->
            ( Debug.log "meetup to add: " {model | validated = validate model}
            , Cmd.none
            )

        NowDateFail _ ->
            ( model, Cmd.none)
        
        NowDateSuccess date ->
            ( {model | now = date}
            , Cmd.none
            )

        InputTitle title ->
            ({ model | title = title }
            , Cmd.none
            )
        
        InputCover coverUrl ->
            ({ model | cover = coverUrl }
            , Cmd.none
            )
        
        InputDescription description ->
            ({ model | description = description }
            , Cmd.none
            )
        
        InputDate strDate  ->
            let 
                result = 
                    Date.fromString strDate
                
                --It's actually TIME
                date = 
                    case result of 
                        Ok date ->
                            Date.toTime date 
                        Err _ ->
                            toFloat 0
                        
            in
                ({ model | date = date}
                , Cmd.none
                )
        
        InputPlace place  ->
            ({ model | place = place }
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
                [ label [ class "uk-form-label", for "meetup-date"] [ text "Date"]
                , div [ class "uk-form-control"] 
                    [ input 
                        [ type' "date"
                        , Attr.min (Date.format "%Y-%m-%d" model.now)
                        , id "meetup-date"
                        , onInput InputDate
                        ] []
                    --, input 
                    --    [ type' "time"
                    --    , id "meetup-date"
                    --    --, onInput InputTime
                    --    ] []
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
                , onClick CreateMeetup
                ] 
                [ text "Create"]
            ]
        ]


-- Helper functions

strValid : String -> Bool
strValid s =
    String.length s > 2

validate : Model -> Bool
validate { title, cover, description, date, place } =
    strValid title 
    && strValid cover
    && strValid description 
    && strValid place


getCurrentDate : Cmd Msg
getCurrentDate = 
    Task.perform NowDateFail NowDateSuccess Date.now