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
import Date.Format as Date


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
            meetupView meetup (model.errors)

meetupView : Meetup -> Errors.Model -> Html Msg
meetupView meetup errors=
    section 
        [ style [ "min-height" => "calc(100vh - 165px)"]]
        [ meetupHeaderView
            [ h1 [ class "uk-heading-large"] 
                [ text meetup.title
                , span [class "uk-text-primary uk-margin-left"] [text "Meetup"] 
                ]
            , div [ class "uk-text-large"] 
                [ i [class "uk-icon-calendar uk-margin-small-right"] []
                , text <| Date.format "%B %e %Y at %k:%M" (Date.fromTime meetup.date)
                ]
            ]
            
        , div [class "uk-width-small-1-2 uk-container-center uk-block"]
            [ h2 [] [ text "Meetup place"] 
            , p [] [text meetup.place]
            , h2 [class ""] [ text "Description"]
            , p [ class "" ]
                [ text meetup.description
                ] 
            ] 
            
        , App.map ErrMsg (Errors.view errors)
        ] 



meetupHeaderView content =
    header 
        [ style [ "height" => "30vh"]
        , class "bg-carbon-fibre uk-contrast uk-flex uk-flex-center uk-flex-middle uk-flex-column"
        ] 
        content



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
