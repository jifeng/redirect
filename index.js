if (require.extensions['.coffee']) {
  module.exports = require('./lib/redirect.coffee');
} else {
  module.exports = require('./out/release/lib/redirect.js');
}
