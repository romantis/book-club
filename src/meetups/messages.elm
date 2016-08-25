module Meetups.Messages exposing(..)

import Http

import Meetup.Main exposing (Meetup)
import Errors.Main as Errors


type Msg 
    = FetchAllDone (List Meetup)
    | FetchAllFail Http.Error
    | FindMeetup
    | Navigate String
    | SearchQuery String
    | ErrMsg Errors.Msg
