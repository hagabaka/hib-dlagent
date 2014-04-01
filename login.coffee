system = require 'system'
[_, login_page, username, password] = system.args

util = require './util'
page = util.page

page.open login_page, (status)->
  util.log "Opening login page: #{status}"
  util.handle_login_captcha ->
    phantom.exit()
  , username, password

