module Members.Messages exposing (..)

import Http

import Members.Model exposing(..) 


type Msg 
    = FetchAllDone (List Member)
    | FetchAllFail Http.Error
    -- | ShowMembers
    -- | ShowMember MemberId
