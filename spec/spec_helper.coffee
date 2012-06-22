chai.should()
mocha.setup
  ui: 'bdd'
  globals: []


window.context = window.describe

window.wait = (seconds, done, fn ) ->
  setTimeout ->
    fn()
    done()
  , seconds