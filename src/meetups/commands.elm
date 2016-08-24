module Meetups.Commands exposing(..)

import Http
import Task
import Json.Decode as Decode exposing ((:=))

import Meetups.Model exposing (Model)
import Meetup.Main exposing (Meetup, memberDecoder)
import Meetups.Messages exposing (Msg(..))
import Errors.Main as Errors

import Shared.RandomColor as RColor exposing (randomColor)


commands = 
    Cmd.batch
        [ fetch
        , Cmd.map RColorMsg randomColor
        ]


fetch : Cmd Msg
fetch =
    Http.get decoder fetchUrl
        |> Task.perform FetchAllFail FetchAllDone


fetchUrl : String
fetchUrl =
    "http://localhost:4000/meetups"



decoder : Decode.Decoder (List Meetup)
decoder =
    Decode.list memberDecoder

sub : Model -> Sub Msg 
sub model =
    Sub.map ErrMsg (Errors.sub model.errors)