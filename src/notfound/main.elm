module NotFound.Main exposing (view)

import Html exposing (..)
import Html.Attributes exposing(class, href)


view : Html msg
view =
    div [ class "bc-min-height uk-block uk-block-large uk-text-center"
        ]
        [ h1 
            [ class "uk-heading-large uk-width-"] 
            [ text "Page Not Found"
            , text "  "
            , span [ class "uk-text-danger uk-h1"]
                [ text "Error 404"
                ] 
            ]
        , hr [] []
        , div [class "uk-width-small-1-3 uk-container-center"] 
            [ p [] [ text "The page you requested could not be found, either contact your webmaster or try again. Use your browsers Back button to navigate to the page you have prevously come from"]
            , p [] [ text "Or you could just press this neat little button:"]
            , a 
                [ href "/"
                , class "uk-button uk-button-primary"
                ] 
                [ i [class "uk-icon-home uk-margin-right"] []   
                , text "Go Home"
                ]
            ]
        ]


