# Description:
#   Peecol
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot pee
#
# Author:
#   pedrogimenez

module.exports = (robot) ->
  robot.router.post "/peecol", (req, res) ->
    robot.messageRoom req.body.room, req.body.message
    res.end "ok"
