# Description:
#   Example scripts for you to examine and try out.
#
# Notes:
#   They are commented out by default, because most of them are pretty silly and
#   wouldn't be useful and amusing enough for day to day huboting.
#   Uncomment the ones you want to try and experiment with.
#
#   These are from the scripting documentation: https://github.com/github/hubot/blob/master/docs/scripting.md

moment = require('moment')
momentTimezon = require('moment-timezone')

module.exports = (robot) ->
  robot.hear /^(l|list)$/, (res) ->
    messageText = '';
    users = robot.brain.users()
    for k, u of users
      if u.workingon
        messageText += "#{u.name} -- #{u.workingon}\n"
      else
        messageText += ""
    if messageText.trim() is "" then messageText = "Nobody told me a thing."
    res.send messageText

  robot.hear /^(\?|help)$/, (res) ->
    res.send "type + and your status to enter a status\ntype list for what everyone's status is\ntype ? or help for help\n"

  robot.hear /^\+(.+)/, (res) ->
    name = res.message.user.name
    user = robot.brain.userForName name
    timestamp = moment.utc().tz('America/Los_Angeles').format('MMM d ha z')

    if typeof user is 'object'
      user.workingon = "#{res.match[1]} (#{timestamp})"
      res.send "Okay #{user.name}, got it."
    else
      res.send "#{name} hasn't told me anything yet"
