module Meetups.Messages exposing(..)

import Http

import Meetup.Main exposing (Meetup)
import Errors.Main as Errors
import Shared.RandomColor as RColor


type Msg 
    = FetchAllDone (List Meetup)
    | FetchAllFail Http.Error
    | FindMeetup
    | Navigate String
    | SearchQuery String
    | RColorMsg RColor.Msg
    | ErrMsg Errors.Msg
