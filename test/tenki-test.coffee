Helper = require('hubot-test-helper')
chai = require 'chai'
Promise= require 'bluebird'
co = require 'co'
nock = require 'nock'

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

#  it 'responds to xmltest', ->
#    @room.user.say('me', 'xmltest').then =>
#      expect(@room.messages).to.eql [
#        ['me', 'xmltest']
#        ['hubot', 'Salut xml2js!']
#      ]


  # @link https://github.com/github/hubot/blob/master/docs/scripting.md#making-http-calls
  # @link https://github.com/mtsmfm/hubot-test-helper
  context 'user says 天気 to hubot', ->
    beforeEach ->
      do nock.disableNetConnect
      nock('http://pugme.herokuapp.com')
        .get('/random')
        .reply 200, { pug: 'http://imgur.com/pug.png' }
      nock('http://weather.livedoor.com')
        .get('/forecast/webservice/json/v1?city=070030')
      .reply 200, {
        location: {
          city: '若松',
        },
        forecasts: [
          {telop: '本日は晴天なり'},
          {temperature: {
            max: {celsius: '45'},
            min: {celsius: '-200'}
          }
          }
        ]
      }

      co =>
        @room.user.say 'me', '天気'
        hoge = yield new Promise.delay(1000)

    it 'should reply about tenki', ->
      expect(@room.messages).to.eql [
        ['me', '天気']
        ['hubot', '若松の天気は「本日は晴天なり」最高気温は 45度, 最低気温 -200度です。']
      ]

#  context 'Sync test', ->
#    beforeEach ->
#      co =>
#        yield @room.user.say 'user1', 'http://gogole.com'
#        yield new Promise.delay(1000)
#
#      it 'expects delayed callback from ok2', ->
#        console.log @room.messagesexpect(@room.messages).to.eql [
#          ['user1', 'http://google.com']
#          ['hubot', 'ok1: http://google.com']
#          ['hubot', 'ok2: http://google.com']
#        ]

  context 'user says hi to hubot', ->
    beforeEach ->
      co =>
        yield @room.user.say 'alice', '@hubot hi'
        yield @room.user.say 'bob',   '@hubot hi'

    it 'should reply to user', ->
      expect(@room.messages).to.eql [
        ['alice', '@hubot hi']
#        ['hubot', '@alice hi']
        ['bob',   '@hubot hi']
#        ['hubot', '@bob hi']
      ]

#  it 'responds to she add she ls', ->
#    @room.user.say('alice', '@hubot she add http://yahoo.co.jp 200').then =>
#      expect(@room.messages).to.eql [
#        ['alice', '@hubot she add http://yahoo.co.jp 200']
#        ['hubot', 'added 0: http://yahoo.co.jp, 200']
#      ]

