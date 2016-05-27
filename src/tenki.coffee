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


module.exports = (robot) ->
  new cron '* * * * * 1-5', () =>
    envelope = room: "random"
    request = msg.http('http://weather.livedoor.com/forecast/webservice/json/v1?city=160010')
    .get()
    request (err, res, body) ->
      json = JSON.parse body
      message = json['link']
      robot.send envelope, message
      message = '富山市の今日の天気は「' + json['forecasts'][0]['telop'] + '」'
      robot.send envelope, message
      message = '最高気温は ' + json['forecasts'][1]['temperature']['max']['celsius'] + '度、最低気温は ' + json['forecasts'][1]['temperature']['min']['celsius'] + '度です。'
      robot.send envelope, message
  , null, true, "Asia/Tokyo"