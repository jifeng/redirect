if (require.extensions['.coffee']) {
  module.exports = require('./lib/rediret.coffee');
} else {
  module.exports = require('./out/release/lib/rediret.js');
}
