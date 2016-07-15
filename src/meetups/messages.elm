module Meetups.Messages exposing(..)

import Http

import Meetup.Main exposing (Meetup)
import Errors.Main as Errors


type Msg 
    = FetchAllDone (List Meetup)
    | FetchAllFail Http.Error
    | FindMeetup
    | SearchQuery String
    | ErrMsg Errors.Msg
