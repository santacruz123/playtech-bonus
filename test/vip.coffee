do require('dotenv').config
require 'co-mocha'
chai = require 'chai'
assert = chai.assert

Playtech = require '../src/index'

describe 'VIP', ->

  if not process.env.PT_CASINO?
    throw new Error "Missing PT_CASINO variable"

  if not process.env.PT_CERT?
    throw new Error "Missing PT_CERT variable"

  if not process.env.PT_KEY?
    throw new Error "Missing PT_KEY variable"

  if not process.env.PT_URL?
    throw new Error "Missing PT_URL variable"

  if not process.env.PT_TEST_USERNAME?
    throw new Error "Missing PT_TEST_USERNAME variable"

  pt = new Playtech
    casino: process.env.PT_CASINO
    cert: process.env.PT_CERT
    key: process.env.PT_KEY
    url: process.env.PT_URL

  pt.setUsername process.env.PT_TEST_USERNAME

  it 'Get', ->
    res = yield do pt.vip
    assert.isNumber res, "Balance not number"
    assert.isAbove res, 0, "Balance below zero"