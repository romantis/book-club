module Meetup.Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (src, class, style)

import Http
import Task
import Json.Decode as Decode exposing ((:=), andThen)
import Date exposing (Date, Month(..))
import Time exposing (Time)
import String

-- import Debug

(=>) : a -> b -> ( a, b )
(=>) = (,)


type alias Meetup = 
    { id : Int
    , title : String
    , cover : String
    , description : String
    , bookId : Int
    , date : Time
    , place : String
    , members : List Int 
    }


type alias Model = 
    { meetup : Maybe Meetup
    }


type Msg 
    = FetchAllFail Http.Error
    | FetchAllDone Meetup


init: Model
init =
    Model Nothing

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        FetchAllDone meetup ->
            ( {model | meetup = Just meetup}
            , Cmd.none
            )


        FetchAllFail err ->
            ( model 
            , Cmd.none
            ) 





view : Model -> Html Msg 
view model =
    case model.meetup of
        Nothing -> 
            text "Loading..."
        Just meetup ->
            meetupView meetup


meetupView : Meetup -> Html Msg
meetupView meetup =
    section [ class " uk-article uk-width-small-3-4 uk-container-center uk-block"]
        [ h1 [ class "uk-article-title"] [ text meetup.title]
        , div [ class "uk-article-meta "] 
            [ text <| formatDate meetup.date
            , text " | "
            , text meetup.place
            , text " | "
            , a [] [ text <| "Some Book: " ++ toString meetup.bookId]
            ]
        , img 
            [ src meetup.cover
            , style 
                [ "max-width"=>"30%"]
            ] []
        , p [ class "uk-article-lead"] [ text meetup.description]
        , p [] [ text <| toString meetup.members ] 
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
    Decode.object8 Meetup
        ("id" := Decode.int)
        ("title" := Decode.string)
        ("cover" := Decode.string)
        ("description" := Decode.string)
        ("bookId" := Decode.int)
        ("date" :=Decode.float)
        ("place" := Decode.string)
        ("members" := Decode.list Decode.int)
