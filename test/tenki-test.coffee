Helper = require('hubot-test-helper')
chai = require 'chai'
Promise= require 'bluebird'
#co = require 'co'

expect = chai.expect

helper = new Helper('../src/tenki.coffee')

describe 'Tenki', ->
  beforeEach ->
    @room = helper.createRoom()

  afterEach ->
    @room.destroy()

  it 'responds to Hello', ->
    @room.user.say('alice', '@hubot Hello').then =>
      expect(@room.messages).to.eql [
        ['alice', '@hubot Hello']
        ['hubot', '@alice Hello World!']
      ]

  it 'responds to hetenki', ->
    @room.user.say('alice', '@hubot hetenki').then =>
      expect(@room.messages).to.eql [
        ['alice', '@hubot hetenki']
        ['hubot', 'hetenki!']
      ]

  # @link https://github.com/github/hubot/blob/master/docs/scripting.md#making-http-calls
  # @link https://github.com/mtsmfm/hubot-test-helper
#  context '天気', ->
#    beforeEach ->
#      co =>
#        @room.user.say 'me', '天気'
#        hoge = yield new Promise.delay(1000)
#
#    it 'heard 天気', ->
#      expect(@room.messages).to.eql [
#        ['me', '天気'],
#        ['hubot', 'Yo man!']
#      ]

#  it 'responds to she add she ls', ->
#    @room.user.say('alice', '@hubot she add http://yahoo.co.jp 200').then =>
#      expect(@room.messages).to.eql [
#        ['alice', '@hubot she add http://yahoo.co.jp 200']
#        ['hubot', 'added 0: http://yahoo.co.jp, 200']
#      ]
