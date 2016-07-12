module Members.Model exposing (..)


type alias MemberId =
    Int

type alias Member =
    { id : MemberId
    , name : String
    }

type alias Model =
    { members : List Member
    }

init =
    Model []