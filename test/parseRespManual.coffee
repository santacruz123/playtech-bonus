require 'co-mocha'
chai = require 'chai'

parser = require '../src/parseResponse'

describe 'Parse response - manual', ->
  it 'Success', ->
    str = '<?xml version="1.0" encoding="UTF-8"?>
              <ns15:giveManualBonusResponse
                    xmlns:ns15="http://www.playtech.com/services/bonus"
                    xmlns:ns23="http://www.playtech.com/services/common">
                  <ns15:messageId>86082</ns15:messageId>
                  <ns15:errorCode>0</ns15:errorCode>
                  <ns15:pendingBonusCode>41190830</ns15:pendingBonusCode>
                  <ns15:balanceUpdates>
                      <ns15:balanceUpdate>
                          <ns23:balanceVersion>53153</ns23:balanceVersion>
                          <ns23:balanceType>0</ns23:balanceType>
                          <ns23:delta>
                              <ns23:amount>2</ns23:amount>
                              <ns23:currencyCode>GBP</ns23:currencyCode>
                          </ns23:delta>
                          <ns23:fullBalance>
                              <ns23:amount>2.12</ns23:amount>
                              <ns23:currencyCode>GBP</ns23:currencyCode>
                          </ns23:fullBalance>
                          <ns23:showBalanceChange>true</ns23:showBalanceChange>
                      </ns15:balanceUpdate>
                  </ns15:balanceUpdates>
              </ns15:giveManualBonusResponse>'

    yield parser.giveBonus.manual str
