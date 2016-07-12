module Meetups.Commands exposing(..)

import Http
import Task
import Json.Decode as Decode exposing ((:=))

import Meetup.Main exposing (Meetup, memberDecoder)
import Meetups.Messages exposing (Msg(..))

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

