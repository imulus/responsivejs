describe 'R', ->
  win = null

  resize = (width, done, callback) ->
    win.resizeTo "#{width}", "600"
    wait 300, done, callback

  before -> 
    win = window.open('/responsive')
    win.R = new _R_(win)
    win.R.stops =
      desktop : '(min-width: 980px)'
      tablet  : '(min-width: 480px) and (max-width: 979px)'
      mobile  : '(max-width: 480px)'

  after -> 
    win.close()
    win = null
    
  context 'stops', ->
    it 'can be set', ->
      win.R.stops.should.be.an('object')

  context 'is', ->
    it "returns true when browser is in the bounds of a stop", (done) ->
      resize 400, done, ->
        win.R.is('mobile').should.equal true

    it "returns false when browser is not in the bounds of a stop", (done) ->
      resize 600, done, ->
        win.R.is('mobile').should.equal false
        
    it "returns false when fed an unknown stop", (done) ->
      resize 400, done, ->
        win.R.is('wat').should.equal false        


  context 'isnt', ->
    it "returns true when browser is not in the bounds of a stop", (done) ->
      resize 400, done, ->
        win.R.isnt('tablet').should.equal true
  
    it "returns false when browser is in the bounds of a stop", (done) ->
      resize 700, done, ->
        win.R.isnt('tablet').should.equal false

    it "returns true when fed an unknown stop", (done) ->
      resize 400, done, ->
        win.R.isnt('wat').should.equal true


      
