module Component.Main exposing (..)

import Html exposing (..)
-- import Html.Attributes exposing (class, value, href)
import Html.Events exposing (onClick)


type alias Model =
  { pageName : String
  , count : Int
  }
  
type Msg 
  = Inc

update : Msg -> Model -> Model
update msg model =
  case msg of 
    Inc ->
      { model 
        | count = model.count + 1}


--init : Model -> Model
--init model =
--  model

view : Model -> Html Msg
view model = 
  div 
    [] 
    [ h2 [] [ text ("hello from " ++ model.pageName)]
    , text (toString model.count)
    , button [onClick Inc] [text "+"]
    ]