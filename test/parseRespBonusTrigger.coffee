require 'co-mocha'
chai = require 'chai'
assert = chai.assert

parser = require '../src/parseResponse'

describe 'Parse response', ->
  it 'Bonus trigger', ->
    str = '<?xml version="1.0" encoding="UTF-8"?>
          <ns15:bonusTriggerResponse
            xmlns:ns15="http://www.playtech.com/services/bonus"
            xmlns:ns23="http://www.playtech.com/services/common">
              <ns15:messageId>26403</ns15:messageId>
              <ns15:errorCode>0</ns15:errorCode>
              <ns15:result>1</ns15:result>
          </ns15:bonusTriggerResponse>'

    res = yield parser.giveBonus.promocode str
    assert.equal res, true, "Not true"

  it 'Bonus trigger error', ->
    str = '<?xml version="1.0" encoding="UTF-8"?>
          <ns15:bonusTriggerResponse
            xmlns:ns15="http://www.playtech.com/services/bonus"
            xmlns:ns23="http://www.playtech.com/services/common">
              <ns15:messageId>26403</ns15:messageId>
              <ns15:errorCode>24</ns15:errorCode>
              <ns15:result>3</ns15:result>
          </ns15:bonusTriggerResponse>'

    yield parser.giveBonus.promocode(str).catch ->

  it 'Bonus trigger not given', ->
    str = '<?xml version="1.0" encoding="UTF-8"?>
          <ns15:bonusTriggerResponse
            xmlns:ns15="http://www.playtech.com/services/bonus"
            xmlns:ns23="http://www.playtech.com/services/common">
              <ns15:messageId>26403</ns15:messageId>
              <ns15:errorCode>0</ns15:errorCode>
              <ns15:result>3</ns15:result>
          </ns15:bonusTriggerResponse>'

    yield parser.giveBonus.promocode(str).catch ->
