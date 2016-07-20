module Messages exposing (..)

import Meetups.Messages as Meetups
import Meetup.Main as Meetup
import Shared.Header as Header 
import CreateMeetup.Main as CreateMeetup

type Msg
  = MeetupsMsg Meetups.Msg
  | MeetupMsg Meetup.Msg 
  | HeaderMsg Header.Msg
  | CreateMeetupMsg CreateMeetup.Msg
  
