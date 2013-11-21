# Description:
#   Rodent Motivation
#
#   Set the environment variable HUBOT_SHIP_EXTRA_SQUIRRELS (to anything)
#   for additional motivation
#
# Dependencies:
#   None
#
# Configuration:
#   HUBOT_SHIP_EXTRA_SQUIRRELS
#
# Commands:
#   ship it - Display a motivation squirrel
#
# Author:
#   maddox

squirrels = [
  "https://img.skitch.com/20111026-r2wsngtu4jftwxmsytdke6arwd.png",
  "http://images.cheezburger.com/completestore/2011/11/2/46e81db3-bead-4e2e-a157-8edd0339192f.jpg",
  "http://28.media.tumblr.com/tumblr_lybw63nzPp1r5bvcto1_500.jpg",
  "http://dl.dropbox.com/u/602885/github/sniper-squirrel.jpg",
  "http://1.bp.blogspot.com/_v0neUj-VDa4/TFBEbqFQcII/AAAAAAAAFBU/E8kPNmF1h1E/s640/squirrelbacca-thumb.jpg",
  "http://dl.dropbox.com/u/602885/github/soldier-squirrel.jpg",
  "http://f.cl.ly/items/0S1M2d1h0I132S082A05/flying-squirrel.gif",
  "http://i.qkme.me/3omp2t.jpg",
  "https://d233eq3e3p3cv0.cloudfront.net/max/700/0*1pfSx6tiDTDE7GWc.jpeg",
  "http://img11.imageshack.us/img11/6756/w09r.png"
]

module.exports = (robot) ->

  # Enable a looser regex if environment variable is set
  if process.env.HUBOT_SHIP_EXTRA_SQUIRRELS
    regex = /ship(ping|z|s|ped)? it/i
  else
    regex = /ship it/i

  robot.hear regex, (msg) ->
    msg.send msg.random squirrels
