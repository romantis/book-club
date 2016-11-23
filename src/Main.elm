module Main exposing (main)

import Navigation exposing (Location)

import Messages exposing (Msg(..))
import Models exposing (Model, initialModel)
import View exposing (view)
import Update exposing (update, updCmdHelper)
import Routing exposing (Route(..))
import Meetups.Commands as Meetups
import Meetup.Main as Meetup







init : Location -> ( Model, Cmd Msg )
init location =
    let
        currentRoute =
            Routing.parser location
        model =
            initialModel currentRoute

    in
        ( model
        , updCmdHelper model
        )



subscriptions : Model -> Sub Msg 
subscriptions model =
    Sub.batch 
        [ Sub.map MeetupsMsg (Meetups.sub model.meetups)
        , Sub.map MeetupMsg (Meetup.sub model.meetup) 
        ]


main : Program Never Model Msg
main =
    Navigation.program LocationUpd
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
