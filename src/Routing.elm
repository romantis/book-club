module Routing exposing (..)

import String
import Navigation
import UrlParser exposing (..)


type Route
    = NotFoundRoute 
    | MeetupsRoute
    | CreateMeetupRoute
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
        , format CreateMeetupRoute ( s "create")
        , format MeetupsRoute (s "meetups")
        , format MeetupRoute (s "meetup" </> int)
        ]


pathParser : Navigation.Location -> Result String Route
pathParser location =
    location.pathname
        |> String.dropLeft 1
        |> parse identity matchers


parser : Navigation.Parser (Result String Route)
parser =
    Navigation.makeParser pathParser


routeFromResult : Result String Route -> Route
routeFromResult result =
    case result of
        Ok route ->
            route

        Err string ->
            NotFoundRoute 
