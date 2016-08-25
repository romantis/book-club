module Meetups.Model exposing (..)

import Meetup.Main exposing (Meetup) 
import Errors.Main as Errors


type alias Model = 
    { meetups : List Meetup
    , search : String
    , errors : Errors.Model
    }

init : Model
init =
    Model [] "" Errors.init 
 