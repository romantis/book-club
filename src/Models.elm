module Models exposing (..)

import Routing exposing (routeString)
import Shared.Header as Header
import Meetups.Model as Meetups
import Meetup.Main as Meetup



type alias Model =
    { route : Routing.Route
    , header : Header.Model
    , meetups : Meetups.Model
    , meetup : Meetup.Model
    }


initialModel : Routing.Route -> Model
initialModel route =
    { route = route
    , header = (Header.init <| routeString route)
    , meetups = Meetups.init
    , meetup = Meetup.init
    }
