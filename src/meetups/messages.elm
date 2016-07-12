module Meetups.Messages exposing(..)

import Http

import Meetup.Main exposing (Meetup)


type Msg 
    = FetchAllDone (List Meetup)
    | FetchAllFail Http.Error
    | FindMeetup
    | SearchQuery String
