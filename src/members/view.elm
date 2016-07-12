module Members.View  exposing (view)

import Html exposing (..)
import Html.Attributes as Attr exposing (class, style, src)

import Members.Model exposing (Model)
import Members.Messages exposing (Msg(..))

view : Model -> Html Msg
view model =
    listView model.members


-- heading =
--     section [ class "" ]
--         [ h1 [] [ text "Members of Bookclub"]
--         ]

listView members =
    if List.isEmpty members then 
        div [ style [("padding", "2em")]]
            [ img [ src "/images/spinner.gif"] []
            ]
    else
        ul []
            (List.map (\m -> li [] [ text m.name ]) members )


