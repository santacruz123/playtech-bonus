require 'co-mocha'
chai = require 'chai'
assert = chai.assert

parser = require '../src/parseResponse'

describe 'Parse response', ->
  it 'Balance', ->

    str = '<?xml version="1.0" encoding="UTF-8"?>
      <ns32:getDynamicBalancesResponse
        xmlns:ns32="http://www.playtech.com/services/wallet"
        xmlns:ns23="http://www.playtech.com/services/common">
      <ns32:messageId>80518</ns32:messageId>
      <ns32:errorCode>0</ns32:errorCode>
      <ns32:responseTimestamp>2016-04-19 11:47:56.496</ns32:responseTimestamp>
      <ns32:balances>
          <ns32:dynamicBalance>
              <ns23:balanceType>real_gaming_balance</ns23:balanceType>
              <ns23:balance>
                  <ns23:amount>5.32</ns23:amount>
                  <ns23:currencyCode>GBP</ns23:currencyCode>
              </ns23:balance>
          </ns32:dynamicBalance>
      </ns32:balances>
      </ns32:getDynamicBalancesResponse>'

    res = yield parser.balance str
    assert.deepEqual res, {amount: 5.32, currency: 'GBP'}
