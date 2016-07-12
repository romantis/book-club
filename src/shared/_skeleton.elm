module Shared.Skeleton exposing (skeleton)

import Html exposing (..)
import Html.Attributes exposing (..)




(=>) = (,)

skeleton : String -> List (Html msg) -> Html msg
skeleton tabName content =
  div []
    (header' tabName :: content ++ [footer'])








        