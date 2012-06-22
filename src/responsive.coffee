class window._R_
  constructor: (@window = window)->
    @stops = {}
  
  is: (stop) ->
    stop = @stops[stop]
    if stop?
      query = @window.matchMedia(stop)
      query.matches
    else
      false

  isnt: (stop)-> !@is(stop)

    
window.R = new _R_(window)