module Main exposing (main)

import Navigation
import Messages exposing (Msg(..))
import Models exposing (Model, initialModel)
import View exposing (view)
import Update exposing (update)
import Routing exposing (Route(..))
import Meetups.Commands as Meetups
import Meetup.Main as Meetup
import CreateMeetup.Main as CreateMeetup





init : Result String Route -> ( Model, Cmd Msg )
init result =
    let
        currentRoute =
            Routing.routeFromResult result
        model =
            initialModel currentRoute

    in
        ( model
        , updCmd model 
        ) 



urlUpdate : Result String Route -> Model -> ( Model, Cmd Msg )
urlUpdate result model =
    let
        currentRoute =
            Routing.routeFromResult result
        updModel =
          { model | route = currentRoute }  
    in
        ( updModel
        , updCmd updModel 
        )

updCmd : Model -> Cmd Msg
updCmd m =
    case m.route of 
        MeetupsRoute ->
            Cmd.map MeetupsMsg (Meetups.commands m.meetups) 
        MeetupRoute id ->
            Cmd.map MeetupMsg (Meetup.commands id)
        CreateMeetupRoute ->
            Cmd.map CreateMeetupMsg (CreateMeetup.commands)
        _ ->
            Cmd.none 


subscriptions : Model -> Sub Msg 
subscriptions model =
    Sub.batch 
        [ Sub.map MeetupsMsg (Meetups.sub model.meetups)
        , Sub.map MeetupMsg (Meetup.sub model.meetup) 
        ]


main : Program Never
main =
    Navigation.program Routing.parser
        { init = init
        , view = view
        , update = update
        , urlUpdate = urlUpdate
        , subscriptions = subscriptions
        }
