module View exposing (view)

import Html exposing (Html, div, text, h1)
-- import Html.Attributes exposing (class)
import Html

import Messages exposing (Msg(..))
import Models exposing (Model)
import Routing exposing (Route(..), routeString)

import Meetups.View as Meetups
import Meetup.Main as Meetup
import CreateMeetup.Main as CreateMeetup
import NotFound.Main as NotFound

import Shared.Header as Header
import Shared.Footer as Footer


view : Model -> Html Msg
view model =
  div [] 
    [ Html.map HeaderMsg ( Header.view model.header)
    , page model
    , Footer.view 
    ] 


page : Model -> Html Msg
page model = 
    case model.route of 
        MeetupsRoute ->
            Html.map MeetupsMsg (Meetups.listView model.meetups)  
        
        MeetupRoute _ ->
            Html.map MeetupMsg (Meetup.view model.meetup )

        CreateMeetupRoute ->
            Html.map CreateMeetupMsg (CreateMeetup.view model.createMeetup)

        NotFoundRoute ->
            NotFound.view
