Helper = require('hubot-test-helper')
chai = require 'chai'

expect = chai.expect

helper = new Helper('../src/tenki.coffee')

describe 'Nurse', ->
  beforeEach ->
    @room = helper.createRoom()

  afterEach ->
    @room.destroy()

#  it 'responds to she ls', ->
#    @room.user.say('alice', '@hubot she ls').then =>
#      expect(@room.messages).to.eql [
#        ['alice', '@hubot she ls']
#        ['hubot', 'empty']
#      ]
#
#  it 'responds to she add she ls', ->
#    @room.user.say('alice', '@hubot she add http://yahoo.co.jp 200').then =>
#      expect(@room.messages).to.eql [
#        ['alice', '@hubot she add http://yahoo.co.jp 200']
#        ['hubot', 'added 0: http://yahoo.co.jp, 200']
#      ]