assert = require 'assert'

suite 'Derp', ()->
  test 'in coffee, on the server', (done, server)->
    server.eval ()->
      emit 'derp', 'a derp'
    server.once 'derp', (derp)->
      assert.equal derp, 'a derp'
      done()
