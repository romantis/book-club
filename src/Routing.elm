module Routing exposing (..)

--import String
import Navigation
import UrlParser exposing (..)

import Hop exposing (makeUrl, makeUrlFromLocation, matchUrl, setQuery)
import Hop.Types exposing (Config, Query, Location, PathMatcher, Router)
import Hop.Matchers exposing (..)


import Debug

type Route
    = HomeRoute
    | ComponentRoute
    | NotFoundRoute


type Msg
    = NavigateTo String
    | SetQuery Query


type alias Model =
    { location : Location
    , route : Route
    }

matchers : Parser (Route -> a) a
matchers =
    [ match1 HomeRoute ""
    , match1 ComponentRoute ""
    ]

routerConfig : Config Route
routerConfig =
    { hash = True
    , basePath = ""
    , matchers = matchers
    , notFound = NotFoundRoute
    }




update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case (Debug.log "msg" msg) of
        NavigateTo path ->
            let
                command =
                    -- First generate the URL using your router config
                    -- Then generate a command using Navigation.newUrl
                    makeUrl routerConfig path
                        |> Navigation.newUrl
            in
                ( model, command )

        SetQuery query ->
            let
                command =
                    -- First modify the current stored location record (setting the query)
                    -- Then generate a URL using makeUrlFromLocation
                    -- Finally, create a command using Navigation.newUrl
                    model.location
                        |> setQuery query
                        |> makeUrlFromLocation routerConfig
                        |> Navigation.newUrl
            in
                ( model, command )



urlParser : Navigation.Parser ( Route, Hop.Types.Location )
urlParser =
    Navigation.makeParser (.href >> matchUrl routerConfig)


urlUpdate : ( Route, Hop.Types.Location ) -> Model -> ( Model, Cmd Msg )
urlUpdate ( route, location ) model =
    ( { model | route = route, location = location }, Cmd.none )


