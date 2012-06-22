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
    var resize, win;
    win = null;
    resize = function(width, done, callback) {
      win.resizeTo("" + width, "600");
      if (!(done != null)) {
        return;
      } else if ((done != null) && !(callback != null)) {
        callback = done;
        done = function() {};
      }
      return wait(300, done, callback);
    };
    before(function() {
      win = window.open('/responsive');
      return win.R = new _R_(win);
    });
    after(function() {
      win.close();
      return win = null;
    });
    context('stops', function() {
      return it('sets the media queries stops', function(done) {
        win.R.stops({
          desktop: '(min-width: 980px)',
          tablet: '(min-width: 480px) and (max-width: 979px)',
          mobile: '(max-width: 480px)'
        });
        return resize(400, done, function() {
          return win.R.current.should.equal('mobile');
        });
      });
    });
    context('is', function() {
      it("returns true when browser is in the bounds of a stop", function(done) {
        return resize(400, done, function() {
          return win.R.is('mobile').should.equal(true);
        });
      });
      it("returns false when browser is not in the bounds of a stop", function(done) {
        return resize(600, done, function() {
          return win.R.is('mobile').should.equal(false);
        });
      });
      return it("returns false when fed an unknown stop", function(done) {
        return resize(400, done, function() {
          return win.R.is('wat').should.equal(false);
        });
      });
    });
    context('isnt', function() {
      it("returns true when browser is not in the bounds of a stop", function(done) {
        return resize(400, done, function() {
          return win.R.isnt('tablet').should.equal(true);
        });
      });
      it("returns false when browser is in the bounds of a stop", function(done) {
        return resize(700, done, function() {
          return win.R.isnt('tablet').should.equal(false);
        });
      });
      return it("returns true when fed an unknown stop", function(done) {
        return resize(400, done, function() {
          return win.R.isnt('wat').should.equal(true);
        });
      });
    });
    return context('change', function() {
      before(function() {
        return win.R.stops({
          desktop: '(min-width: 980px)',
          tablet: '(min-width: 480px) and (max-width: 979px)',
          mobile: '(max-width: 480px)'
        });
      });
      it("triggers a callback when the browser changes from one stop to another", function(done) {
        var callback;
        callback = function() {
          return callback.executed = true;
        };
        win.R.change(callback);
        return resize(1000, function() {
          return resize(700, done, function() {
            return callback.executed.should.equal(true);
          });
        });
      });
      it("passes the stop it came from and the stop it went into", function(done) {
        var callback;
        callback = function(into, from) {
          callback.into = into;
          return callback.from = from;
        };
        win.R.change(callback);
        return resize(700, function() {
          return resize(300, done, function() {
            callback.into.should.equal("mobile");
            return callback.from.should.equal("tablet");
          });
        });
      });
      return it("throws an error when the callback isn't a function", function() {
        (function() {
          return win.R.change("wat");
        }).should["throw"]();
        return (function() {
          return win.R.change();
        }).should["throw"]();
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
