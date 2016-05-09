fs = require 'fs'
request = require 'request-promise'
p = require './private'
_ = require 'lodash'
module.exports = class Playtech
  constructor: (opt) ->
    throw new Error 'Missing casino option' if not opt.casino?
    throw new Error 'Missing cert option' if not opt.cert?
    throw new Error 'Missing key option' if not opt.key?
    throw new Error 'Missing url option' if not opt.url?

    @url = opt.url
    @casino = opt.casino
    @cert = fs.readFileSync opt.cert
    @key = fs.readFileSync opt.key

  setUsername: (@username) ->
  giveBonus: (opt, reqOptOverride) ->
    throw new Error "Missing username" if not @username?
    throw new Error "Missing bonus code" if not opt.code?

    if opt.type not in ['buybonus', 'optin', 'customevent', 'promocode']
      throw new Error "Unknown bonus type"

    if opt.type is 'buybonus' and not opt.amount
      throw new Error "Missing amount param"

    getBody = p.getRequestXML.giveBonus[opt.type]

    reqOpt =
      method: 'POST'
      uri: p.getAPIEndpoint.call @, opt.type
      body: getBody opt.code, opt.amount or= null, opt.curr or= null
      headers: p.headers.call @
      cert: @cert
      key: @key

    reqOpt = _.assign reqOpt, reqOptOverride

    request(reqOpt).then p.parseResponseXML.giveBonus[opt.type]
