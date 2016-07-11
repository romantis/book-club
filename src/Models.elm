module Models exposing (..)

import Routing
import Component.Main as Component 


type alias Model =
    { route : Routing.Route
    , component : Component.Model 
    }


initialModel : Routing.Route -> Model
initialModel route =
    { route = route
    , component = (Component.Model "Component Page" 0)
    }
