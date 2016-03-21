module Main where

import StartApp.Simple exposing (start)
import CounterPair exposing (init, update, view)


main =
  start
    { model = init 0 0
    , update = update
    , view = view
    }
