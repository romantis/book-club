module Meetup.Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (src, class, style)
import Html.App as App

import Http
import Task
import Json.Decode as Decode exposing ((:=), andThen)
import Date exposing (Date, Month(..))
import Time exposing (Time)
import String
import Errors.Main as Errors

import Debug

(=>) : a -> b -> ( a, b )
(=>) = (,)


type alias Meetup = 
    { id : Int
    , title : String
    , cover : String
    , description : String
    , date : Time
    , place : String
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
update msg model =
    case msg of
        FetchAllDone meetup ->
            ( {model | meetup = Just meetup}
            , Cmd.none
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
            div []
                [ text "Loading..."
                , App.map ErrMsg (Errors.view model.errors)
                ]
            
        Just meetup ->
            meetupView meetup (Debug.log "" model.errors)


meetupView : Meetup -> Errors.Model -> Html Msg
meetupView meetup errors=
    section [ class " uk-article uk-width-small-3-4 uk-container-center uk-block"]
        [ h1 [ class "uk-article-title"] [ text meetup.title]
        , div [ class "uk-article-meta "] 
            [ text <| formatDate meetup.date
            , text " | "
            , text meetup.place
            , text " | "
            , a [] [ text <| "Some Book: "]
            ]
        , img 
            [ src meetup.cover
            , style 
                [ "max-width"=>"30%"]
            ] []
        , p [ class "uk-article-lead"] [ text meetup.description]
        , App.map ErrMsg (Errors.view errors)
        ] 


formatDate : Time -> String
formatDate t =
    let 
        date = Date.fromTime t
        day = Date.day date
        month = whatMonth <| Date.month date
        year = Date.year date 
        hour = Date.hour date 
        minute = Date.minute date
    in
        [day, year, hour, minute]  
            |> List.map toString   
            |> String.join " "
            |> (++) (month ++ " ")

whatMonth : Date.Month -> String
whatMonth m = 
    case m of 
        Jan ->
            "Jan"
        Feb ->
            "Feb"
        Mar ->
            "Mar"
        Apr ->
            "Apr"
        May ->
            "May"
        Jun ->
            "Jun"
        Jul ->
            "Jul"
        Aug ->
            "Aug"
        Sep ->
            "Sep"
        Oct ->
            "Oct"
        Nov ->
            "Nov"
        Dec ->
            "Dec"


--  Commands 


fetch : Int -> Cmd Msg
fetch id  =
    Http.get memberDecoder (fetchUrl id) 
        |> Task.perform FetchAllFail FetchAllDone


fetchUrl : Int -> String
fetchUrl id =
    "http://localhost:4000/meetups/" ++ toString id



memberDecoder : Decode.Decoder Meetup
memberDecoder =
    Decode.object6 Meetup
        ("id" := Decode.int)
        ("title" := Decode.string)
        ("cover" := Decode.string)
        ("description" := Decode.string)
        ("date" :=Decode.float)
        ("place" := Decode.string)

sub : Model -> Sub Msg 
sub model =
    Sub.map ErrMsg (Errors.sub model.errors)
