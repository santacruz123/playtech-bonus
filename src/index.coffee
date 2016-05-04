fs = require 'fs'
request = require 'request-promise'
p = require './private'

module.exports = class Playtech
  constructor: (opt) ->
    throw new Error 'missing casino config' if not opt.casino?
    throw new Error 'missing cert config' if not opt.cert?

    @casino = opt.casino
    @cert = fs.readFileSync opt.cert

  setUsername: (@username) ->
  giveBonus: (opt) ->
    @asdfasdf
