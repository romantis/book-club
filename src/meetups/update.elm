module Meetups.Update exposing (..)

import Navigation
import Meetups.Model exposing (Model) 
import Meetups.Messages exposing (Msg(..))
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
        
        
        ErrMsg subMsg ->
            let 
                errModel = 
                    Errors.update subMsg model.errors 
            in
                ( { model | errors = errModel }
                , Cmd.none
                )
