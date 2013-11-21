# Description:
#   Show the commiters from a repo
#
# Dependencies:
#   "githubot": "0.4.x"
#
# Configuration:
#   HUBOT_GITHUB_TOKEN
#   HUBOT_GITHUB_API
#
# Commands:
#   hubot commiters for [<owner>/]<repo> - shows commiters of repository
#   hubot mvp for [<owner>/]<repo> - shows top commiter of repository
#
# Notes:
#   HUBOT_GITHUB_API allows you to set a custom URL path (for Github enterprise users)
#
# Author:
#   vquaiato
#   pedrogimenez

module.exports = (robot) ->
  github = require("githubot")(robot)
  robot.respond /commiters (for )?(?:(.*?)\/)?(.*?)$/i, (msg) ->
      read_contributors msg, (commits) ->
          max_length = commits.length
          max_length = 20 if commits.length > 20

          commiters = commits.sort (commiter_one, commiter_two) ->
            commiter_two.contributions - commiter_one.contributions

          message = "#{commiters.length} commiters found:\n"
          for commit in commiters
            message += "#{commit.login} has #{commit.contributions} commits\n"
            max_length -= 1
            break unless max_length

          msg.send(message)

  robot.respond /mvp (for )?(?:(.*?)\/)?(.*?)$/i, (msg) ->
      read_contributors msg, (commits) ->
          top_commiter = null
          for commit in commits
            top_commiter = commit if top_commiter == null
            top_commiter = commit if commit.contributions > top_commiter.contributions 
          msg.send "#{top_commiter.login} is our MVP with #{top_commiter.contributions} commits :trophy:"

  read_contributors = (msg, response_handler) ->
      if msg.match[2]
        repo = "#{msg.match[2]}/#{msg.match[3]}"
      else
        repo = github.qualified_repo msg.match[3]

      base_url = process.env.HUBOT_GITHUB_API || 'https://api.github.com'
      url = "#{base_url}/repos/#{repo}/contributors"
      github.get url, (commits) ->
        if commits.message
          msg.send "Achievement unlocked: [NEEDLE IN A HAYSTACK] repository #{commits.message}!"
        else if commits.length == 0
          msg.send "Achievement unlocked: [LIKE A BOSS] no commits found!"
        else
          if process.env.HUBOT_GITHUB_API
            base_url = base_url.replace /\/api\/v3/, ''
          response_handler commits
