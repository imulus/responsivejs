describe 'R', ->
  win = null

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
      win.resizeTo '400'
      wait 50, done, ->
        win.R.is('mobile').should.equal true
        
    it "returns false when browser is not in the bounds of a stop", (done) ->
      win.resizeTo '600'
      wait 50, done, ->
        win.R.is('mobile').should.equal false


  context 'isnt', ->
    it "returns true when browser is not in the bounds of a stop", (done) ->
      win.resizeTo '400'
      wait 50, done, ->
        win.R.isnt('tablet').should.equal true

    it "returns false when browser is in the bounds of a stop", (done) ->
      win.resizeTo '600'
      wait 50, done, ->
        win.R.isnt('tablet').should.equal false
