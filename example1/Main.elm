module Main where

import StartApp.Simple exposing (start)
import Counter exposing (update, view)


main =
  start
    { model = 0
    , update = update
    , view = view
    }
