module Update exposing (..)

import Messages exposing (Msg(..))
import Models exposing (Model)

import Routing exposing (Route(..))
import Meetups.Commands
import Meetups.Update as Meetups
import Meetup.Main as Meetup
import Shared.Header as Header 
import CreateMeetup.Main as CreateMeetup
import Ports exposing (loadmap)



update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        LocationUpd location ->
            let
                updRouteModel =
                    { model  | route = Routing.parser location }  
                
                newModel =
                    updModelHelper updRouteModel 
                
                newCmd =
                    updCmdHelper updRouteModel
            
            in
                ( newModel
                , newCmd
                )

        {- 
            Messages for Pages
        -}
        MeetupsMsg subMsg ->
            let 
                (subModel, subCmd) =
                    Meetups.update subMsg model.meetups
            in
                ( { model | meetups = subModel }
                , Cmd.map MeetupsMsg subCmd
                )

        MeetupMsg subMsg ->
            let 
                (subModel, subCmd) =
                    Meetup.update subMsg model.meetup 
            in 
                ( { model | meetup = subModel }
                , Cmd.map MeetupMsg subCmd
                )


        {-
            Messages For components
        -}
        HeaderMsg subMsg ->
            let 
                (subModel, subCmd) = 
                    Header.update subMsg model.header 
            in
                ( {model | header = subModel}
                , Cmd.map HeaderMsg subCmd 
                ) 
        
        CreateMeetupMsg subMsg ->
            let 
                (subModel, subCmd) = 
                    CreateMeetup.update subMsg model.createMeetup 
            in
                ( {model | createMeetup = subModel}
                , Cmd.map CreateMeetupMsg subCmd 
                ) 


updModelHelper : Model -> Model
updModelHelper model =
    case model.route of
        MeetupRoute id ->
            let 
                meetupModel =
                    model.meetup
                meetup =
                    {meetupModel | meetup = Meetup.getMaybeMeetup model.meetups.meetups id}
            in 
                {model | meetup = meetup} 
        
        _ ->  model


updCmdHelper : Model -> Cmd Msg
updCmdHelper m =
    case m.route of 
        MeetupsRoute ->
            Cmd.map MeetupsMsg <| Meetups.Commands.commands m.meetups 

        MeetupRoute id ->
            case Meetup.getMaybeMeetup m.meetups.meetups id of
                Just meetup ->
                    loadmap (meetup.place.longitude, meetup.place.latitude) 
                Nothing ->
                    Cmd.map MeetupMsg <| Meetup.commands id 
                      
        CreateMeetupRoute ->
            Cmd.map CreateMeetupMsg <| CreateMeetup.commands

        _ ->
            Cmd.none 
