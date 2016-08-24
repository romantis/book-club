module Meetups.Model exposing (..)

import Meetup.Main exposing (Meetup) 
import Errors.Main as Errors

import Shared.RandomColor as RColor

type alias Model = 
    { meetups : List Meetup
    , search : String
    , rColor : RColor.Model
    , errors : Errors.Model
    }

init : Model
init =
    Model 
        [] 
        ""
        RColor.init 
        Errors.init 
 