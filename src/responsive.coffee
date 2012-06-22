class window._R_
  constructor: (@window = window)->
    @_stops = {}
    @current = 'unknown'
    @window.onresize = => do @update
  
  stops: (stops) -> 
    @_stops = stops
    do @update
  
  update : ->
    for stop, media_query of @_stops
      query = @window.matchMedia(media_query)
      @current = stop if query.matches

  is: (stop) -> 
    @current is stop

  isnt: (stop) -> 
    !@is(stop)

    
window.R = new _R_(window)