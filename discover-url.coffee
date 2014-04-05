system = require 'system'
[_, listing_page, filename, username] = system.args
password = system.env.PASSWORD
system.env.PASSWORD = ''

util = require './util'
page = util.page

util.log "Opening listing page..."
page.open listing_page, (status) ->
  util.log "Opened listing page: #{status}"
  util.handle_login_captcha ->
    util.log 'Searching URLs...'
    url = page.evaluate (filename) ->
      # Characters in filename may need to be escaped for use in a selector
      found = document.querySelector ".downloads.linux a[href*='#{filename}']"
      found?.getAttribute('href')
    , filename
    util.log "Found URL: #{url}"
    if url
      system.stdout.writeLine url
    phantom.exit()
  , username, password

