module NotFound.Main exposing (view)

import Html exposing (..)
import Html.Attributes exposing(class, href)


view : Html msg
view =
    div [ class ""]
        [ h1 [ class ""] [text "Not found"]
        , a [ href "/"] [ text "go home"]
        ]


