module Meetups.Model exposing (..)

import Meetup.Main exposing (Meetup) 

type alias Model = 
    { meetups : List Meetup
    , search : String
    }

init =
    Model [] "" 
 