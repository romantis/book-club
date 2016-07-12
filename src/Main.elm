module Main exposing (main)

import Navigation
import Messages exposing (Msg(..))
import Models exposing (Model, initialModel)
import View exposing (view)
import Update exposing (update)
import Routing exposing (Route(..))
import Members.Commands as Members
import Meetups.Commands as Meetups
import Meetup.Main as Meetup
import Errors.Main as Errors




init : Result String Route -> ( Model, Cmd Msg )
init result =
    let
        currentRoute =
            Routing.routeFromResult result
    in
        ( initialModel currentRoute
        , urlUpdCmd currentRoute 
        ) 


subscriptions : Model -> Sub Msg 
subscriptions model =
    Sub.map ErrMsg (Errors.sub model.errors)


urlUpdate : Result String Route -> Model -> ( Model, Cmd Msg )
urlUpdate result model =
    let
        currentRoute =
            Routing.routeFromResult result
    in
        ( { model | route = currentRoute }
        , urlUpdCmd currentRoute 
        )

urlUpdCmd : Route -> Cmd Msg
urlUpdCmd route =
    case route of 
        MeetupsRoute ->
            Cmd.map MeetupsMsg Meetups.fetch
        MeetupRoute id ->
            Cmd.map MeetupMsg (Meetup.fetch id)
        MembersRoute ->
            Cmd.map MembersMsg Members.fetch
        _ ->
            Cmd.none 


main : Program Never
main =
    Navigation.program Routing.parser
        { init = init
        , view = view
        , update = update
        , urlUpdate = urlUpdate
        , subscriptions = subscriptions
        }
