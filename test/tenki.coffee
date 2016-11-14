Helper = require('hubot-test-helper')
chai = require 'chai'

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

#  it 'Heard 天気', ->
#    @room.user.say('alice', '天気').then =>
#      expect(@room.messages).to.eql [
#        ['alice', '天気']
#        ['hubot', 'Yo man!']
#      ]

#  it 'responds to she add she ls', ->
#    @room.user.say('alice', '@hubot she add http://yahoo.co.jp 200').then =>
#      expect(@room.messages).to.eql [
#        ['alice', '@hubot she add http://yahoo.co.jp 200']
#        ['hubot', 'added 0: http://yahoo.co.jp, 200']
#      ]
