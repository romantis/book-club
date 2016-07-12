module Errors.Main exposing (Model, init, Msg, update, view, sub, addNew)

import Html exposing (..)
import Html.Attributes exposing (style, href, class)
import Html.Events exposing (onClick)
import Http
import Time exposing (Time, second)
-- import Process exposing (sleep)



type alias Error =
    { text : String
    , id : Int
    }

type alias Model =
    { errors : List Error
    , nextId : Int
    }

init =
    Model [] 0

addNew : Http.Error -> Model -> Model
addNew err ( { errors, nextId } as model) =
    { model
        | errors = model.errors ++ [Error (errorType err) nextId ]
        , nextId = nextId + 1
    }


type Msg 
    = CloseMsg Int 
    | RemoveOld Time

 
-- Need to remove error after some time
update : Msg -> Model -> Model
update msg ({errors, nextId} as model) =
    case msg of 
        CloseMsg id ->
           { model | 
                errors = List.filter (\err -> err.id /= id) errors
           }

        RemoveOld _ ->
            { model |
                errors = List.drop 1 errors 
            } 

sub : Model -> Sub Msg
sub model = 
    if List.isEmpty model.errors then 
        Sub.none
    else 
        Time.every (5*second) RemoveOld 


(=>) = (,) 

view : Model -> Html Msg
view model = 
    if List.isEmpty model.errors then
        text "" 
    else 
        div [ errContainerStyle ] 
            (List.map errView model.errors) 

errView : Error -> Html Msg
errView err = 
    div [ errStyle ]
        [ p [] [ text err.text ]
        , i [ class "fa fa-close"
            , closeStyle
            , onClick (CloseMsg err.id)
            ] [] 
        ] 

errorType : Http.Error -> String
errorType err =
    case err of 
        Http.Timeout ->
            "Timeout problem"

        Http.NetworkError ->
            "Network Error"

        Http.UnexpectedPayload msg ->
            "unexpected payload" ++ msg

        Http.BadResponse code msg ->
            "Bad Responce code: " ++ toString code ++ " Message: " ++ msg



errContainerStyle = 
    style
        [ "position" => "fixed"
        , "top" => "55px"
        , "right" => "20px"
        , "background" => "white"
        ]

errStyle =
    style
        [ "position" => "relative"
        , "padding" => "0 1em"
        , "margin-top" => "2px"
        , "min-width" => "100px"
        , "min-width" => "1px"
        , "border" => "1px solid red"
        , "color" => "red"
        ]

closeStyle =
    style
        [ "position" => "absolute"
        , "top" => "1px"
        , "right" => "1px"
        , "text-decoration" => "none"
        , "color" => "red"
        ]


