module Meetups.Update exposing (..)

import Navigation
import Meetups.Model exposing (Model) 
import Meetups.Messages exposing (Msg(..))
import Shared.RandomColor as RColor
import Errors.Main as Errors


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of 
        FetchAllDone meetups ->
            ( {model | meetups = meetups}
            , Cmd.none
            )

        FetchAllFail err ->
            ( {model 
                | errors = Errors.addNew err model.errors
                } 
            , Cmd.none
            )
        
        Navigate url ->
            ( model
            , Navigation.newUrl url
            )

        SearchQuery sq -> 
            ( {model | search = sq}
            , Cmd.none
            )

        FindMeetup ->
            ( model
            , Cmd.none
            )
        
        
        RColorMsg subMsg ->
            let
                (subModel, subCmd) = 
                    RColor.update subMsg model.rColor
            in 
                ( { model | rColor = subModel }
                , Cmd.map RColorMsg subCmd
                )

        ErrMsg subMsg ->
            let 
                errModel = 
                    Errors.update subMsg model.errors 
            in
                ( { model | errors = errModel }
                , Cmd.none
                )
