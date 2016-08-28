module Meetups.Update exposing (..)

import Navigation
import Date
import Regex exposing (regex, caseInsensitive)

import Meetups.Model exposing (Model) 
import Meetups.Messages exposing (Msg(..))
import Errors.Main as Errors


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of 

        FetchAllDone meetups ->
            let 
                filtered = 
                    List.filter (\m -> m.date >= model.now) meetups 
            in
                ({model 
                    | meetups = filtered
                    , filtered = filtered
                    }
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
            let 
                meetups =
                    if model.search == "" then 
                        model.meetups
                    else 
                        List.filter 
                            (\s -> Regex.contains (caseInsensitive <| regex sq) s.title)
                            model.meetups
            in
                ({model 
                    | search = sq
                    , filtered = meetups
                    , items = 6
                    }
                , Cmd.none
                )

        MoreMeetups ->
            ( {model | items = model.items*2} 
            , Cmd.none
            )
        
        NowDateFail _ ->
           (model , Cmd.none)
        
        NowDateSuccess date ->
            ( {model | now = Date.toTime date}
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
