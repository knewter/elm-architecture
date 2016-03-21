module CounterList where

import Counter
import Html exposing (..)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)

type alias Model =
  { counters: List ( ID, Counter.Model )
  , nextID: ID
  }



init : Model
init =
  { counters = []
  , nextID = 0
  }


type alias ID = Int


type Action
  = Insert
  | Remove ID
  | Modify ID Counter.Action


update : Action -> Model -> Model
update action model =
  case action of
    Insert ->
      { model |
          counters = ( model.nextID, Counter.init 0 ) :: model.counters,
          nextID = model.nextID + 1
      }

    Remove id ->
      { model |
          counters = List.filter (\(counterID, _) -> counterID /= id) model.counters
      }

    Modify id counterAction ->
      let updateCounter (counterID, counterModel) =
        if counterID == id
           then (counterID, Counter.update counterAction counterModel)
           else (counterID, counterModel)
      in
         { model | counters = List.map updateCounter model.counters }


view : Signal.Address Action -> Model -> Html
view address model =
  let insert = button [ onClick address Insert ] [ text "Add" ]
  in
     div [] (insert ::  ++ counters)


viewCounter : Signal.Address Action -> (ID, Counter.Model) -> Html
viewCounter address (id, model) =
  Counter.view (Signal.forwardTo address (Modify id)) model
