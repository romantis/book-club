module Update exposing (..)

import Messages exposing (Msg(..))
import Models exposing (Model)

import Meetups.Update as Meetups
import Meetup.Main as Meetup
import Shared.Header as Header 
import CreateMeetup.Main as CreateMeetup



update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of

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

