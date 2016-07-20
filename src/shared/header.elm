module Shared.Header exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, classList,  href, id)
import Html.Events exposing (onClick)

import Navigation

(=>) : a -> b -> ( a, b )
(=>) = (,)



type alias Model =
    { pageRoute : String
    , logged : Bool
    }


type Msg 
    = ToggleLogIn
    | Navigate String

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        
        ToggleLogIn ->
            ( { model | logged = not model.logged}
            , Cmd.none
            )
        
        Navigate url ->
            ( model
            , Navigation.newUrl ("#" ++ url)
            -- , Navigation.modifyUrl url
            )




init : String -> Model
init route = 
    Model route False


view : Model -> Html Msg
view model =
  header [ id "header"]
    [ nav [ class "uk-navbar" ]
      [ a [ onClick <| Navigate "/"
        --   , href "#"
          , class "uk-navbar-brand"
          ]
          [ text "BookClub" ]
      , ul [ class "uk-navbar-nav" ] 
          (List.map (navItem model.pageRoute) [ "meetups" ])
      , logInView model.logged
      ]
    ]


navItem : String -> String -> Html Msg
navItem currentRoute route =
  li [ classList ["uk-active" => (currentRoute == route) ] ]
    [ a 
        [ onClick <| Navigate route
        --  How no prevent default?
        -- , href (route)
        ]
        [ text route ]
    ]


logInView : Bool -> Html Msg
logInView isLogged = 
  div [ class "uk-navbar-flip"]
  [ ul [ class "uk-navbar-nav" ]
      [ logInToggle isLogged
      ]
    ] 

logInToggle : Bool -> Html Msg
logInToggle isLogged =
    if isLogged then
        div [ class "uk-navbar-content"] 
            [ button 
              [ class "uk-button uk-button-primary" 
              , onClick (Navigate "create")
              ]
              [ text "Create"]
            , button 
                [ onClick ToggleLogIn
                , class "uk-button"
                ] 
                [ i [ class "uk-icon-sign-out justify"] []
                , text " "
                , text "Sign Out"
                ] 
            ]
    else
        div [ class "uk-navbar-content"] 
            [ button 
                [ onClick ToggleLogIn
                , class "uk-button uk-button-success"
                ] 
                [ i [ class "uk-icon-sign-in justify"] []
                , text " "
                , text "Sign In"
                ] 
            ]

