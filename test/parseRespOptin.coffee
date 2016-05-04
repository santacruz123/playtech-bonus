require 'co-mocha'
chai = require 'chai'
assert = chai.assert

parser = require '../src/parseResponse'

describe 'Parse response', ->
  it 'Opt in', ->
    str = '<?xml version="1.0" encoding="UTF-8"?>
            <ns15:optInToBonusTemplateResponse
              xmlns:ns15="http://www.playtech.com/services/bonus"
              xmlns:ns23="http://www.playtech.com/services/common">
            <ns15:messageId>41129</ns15:messageId>
            <ns15:errorCode>0</ns15:errorCode>
          </ns15:optInToBonusTemplateResponse>'

    yield parser.giveBonus.optin str

  it 'Optin error code', ->
    str = '<?xml version="1.0" encoding="UTF-8"?>
            <ns15:optInToBonusTemplateResponse
              xmlns:ns15="http://www.playtech.com/services/bonus"
              xmlns:ns23="http://www.playtech.com/services/common">
            <ns15:messageId>41129</ns15:messageId>
            <ns15:errorCode>3</ns15:errorCode>
          </ns15:optInToBonusTemplateResponse>'

    yield parser.giveBonus.optin(str).catch ->
