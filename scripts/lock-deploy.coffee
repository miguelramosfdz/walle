# Description:
#   Lock deployment and allow other to check status
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot lock deploy -- Returns a 'You can't deploy at the moment'
#   hubot unlock deploy -- Removes the prohibition to deploy
#   hubot can [i] deploy? -- Tells you if deployment is locked or not
#
# Author:
#   juanxo

module.exports = (robot) ->
  robot.respond /lock deploy/i, (msg) ->
    author = msg.message.user.name
    robot.brain.set('locker', author)
    msg.send "Ok, @#{author}, they shall not pass"

  robot.respond /unlock deploy/i, (msg) ->
    locker = robot.brain.get('locker')
    unless locker
      msg.send "Yo, it's not locked, u mad?"
    else if locker == msg.message.user.name
      robot.brain.set('locker', null)
      msg.send "Ok, I wouldn't let those packets deploy, but it's up to you"
    else
      msg.send "You have no powers over me, I'm a robot. Ask @#{locker} to unlock"

  robot.respond /can i? deploy\??/i, (msg) ->
    locker = robot.brain.get('locker')
    if locker
      msg.send "I'm sorry, but @#{locker} is on a critical mission right now"
    else
      msg.send "Yep, you are free to deploy"
