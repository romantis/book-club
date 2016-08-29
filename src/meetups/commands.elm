module Meetups.Commands exposing(..)

import Http
import Date
import Task
import Json.Decode as Decode exposing ((:=))

import Meetups.Model exposing (Model)
import Meetup.Main exposing (Meetup, memberDecoder)
import Meetups.Messages exposing (Msg(..))
import Errors.Main as Errors


commands : Model -> Cmd Msg
commands model = 
    case  model.meetups of
        hd::tl ->
            Cmd.none
        [] ->
        Cmd.batch
            [ fetch
            , getCurrentDate
            ]


fetch : Cmd Msg
fetch =
    Http.get decoder fetchUrl
        |> Task.perform FetchAllFail FetchAllDone


getCurrentDate : Cmd Msg
getCurrentDate = 
    Task.perform NowDateFail NowDateSuccess Date.now

fetchUrl : String
fetchUrl =
    "http://localhost:4000/meetups"



decoder : Decode.Decoder (List Meetup)
decoder =
    Decode.list memberDecoder

sub : Model -> Sub Msg 
sub model =
    Sub.map ErrMsg (Errors.sub model.errors)