class window._R_
  constructor: (@window = window)->
    @stops = {}
  
  is: (stop) ->
    mq = @window.matchMedia(@stops[stop])
    mq.matches

  isnt: (stop)-> !@is(stop)

    
window.R = new _R_(window)