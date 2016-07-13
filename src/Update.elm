module Update exposing (..)

import Messages exposing (Msg(..))
import Models exposing (Model)

import Meetups.Update as Meetups
import Meetup.Main as Meetup
import Shared.Header as Header 
import Errors.Main as Errors




update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
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

        
        HeaderMsg subMsg ->
            let 
                (subModel, subCmd) = 
                    Header.update subMsg model.header 
            in
                ( model 
                , Cmd.map HeaderMsg subCmd 
                ) 
        
        ErrMsg subMsg ->
            let 
                errModel = 
                    Errors.update subMsg model.errors 
            in
                ( { model | errors = errModel }
                , Cmd.none
                )
