module CreateMeetup.Main exposing(..)

import Html exposing(..)
import Html.Attributes as Attr exposing (class, classList, style, src, type_, placeholder, for, id)
import Html.Events exposing (onInput, onClick)
import Date exposing (Date)
import String
import Time exposing (Time)
import Task exposing (Task)
import Http
import Json.Decode exposing (int, string, float, Decoder)
import Json.Decode.Pipeline exposing (decode, required)
import Json.Encode as Encode
import Navigation

import Meetup.Main exposing (Meetup, memberDecoder)


import Date.Format as Date


(=>) : a -> b -> ( a, b )
(=>) = (,)

type alias NewMeetup =
    { title : String
    , cover : String
    , description : String
    , place : String 
    , date : Time
    }

type alias Model = 
    { title : String
    , cover : String
    , description : String
    , place : String 
    , date : Time
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
    | NowDate Date
    | CreateMeetupRequest (Result Http.Error Meetup)



update : Msg -> Model -> (Model , Cmd Msg)
update msg ({title, cover, description, place, date, now, validated} as model) = 
    case msg of
        CreateMeetup ->
            let 
                isValidated =
                    validate model

                cmd = 
                    if isValidated then
                        createNewMeetup (NewMeetup title cover description place date) 
                    else 
                        Cmd.none
            in 
                ( {model | validated = isValidated}
                , cmd
                )

        NowDate date ->
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
        
        CreateMeetupRequest (Ok _) ->
            ( init
            , Navigation.newUrl "/"
            )
        
        CreateMeetupRequest (Err _) ->
            ( model, Cmd.none)
        



view :  Model -> Html Msg
view model =
    section 
        [  class "uk-width-small-1-2 uk-container-center uk-block uk-block-large bc-min-height" 
        ]
        [ h1 [] [ text "Create New Meetup"]
        , div [ class "uk-form uk-form-horizontal"]
            [ div [ class "uk-form-row"] 
                [ label [ class "uk-form-label", for "meetup-title"] [ text "Meetup title"]
                , div [ class "uk-form-control"] 
                    [ input 
                        [ type_ "text"
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
                        [ type_ "date"
                        , Attr.min (Date.format "%Y-%m-%d" model.now)
                        , id "meetup-date"
                        , onInput InputDate
                        ] []
                    ]
                ]
            , div [ class "uk-form-row"] 
                [ label [ class "uk-form-label", for "meetup-place"] [ text "Place"]
                , div [ class "uk-form-control"] 
                    [ input 
                        [ type_ "text"
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
                        [ type_ "url"
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

-- Commands 
commands : Cmd Msg
commands =
    getCurrentDate    



getCurrentDate : Cmd Msg
getCurrentDate = 
    Task.perform NowDate Date.now


createNewMeetup : NewMeetup -> Cmd Msg
createNewMeetup meetup =
    let
        body =
            meetup
                |> meetupEncoded
                |> Http.jsonBody 
             
    in
        Http.post createMeetupUrl body memberDecoder
            |>Http.send CreateMeetupRequest





createMeetupUrl : String
createMeetupUrl = 
    "http://localhost:4000/meetups"

meetupDecoder : Decoder NewMeetup
meetupDecoder =
    decode NewMeetup
        |> required "title" string 
        |> required "cover" string
        |> required "description" string
        |> required "place" string
        |> required "date" float


meetupEncoded : NewMeetup -> Encode.Value 
meetupEncoded { title, cover, description, place, date } = 
    let
        list = 
            [ "title" => Encode.string title
            , "cover" => Encode.string cover
            , "description" => Encode.string description
            , "place" => Encode.string place
            , "date" => Encode.float date
            ]
    in 
        Encode.object list 