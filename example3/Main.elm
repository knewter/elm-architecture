module Main where

import StartApp.Simple exposing (start)
import CounterList exposing (init, update, view)


main =
  start
    { model = init
    , update = update
    , view = view
    }
