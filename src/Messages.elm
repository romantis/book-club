module Messages exposing (..)

import Meetups.Messages as Meetups
import Meetup.Main as Meetup
import Members.Messages as Members
import Shared.Header as Header 
import Errors.Main as Errors

type Msg
  = MeetupsMsg Meetups.Msg
  | MeetupMsg Meetup.Msg 
  | MembersMsg Members.Msg
  | HeaderMsg Header.Msg
  | ErrMsg Errors.Msg
