e = require 'expect.js'
rediect = require('../lib/redirect');

describe 'redirect', ()->
  it 'success', (done)->
  	e(1).to.eql(1)
  	done()

