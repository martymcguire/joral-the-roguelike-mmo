var assert = require('assert');

suite('Derp', function() {
  test('in the server', function(done, server) {
    server.eval(function() {
      emit('derp', 'a derp');
    });
    server.once('derp', function(derp) {
      assert.equal(derp, 'a derp');
      done();
    });
  });
});
