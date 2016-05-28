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
  new cronJob('45 7 * * * * ', () =>
    envelope = room: "times_yousan" # 発言する部屋の名前

    # 地点定義表: http://weather.livedoor.com/forecast/rss/primary_area.xml
    # city=160010 : 富山市
    # city=230010 : 愛知県
    # city=070030 : 会津若松
    request = robot.http('http://weather.livedoor.com/forecast/webservice/json/v1?city=160010')
    .get()
    request (err, res, body) ->
      json = JSON.parse body
      message = json['link']
      robot.send envelope, message
      message = '富山市の今日の天気は「' + json['forecasts'][0]['telop'] + '」'
      robot.send envelope, message
      message = '最高気温は ' + json['forecasts'][1]['temperature']['max']['celsius'] + '度、最低気温は ' + json['forecasts'][1]['temperature']['min']['celsius'] + '度です。'
      robot.send envelope, message
  ).start()

msg = (city) ->
  request = robot.http('http://weather.livedoor.com/forecast/webservice/json/v1?city=160010').get()
  request (err, res, body) ->
    json = JSON.parse body
    message = json['link']
    message += '富山市の今日の天気は「' + json['forecasts'][0]['telop'] + '」'
    message += '最高気温は ' + json['forecasts'][1]['temperature']['max']['celsius'] + '度、最低気温は ' + json['forecasts'][1]['temperature']['min']['celsius'] + '度です。'
