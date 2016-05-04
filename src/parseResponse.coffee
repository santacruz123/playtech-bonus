Promise = require 'bluebird'
{parseString} = require 'xml2js'

xmlParse = (xml) ->
  new Promise (resolve, reject) ->
    parseString xml, (err, res) ->
      reject err if err
      resolve res

module.exports =
  balance: (xml) ->
    xmlParse(xml).then (res) ->
      t = res['ns32:getDynamicBalancesResponse']
      err = "Response error #{t['ns32:errorCode']}"
      throw new Error err if +t['ns32:errorCode'][0] > 0
      tmp = t['ns32:balances'][0]['ns32:dynamicBalance'][0]['ns23:balance'][0]

      amount: +tmp['ns23:amount'][0], currency: tmp['ns23:currencyCode'][0]

  giveBonus:
    buybonus: (xml)->
      #TODO
    customevent: (xml)->
      #TODO
    optin: (xml)->
      #TODO
    promocode: (xml)->
      xmlParse(xml).then (res) ->
        t = res['ns15:bonusTriggerResponse']
        err = "Response error #{t['ns15:errorCode']}"
        throw new Error err if +t['ns15:errorCode'][0] > 0
        throw new Error "Bonus not given" if +t['ns15:result'][0] isnt 1
        true
