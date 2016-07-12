module Members.Update exposing (..) 

-- import Http
import Members.Model exposing (Model)
import Members.Messages exposing(Msg(..))
-- import Navigation


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of 

        FetchAllDone members ->
            ( { model | members = members }
            , Cmd.none
            )

        FetchAllFail err ->
            ( model
            , Cmd.none
            )
