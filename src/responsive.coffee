class window._R_
  constructor: (@window = window)->
    @_stops = {}
    @_callbacks = 
      change: []
      from: {}
      into: {}
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
    @_callbacks.change.push callback  
  
  
  from: (stop, callback) ->
    if typeof callback isnt 'function'
      throw new TypeError "[R.from(stop, callback)] callback must be a function"
    unless @_callbacks.from[stop]?
      @_callbacks.from[stop] = []
    @_callbacks.from[stop].push callback
  
  
  into: (stop, callback) ->
    if typeof callback isnt 'function'
      throw new TypeError "[R.into(stop, callback)] callback must be a function"
    unless @_callbacks.into[stop]?
      @_callbacks.into[stop] = []
    @_callbacks.into[stop].push callback  
  
  
  # private
        
  propagate_change_callbacks = (into, from)->
    for callback in @_callbacks.change
      callback(into, from)
    
    for stop, callbacks of @_callbacks.from
      for callback in callbacks
        callback(into) if stop is from

    for stop, callbacks of @_callbacks.into
      for callback in callbacks
        callback(from) if stop is into
    
    
window.R = new _R_(window)