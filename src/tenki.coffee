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
# thanks!bouzuya <m@bouzuya.net>

module.exports = (robot) ->
  robot.hear /tenki/i, (msg) ->
    request = msg.http('http://weather.livedoor.com/forecast/webservice/json/v1?city=160010')
    .get()
    request (err, res, body) ->
      json = JSON.parse body
      message = json['link']
      msg.reply message
      message = '富山市の今日の天気は「' + json['forecasts'][0]['telop'] + '」'
      msg.reply message
      message = '最高気温は ' + json['forecasts'][1]['temperature']['max']['celsius'] + '度、最低気温は ' + json['forecasts'][1]['temperature']['min']['celsius'] + '度です。'
      msg.reply message
