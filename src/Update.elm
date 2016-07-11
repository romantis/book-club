module Update exposing (..)

import Messages exposing (Msg(..))
import Models exposing (Model)
import Component.Main as Component

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    ComponentMsg subMsg ->
      ( { model 
          | component = Component.update subMsg model.component
        }
      , Cmd.none
      )