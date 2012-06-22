describe 'R', ->
  win = null

  resize = (width, done, callback) ->
    win.resizeTo "#{width}", "600"
    if !done?
      return
    else if done? and !callback?
      callback = done
      done = ->
    wait 70, done, callback

  before (done) ->
    win = window.open('/responsive')
    win.R = new _R_(win)
    wait 500, done, ->

  after ->
    win.close()
    win = null
    
    
  context ".stops({stops})", ->
    it 'sets the media queries stops', (done) ->
      win.R.stops
        desktop : '(min-width: 980px)'
        tablet  : '(min-width: 480px) and (max-width: 979px)'
        mobile  : '(max-width: 480px)'
      resize 400, done, ->
        win.R.current.should.equal 'mobile'
  
  
  context ".is('stop')", ->
    it "returns true when browser is in the bounds of a stop", (done) ->
      resize 400, done, ->
        win.R.is('mobile').should.equal true
  
    it "returns false when browser is not in the bounds of a stop", (done) ->
      resize 600, done, ->
        win.R.is('mobile').should.equal false
  
    it "returns false when fed an unknown stop", (done) ->
      resize 400, done, ->
        win.R.is('wat').should.equal false
  
  
  context ".isnt('stop')", ->
    it "returns true when browser is not in the bounds of a stop", (done) ->
      resize 400, done, ->
        win.R.isnt('tablet').should.equal true
  
    it "returns false when browser is in the bounds of a stop", (done) ->
      resize 700, done, ->
        win.R.isnt('tablet').should.equal false
  
    it "returns true when fed an unknown stop", (done) ->
      resize 400, done, ->
        win.R.isnt('wat').should.equal true
  
  
  context ".change(fn callback(into, from))", ->
    before ->
      win.R.stops
        desktop : '(min-width: 980px)'
        tablet  : '(min-width: 480px) and (max-width: 979px)'
        mobile  : '(max-width: 480px)'
  
    it "triggers a callback when the browser changes from one stop to another", (done) ->
      callback = ->
        callback.executed = true
      win.R.change callback
  
      resize 1000, ->
        resize 700, done, ->
          callback.executed.should.equal true
  
  
    it "passes the stop it came from and the stop it went into", (done) ->
      callback = (into, from) ->
        callback.into = into
        callback.from = from
  
      win.R.change callback
  
      resize 700, ->
        resize 300, done, ->
          callback.into.should.equal "mobile"
          callback.from.should.equal "tablet"
  
  
    it "throws an error when the callback isn't a function", ->
      (-> win.R.change "wat" ).should.throw()
      (-> win.R.change() ).should.throw()
  
  
  
  
  context ".from('stop', fn callback(into))", ->
    before ->
      win.R.stops
        desktop : '(min-width: 980px)'
        tablet  : '(min-width: 480px) and (max-width: 979px)'
        mobile  : '(max-width: 480px)'
        
    it "triggers a callback when the browser changes out of a specified stop", (done) ->
      callback = ->
        callback.executed = true
      win.R.from 'desktop', callback
  
      resize 1000, ->
        resize 700, done, ->
          callback.executed.should.equal true    
  
  
    it "passes the stop the browser went into", (done) ->
      callback = (into) ->
        callback.into = into
    
      win.R.from 'desktop', callback
    
      resize 1000, ->
        resize 700, done, ->
          callback.into.should.equal "tablet"
  
    it "throws an error when the callback isn't a function", ->
      (-> win.R.from "desktop", "wat" ).should.throw()
      (-> win.R.from("desktop") ).should.throw()
      
      
      
  context ".into('stop', fn callback(into))", ->
    before ->
      win.R.stops
        desktop : '(min-width: 980px)'
        tablet  : '(min-width: 480px) and (max-width: 979px)'
        mobile  : '(max-width: 480px)'

    it "triggers a callback when the browser changes into of a specified stop", (done) ->
      callback = ->
        callback.executed = true
      win.R.into 'tablet', callback

      resize 1000, ->
        resize 700, done, ->
          callback.executed.should.equal true    


    it "passes the stop the browser came from", (done) ->
      callback = (from) ->
        callback.from = from
    
      win.R.into 'tablet', callback
    
      resize 1000, ->
        resize 700, done, ->
          callback.from.should.equal "desktop"
    
    it "throws an error when the callback isn't a function", ->
      (-> win.R.into "desktop", "wat" ).should.throw()
      (-> win.R.into("desktop") ).should.throw()
    
    
      