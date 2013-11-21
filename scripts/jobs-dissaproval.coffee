# Description:
#   Jobs isn't proud of you
#
# Commands:
#   hubot jobs disapproves - Jobs ain't proud of you!

module.exports = (robot) ->
  robot.respond /jobs\s+disapproves/i, (msg) ->
    msg.send 'http://cdn.meme.li/i/fx4s6.jpg'
