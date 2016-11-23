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
        

route : Parser (Route -> a) a
route =
    oneOf
        [ map MeetupsRoute (s "") 
        , map CreateMeetupRoute ( s "create")
        , map MeetupsRoute (s "meetups")
        , map MeetupRoute (s "meetup" </> int)
        ]


parser : Navigation.Location -> Route
parser location =
     case parsePath route location of
        Just route ->
            route

        Nothing ->
            NotFoundRoute    
