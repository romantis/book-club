module Shared.Helpers exposing (..)

import Html exposing (Attribute)
import Html.Events exposing (onWithOptions, defaultOptions)
import Json.Decode as Json exposing (succeed)

hrefClick : (String -> msg) -> String -> Attribute msg
hrefClick msg url =
    onWithOptions 
        "click"  
        {defaultOptions | preventDefault = True }
        (succeed (msg url))
