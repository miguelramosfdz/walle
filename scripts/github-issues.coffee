# Description:
#   Show open issues from a Github repository
#
# Dependencies:
#   "githubot": "0.4.0"
#
# Configuration:
#   HUBOT_GITHUB_TOKEN
#   HUBOT_GITHUB_USER
#   HUBOT_GITHUB_API
#
# Commands:
#   hubot issues [for] <repo> -- List all issues for given repo chicisimo/<repo>
#   hubot issues [for] <user/repo> -- List all issues for given repo
#
# Notes:
#   HUBOT_GITHUB_API allows you to set a custom URL path (for Github enterprise users)
#
# Author:
#   pedrogimenez

module.exports = (robot) ->
  github = require("githubot")(robot)
  robot.respond /issues (for )?(?:(.*?)\/)?(.*?)$/i, (msg) ->

    read_issues msg, (issues) ->
      if msg.match[2]
        issue_context = "#{msg.match[2]}/#{msg.match[3]}"
      else
        issue_context = msg.match[3]
      for issue in issues
        msg.send "#{issue_context}##{issue.number} #{issue.title}: #{issue.html_url}"

  read_issues = (msg, response_handler) ->
    if msg.match[2]
      repo = "#{msg.match[2]}/#{msg.match[3]}"
    else
      repo = github.qualified_repo msg.match[3]

    base_url = process.env.HUBOT_GITHUB_API || 'https://api.github.com'
    parameters = { state: 'open', sort: 'created' }
    github.get "#{base_url}/repos/#{repo}/issues", parameters, (issues) ->
      unless issues.length > 0
        msg.send "No issues found. Great job! :heart:"
        return

      issues = issues.filter (issue) -> !issue.pull_request.html_url
      response_handler issues
