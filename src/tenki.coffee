# Description
#   A Hubot script that responds 'World!'
#
# Configuration:
#   None
#
# Commands:
#   hubot tenki - responds 'World!'
#
# Author:
#   yousan <yousan@gmail.com>
#
# Thanks:
#   hubot bouzuya <m@bouzuya.net>
#   weather http://qiita.com/kingpanda/items/ad745ba567b4524e132f
#   cron http://qiita.com/mats116/items/0164b37ffaa90f03f2a0

cronJob = require("cron").CronJob


module.exports = (robot) ->
# Seconds: 0-59
# Minutes: 0-59
# Hours: 0-23
# Day of Month: 1-31
# Months: 0-11
# Day of Week: 0-6
  new cronJob('0 45 7 * * * ', () =>
    envelope = room: "random" # 発言する部屋の名前
    # robot.send envelope, '[http://hoge.com|hoge] yahooo'
    # robot.emit 'slack.attachment', {room: 'times_yousan', text: '<https://github.com/link/to/a/PR|myrepo #42> fix some broken>'}

    # 地点定義表: http://weather.livedoor.com/forecast/rss/primary_area.xml
    # city=160010 : 富山市
    # city=230010 : 愛知県
    # city=070030 : 会津若松
    robot.send envelope, 'おはようございます。'
    tenki(robot, envelope, '160010')
    tenki(robot, envelope, '230010')
    tenki(robot, envelope, '070030')
    robot.send envelope, '今日も一日元気に過ごしましょう。'
    # console.log msg
  , null, true, 'Asia/Tokyo'
  ).start()

  robot.respond /Hello/i, (msg) ->
    msg.reply 'Hello World!'

  robot.hear /天気/i, (msg) ->
#    console.log(msg.message.user.room)
    envelope = room: msg.message.user.room
    envelope = room: 'room1'
    tenki(robot, envelope, '070030')

tenki = (robot, envelope, city) ->
  request = robot.http('http://weather.livedoor.com/forecast/webservice/json/v1?city='+city).get()
  request (err, res, body) ->
    json = JSON.parse body
    # how to make a link at slack
    # @link https://api.slack.com/docs/formatting#linking_to_urls
    # #{json['link']}
    msgs = """
           #{json['location']['city']}の天気は「#{json['forecasts'][0]['telop']}」最高気温は #{json['forecasts'][1]['temperature']['max']['celsius']}度, 最低気温 #{json['forecasts'][1]['temperature']['min']['celsius']}度です。
"""
#    msgs = json['link']
#    msgs += '富山市の今日の天気は「' + json['forecasts'][0]['telop'] + '」'
#    msgs += '最高気温は ' + json['forecasts'][1]['temperature']['max']['celsius'] + '度、最低気温は ' + json['forecasts'][1]['temperature']['min']['celsius'] + '度です。'
#    robot.send envelope, msgs
    console.log('hoge')
    robot.send envelope, msgs
