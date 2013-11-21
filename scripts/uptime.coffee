# Description:
#   Show status of sites monitored by UptimeRobot.
#
# Dependencies:
#   None
#
# Configuration:
#   HUBOT_UPTIMEROBOT_APIKEY
#
# Commands:
#   hubot uptime of <name>? - Show the status of <name>
#   hubot watch out for <url> as <name> - Instructs uptime robot to monitor the <url>
#
# Author:
#   pedrogimenez

module.exports = (robot) ->
  api_key = process.env.HUBOT_UPTIMEROBOT_APIKEY
  robot.respond /uptime of (.*)\?$/i, (msg) ->
    read_status msg, (monitor) ->
      status = if monitor.status is '2' then 'up' else 'down'
      msg.send "#{monitor.friendlyname}: has an uptime of #{monitor.alltimeuptimeratio}% and current status of #{status}"

  robot.respond /watch out for (.*) as (.*)$/i, (msg) ->
    new_status msg

  read_status = (msg, response_handler) ->
    msg.http('http://api.uptimerobot.com/getMonitors')
      .query({ apiKey: api_key, logs: 0, format: "json", noJsonCallback: 1 })
      .get() (err, res, body) ->
        response = JSON.parse(body)

        return unless response.monitors.monitor.length > 0

        for monitor in response.monitors.monitor
          continue unless monitor.friendlyname == msg.match[1]
          response_handler monitor
          return

        msg.send "Yo, I'm not watching for #{msg.match[1]}"

  new_status = (msg) ->
    msg.http("http://api.uptimerobot.com/newMonitor")
      .query({ apiKey: api_key, monitorFriendlyName: msg.match[2], monitorURL: msg.match[1], monitorType: 1, format: "json", noJsonCallback: 1 })
      .get() (err, res, body) ->
        response = JSON.parse(body)
        if response.stat is "ok"
          msg.send "Watching out for #{msg.match[2]}"
        else
          msg.send "#{response.message}"
