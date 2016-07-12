module Meetups.Update exposing (..)

import Meetups.Model exposing (Model) 
import Meetups.Messages exposing (Msg(..))


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of 
        FetchAllDone meetups ->
            ( {model | meetups = meetups}
            , Cmd.none
            )

        FetchAllFail err ->
            ( model 
            , Cmd.none
            )

        SearchQuery sq -> 
            ( {model | search = sq}
            , Cmd.none
            )

        FindMeetup ->
            ( model
            , Cmd.none
            )
