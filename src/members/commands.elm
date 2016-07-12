module Members.Commands exposing (..)

import Http
import Task
import Json.Decode as Decode exposing ((:=))

import Members.Model exposing(Member, Model)
import Members.Messages exposing (Msg(..))

import Errors.Main as Errors




fetch : Cmd Msg
fetch  =
    Http.get decoder fetchUrl
        |> Task.perform FetchAllFail FetchAllDone


fetchUrl : String
fetchUrl =
    "http://localhost:4000/members"




decoder : Decode.Decoder (List Member)
decoder =
    Decode.list memberDecoder


memberDecoder : Decode.Decoder Member
memberDecoder =
    Decode.object2 Member
        ("id" := Decode.int)
        ("name" := Decode.string)



