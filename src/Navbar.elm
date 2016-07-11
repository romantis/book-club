module Navbar exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, href)

global :  Html msg
global  =
  nav [ class "" ]
    [ a [ class "", href "#" ] [ text "Home" ]
    , a [ class "", href "#component"] [ text "Component"] 
    ]
  