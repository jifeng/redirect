os         = require "options-stream"
url        = require 'url'
path       = require 'path'
parse      = url.parse

class Redirect
  constructor: (options) ->
    @options = os {
      url: undefined
    }, options
    if @options.url
      @url = @options.url
      @url = @url.substr(0, @url.length - 1) if @url[@url.length - 1] is '/'
    @

  middleware : () ->
    (req, res, next) =>
      redirectURL = "#{@url}#{req.url}"
      res.statusCode = 302
      res.setHeader 'Location',  redirectURL
      return res.end();

module.exports = (options) ->
  new Redirect options