module Meetups.Messages exposing(..)

import Http
import Date exposing (Date)

import Meetup.Main exposing (Meetup)
import Errors.Main as Errors


type Msg 
    = FetchAllDone (List Meetup)
    | FetchAllFail Http.Error
    | MoreMeetups
    | Navigate String
    | SearchQuery String
    | NowDateFail String
    | NowDateSuccess Date
    | ErrMsg Errors.Msg
