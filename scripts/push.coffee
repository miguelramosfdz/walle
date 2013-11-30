# Description:
#   Add your token to our push notifications app
#
# Dependencies:
#   None
#
# Commands:
#   hubot push me <token> <regexp> - add your token
#
# Author:
#   pedrogimenez

module.exports = (robot) ->
  robot.respond /push me (.*) (.*)$/i, (msg) ->
      add_observer msg

  add_observer = (msg) ->
      token = msg.match[1]
      regexp = msg.match[2]

      if observers = robot.brain.get('observers')
        observers[token] = regexp
      else
        setup_observer token, regexp

      msg.send('Cool. Now you\'ll receive pings.')

  setup_observer = (token, regexp) ->
      observer = {}
      observer[token] = regexp
      robot.brain.set('observers', observer)
