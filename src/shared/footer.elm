module Shared.Footer exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, href, id, target)

view : Html msg
view =
  footer 
    [ id "footer"
    , class "uk-block uk-block-secondary uk-contrast uk-text-center"
    ]
    [ text "All code for this site is open source and written in Elm. "
    , a [ class "", href "https://github.com/romantis/book-club", target "_blank" ] [ text "Check it out!" ]
    , text " — © 2016 Roman Tischenko"
    ]

