module Meetups.Messages exposing(..)

import Http
import Date exposing (Date)

import Meetup.Main exposing (Meetup)
import Errors.Main as Errors


type Msg 
    = FetchMeetups (Result Http.Error (List Meetup))
    | MoreMeetups
    | Navigate String
    | SearchQuery String
    | NowDate Date
    | ErrMsg Errors.Msg
