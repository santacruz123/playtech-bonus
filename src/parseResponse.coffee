Promise = require 'bluebird'
{parseString} = require 'xml2js'
debug = require('debug')('playtech')

xmlParse = (xml) ->
  new Promise (resolve, reject) ->
    parseString xml, (err, res) ->
      reject err if err
      resolve res


parseBonusTriggerResponse = (xml) ->
  debug "Response - %s", xml
  xmlParse(xml).then (res) ->
    t = res['ns18:bonusTriggerResponse']
    err = "Response error #{t['ns18:errorCode']}"
    throw new Error err if +t['ns18:errorCode'][0] > 0
    throw new Error "Bonus not given" if +t['ns18:result'][0] isnt 1
    true

module.exports =
  vip: (xml) ->
    debug "Response - %s", xml
    xmlParse(xml).then (res) ->
      t = res['ns12:getPlayerInfoResponse2']
      err = "Response error #{t['ns12:errorCode']}"
      throw new Error err if +t['ns12:errorCode'][0] > 0
      +t['ns12:playerDataMap'][0]['ns12:vipLevel'][0]

  balance: (xml) ->
    debug "Response - %s", xml
    xmlParse(xml).then (res) ->
      t = res['ns32:getDynamicBalancesResponse']
      err = "Response error #{t['ns32:errorCode']}"
      throw new Error err if +t['ns32:errorCode'][0] > 0
      tmp = t['ns32:balances'][0]['ns32:dynamicBalance'][0]['ns23:balance'][0]
      amount: +tmp['ns23:amount'][0], currency: tmp['ns23:currencyCode'][0]

  giveBonus:
    buybonus: parseBonusTriggerResponse
    customevent: parseBonusTriggerResponse
    promocode: parseBonusTriggerResponse
    optin: (xml)->
      debug "Response - %s", xml
      xmlParse(xml).then (res) ->
        t = res['ns18:optInToBonusTemplateResponse']
        err = "Response error #{t['ns18:errorCode']}"
        throw new Error err if +t['ns18:errorCode'][0] > 0
    manual: (xml)->
      debug "Response - %s", xml
      xmlParse(xml).then (res) ->
        t = res['ns18:giveManualBonusResponse']
        err = "Response error #{t['ns18:errorCode']}"
        throw new Error err if +t['ns18:errorCode'][0] > 0
        +t['ns18:pendingBonusCode'][0]
