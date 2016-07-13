module Routing exposing (..)

import String
import Navigation
import UrlParser exposing (..)

-- import Debug

type Route
    = NotFoundRoute 
    | MeetupsRoute
    | MeetupRoute Int


routeString : Route -> String
routeString route =
    case route of 
        MeetupsRoute ->
            "meetups"
        _ ->
            ""
        

matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ format MeetupsRoute (s "") 
        , format MeetupsRoute (s "meetups")
        , format MeetupRoute (s "meetup" </> int)
        ]


hashParser : Navigation.Location -> Result String Route
hashParser location =
    location.hash
        |> String.dropLeft 1
        |> parse identity matchers


parser : Navigation.Parser (Result String Route)
parser =
    Navigation.makeParser hashParser


routeFromResult : Result String Route -> Route
routeFromResult result =
    case Debug.log "" result of
        Ok route ->
            route

        Err string ->
            NotFoundRoute 
