module Shared.Center exposing (markdown, style)

import Html exposing (..)
import Html.Attributes as Attr exposing (..)
import Markdown


(=>) = (,)


markdown width string =
  div [ class "", style width ] [ Markdown.toHtml [] string ]


style width =
  Attr.style
    [ "display" => "block"
    , "width" => width
    , "margin" => "0 auto"
    ]