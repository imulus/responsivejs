// Generated by CoffeeScript 1.3.3
(function() {

  chai.should();

  mocha.setup({
    ui: 'bdd',
    globals: []
  });

  window.context = window.describe;

  window.wait = function(seconds, done, fn) {
    return setTimeout(function() {
      fn();
      return done();
    }, seconds);
  };

}).call(this);
// Generated by CoffeeScript 1.3.3
(function() {

  describe('R', function() {
    var win;
    win = null;
    before(function() {
      win = window.open('/responsive');
      win.R = new _R_(win);
      return win.R.stops = {
        desktop: '(min-width: 980px)',
        tablet: '(min-width: 480px) and (max-width: 979px)',
        mobile: '(max-width: 480px)'
      };
    });
    after(function() {
      win.close();
      return win = null;
    });
    context('stops', function() {
      return it('can be set', function() {
        return win.R.stops.should.be.an('object');
      });
    });
    context('is', function() {
      it("returns true when browser is in the bounds of a stop", function(done) {
        win.resizeTo('400');
        return wait(50, done, function() {
          return win.R.is('mobile').should.equal(true);
        });
      });
      return it("returns false when browser is not in the bounds of a stop", function(done) {
        win.resizeTo('600');
        return wait(50, done, function() {
          return win.R.is('mobile').should.equal(false);
        });
      });
    });
    return context('isnt', function() {
      it("returns true when browser is not in the bounds of a stop", function(done) {
        win.resizeTo('400');
        return wait(50, done, function() {
          return win.R.isnt('tablet').should.equal(true);
        });
      });
      return it("returns false when browser is in the bounds of a stop", function(done) {
        win.resizeTo('600');
        return wait(50, done, function() {
          return win.R.isnt('tablet').should.equal(false);
        });
      });
    });
  });

}).call(this);
// Generated by CoffeeScript 1.3.3
(function() {

  $(function() {
    return mocha.run();
  });

}).call(this);
