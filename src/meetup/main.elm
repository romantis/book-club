module Meetup.Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (src, class, style, id)
import Html.App as App

import Http
import Task
import Json.Decode as Decode exposing ((:=), andThen)
import Date exposing (Date, Month(..))
import Time exposing (Time)

import Errors.Main as Errors
import Date.Format as Date

import Ports exposing (loadmap)


(=>) : a -> b -> ( a, b )
(=>) = (,)

type alias Place =
    { region : String
    , country : String
    , city : String
    , latitude : Float
    , longitude : Float
    }

type alias Meetup = 
    { id : Int
    , title : String
    , author : String
    , description : String
    , date : Time
    , place : Place
    }


type alias Model = 
    { meetup : Maybe Meetup
    , errors : Errors.Model
    }


type Msg 
    = FetchAllFail Http.Error
    | FetchAllDone Meetup
    | ErrMsg Errors.Msg


init: Model
init =
    Model Nothing Errors.init

update : Msg -> Model -> (Model, Cmd Msg)
update msg ({meetup, errors} as model) =
    case msg of
        FetchAllDone meetup ->
            ( {model | meetup = Just meetup}
            , loadmap (meetup.place.latitude, meetup.place.longitude)
            )


        FetchAllFail err ->
            ({ model | errors = Errors.addNew err model.errors }
            , Cmd.none
            ) 


        ErrMsg subMsg ->
            let 
                errModel = 
                    Errors.update subMsg model.errors 
            in
                ( { model | errors = errModel }
                , Cmd.none
                )




view : Model -> Html Msg 
view model =
    case model.meetup of
        Nothing -> 
            div [ class "bc-min-height" ]
                [ text "Loading..."
                , App.map ErrMsg (Errors.view model.errors)
                ]
            
        Just meetup ->
            meetupView meetup (model.errors)

meetupView : Meetup -> Errors.Model -> Html Msg
meetupView meetup errors=
    section 
        [ class "bc-min-height"]
        [ meetupHeaderLayout
            [ h1 [ class "uk-heading-large uk-text-center"] 
                [ text meetup.title
                , span [class "uk-text-primary uk-margin-left"] [text "Meetup"] 
                ]
            , p [ class "uk-text-large uk-text-center"] 
                [ text ("by " ++ meetup.author)
                ]
            ]
            
        , div [ class "uk-grid"] 
            [ descriptionLayout
                [ h2 [] [ text "When"]
                , p [ class "uk-text-large"] [ text <| Date.format "%B %e, %Y at %k:%M" (Date.fromTime meetup.date)] 
                , h2 [] [ text "Where"]
                , p [ class "uk-text-large"] [text (meetup.place.city ++ ", "++ meetup.place.country)] 
                , h2 [class ""] [ text "Meetup Details"]
                , p [ class "" ]
                    [ text meetup.description
                    ] 
                ] 
            , div 
                [ id "place-map"
                , class "uk-width-small-1-1 uk-width-medium-1-2 uk-width-large-2-3"
                , style 
                    [ "background" => "#eee"
                    , "min-height" => "55vh"
                    ] 
                ]
                []
            ]

        , App.map ErrMsg (Errors.view errors)
        ] 


meetupHeaderLayout : List (Html Msg) -> Html Msg
meetupHeaderLayout content =
    header 
        [ style [ "height" => "30vh"]
        , class "bg-carbon-fibre uk-contrast uk-flex uk-flex-center uk-flex-column uk"
        ] 
        content


descriptionLayout : List (Html Msg) -> Html Msg
descriptionLayout content = 
    div [class "uk-width-small-1-1 uk-width-medium-1-2 uk-width-large-1-3"]
        [ div 
            [ class "uk-block"
            , style [ "padding-left"=> "1.5em"
                    , "padding-right"=> "1.5em"
                    ]
            ] 
            content 
        ]





--  Commands 

commands : Int -> Cmd Msg
commands id =
    fetch id


fetch : Int -> Cmd Msg
fetch id  =
    Http.get memberDecoder (fetchUrl id) 
        |> Task.perform FetchAllFail FetchAllDone


fetchUrl : Int -> String
fetchUrl id =
    "http://localhost:4000/meetups/" ++ toString id


placeDecoder : Decode.Decoder Place
placeDecoder = 
    Decode.object5 Place 
        ("region" := Decode.string)
        ("country" := Decode.string)
        ("city" :=  Decode.string)
        ("latitude" := Decode.float)
        ("longitude" := Decode.float)

memberDecoder : Decode.Decoder Meetup
memberDecoder =
    Decode.object6 Meetup
        ("id" := Decode.int)
        ("bookTitle" := Decode.string)
        ("author" := Decode.string)
        ("description" := Decode.string)
        ("date" := Decode.float)
        ("place" := placeDecoder)

sub : Model -> Sub Msg 
sub model =
    Sub.map ErrMsg (Errors.sub model.errors)

