class window._R_
  constructor: (@window = window)->
    @_stops = {}
    @change_callbacks = []
    @last = 'unknown'
    @current = 'unknown'
    @window.onresize = => do @update
  
  stops: (stops) -> 
    @_stops = stops
    do @update
  
  update : ->
    for stop, media_query of @_stops
      query = @window.matchMedia(media_query)
      @last = @current
      @current = stop if query.matches
      if @current isnt @last
        propagate_change_callbacks.call(this, @current, @last)

  is: (stop) -> 
    @current is stop

  isnt: (stop) -> 
    !@is(stop)

  change: (callback) ->
    if typeof callback isnt 'function'
      throw new TypeError "[R.change(callback)] callback must be a function"
    @change_callbacks.push callback  
        
  propagate_change_callbacks = (into, from)->
    for callback in @change_callbacks
      callback(into, from)
    
    
window.R = new _R_(window)