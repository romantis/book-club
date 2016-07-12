module View exposing (view)

import Html exposing (Html, div, text, h1)
-- import Html.Attributes exposing (class)
import Html.App as App

import Messages exposing (Msg(..))
import Models exposing (Model)
import Routing exposing (Route(..), routeString)

import Meetups.View as Meetups
import Meetup.Main as Meetup
import Members.View as Members
import NotFound.Main as NotFound

import Shared.Header as Header
import Shared.Footer as Footer
import Errors.Main as Errors


view : Model -> Html Msg
view model =
  div [] 
    [ App.map HeaderMsg ( Header.view model.header)
    , page model
    , App.map ErrMsg (Errors.view model.errors)
    , Footer.view 
    ] 


page : Model -> Html Msg
page model = 
    case model.route of 
        MeetupsRoute ->
            App.map MeetupsMsg (Meetups.listView model.meetups)  
        
        MeetupRoute _ ->
            App.map MeetupMsg (Meetup.view model.meetup )

        MembersRoute ->
            App.map MembersMsg (Members.view model.members) 

        NotFoundRoute ->
            NotFound.view
