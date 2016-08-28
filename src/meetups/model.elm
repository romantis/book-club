module Meetups.Model exposing (..)

import Time exposing (Time)
import Meetup.Main exposing (Meetup)
import Errors.Main as Errors


type alias Model = 
    { meetups : List Meetup
    , filtered :List Meetup
    , search : String
    , items : Int
    , now : Time
    , errors : Errors.Model
    }

init : Model
init =
    Model [] [] "" 6 0 Errors.init 