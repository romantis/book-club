module View exposing (..)

import Html exposing (Html, div, text)
import Html.App
import Messages exposing (Msg(..))
import Models exposing (Model)
import Routing exposing (Route(..))
import Component.Main as Component
import Navbar
import Home.Main as Home


view : Model -> Html Msg
view model =
    div [] ([Navbar.global ] ++ [ page model ])


page : Model -> Html Msg
page model =
    case model.route of
        HomeRoute ->
            Home.view

        ComponentRoute ->
            Html.App.map ComponentMsg (Component.view model.component)

        NotFoundRoute ->
            notFoundView


notFoundView : Html msg
notFoundView =
    div []
        [ text "Not found"
        ]
