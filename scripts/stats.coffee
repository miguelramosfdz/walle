# Description:
#   Show some fancy stats
#
# Dependencies:
#   None
#
# Configuration:
#   HUBOT_GRAPHITE_URL graphite public url
#
# Commands:
#   hubot stats <stat> - shows stats for <stat>
#
# Author:
#   pedrogimenez
#   juanxo

module.exports = (robot) ->
  base_stats_url = env.HUBOT_GRAPHITE_URL
  options = 'height=145&width=700&lineMode=connected&hideLegend=true&template=solarized-dark&bgcolor=white&drawNullAsZero=true&hideGrid=true&lineWidth=2&margin=10&tz=Europe/Madrid&format=png'

  robot.respond /stats (.*)$/i, (msg) ->
    stat = "statsite.kv.chicisimo.#{msg.match[1]}"
    msg.send "#{base_stats_url}/render?target=#{stat}&from=-24hours&#{options}"
