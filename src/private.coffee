xml = require 'xmlbuilder'

getUniqueTX = ->
  'TX' + do Math.random * Math.pow 10, 18

getXMLHelper = (obj)->
  do xml.create(obj).end

module.exports =
  parseResponseXML: require './parseResponse'
  getAPIEndpoint: (bonusType) ->
    switch bonusType
      when 'buybonus','customevent','manual'
        @url + '/product/ums/service/wallet/operation/buy-bonus'
      when 'optin'
        @url + '/product/ums/service/bonus/' +
          'operation/opt-in-to-bonus-template'
      when 'promocode'
        @url + '/product/ums/service/bonus/operation/bonus-trigger'
      else
        throw new Error "Unknown bonus type #{bonusType}"

  getRequestXML:
    vip: ->
      getXMLHelper
        getPlayerInfoRequest2:
          '@xmlns': 'http://www.playtech.com/services/player-management'
          requestType: 'marked'
          requestedPlayerData: 31

    balance: () ->
      getXMLHelper
        getDynamicBalancesRequest:
          '@xmlns': 'http://www.playtech.com/services/wallet'
          balanceTypes: 'real_gaming_balance'

    getBonuses: () ->
      #TODO getBonuses from playtech

    giveBonus:
      buybonus: (code, amount, currency = "GBP") ->
        throw new Error "Missing amount" if not amount?
        throw new Error "Missing code" if not code?

        getXMLHelper
          buyBonusRequest:
            '@xmlns': 'http://www.playtech.com/services/wallet'
            '@xmlns:ns3': 'http://www.playtech.com/services/common'
            transactionCode: do getUniqeTX
          amount:
            'ns3:amount': amount
            'ns3:currencyCode': currency
          parameters:
            templateCode: code

      customevent: (code) ->
        throw new Error "Missing code" if not code?

        getXMLHelper
          bonusTriggerRequest:
            '@xmlns': 'http://www.playtech.com/services/bonus'
            type: 'CustomEvent'
            parameters:
              eventName: code

      optin: (code) ->
        throw new Error "Missing code" if not code?

        getXMLHelper
          optInToBonusTemplateRequest:
            '@xmlns': 'http://www.playtech.com/services/bonus'
            templateCode: code

      promocode: (code) ->
        throw new Error "Missing code" if not code?

        getXMLHelper
          bonusTriggerRequest:
            '@xmlns': 'http://www.playtech.com/services/bonus'
            type: 'PromotionCode'
            parameters:
              promotionCode: code
              clientType: 'casino'

      manual: (code, amount, curr = 'GBP') ->
        throw new Error "Missing code" if not code?
        throw new Error "Missing amount" if not amount?

        getXMLHelper
          giveManualBonusRequest:
            '@xmlns': 'http://www.playtech.com/services/bonus'
            '@xmlns:ns2': 'http://www.playtech.com/services/common'
            templateId: code
            transactionCode: do getUniqueTX
            bonusType: 0
            description: 'who_bonus'
            amount:
              'ns2:amount': amount
              'ns2:currencyCode': curr

  headers: ->
    'Content-Type': 'application/xml'
    'X-Player-Username': @username
    'X-Casinoname': @casino
    'X-Auth-Type': 'AuthenticationByTrustedConnection'
    'X-Identity-Type': 'PlayerIdentityByCasinoAndUsername'
