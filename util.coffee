system = require('system')

# prints a log message if the LOG environment variable is set
if system.env.LOG?
  exports.log = log = (message) ->
    system.stderr.writeLine "#{new Date().toString()} #{message}"
else
  exports.log = log = ->

# prints a message to stderr, reads a line of input, and returns the input
exports.ask = ask = (message) ->
  system.stderr.write message
  system.stdin.readLine()

# a page that directs its console messages to exportss.log
exports.page = page = require('webpage').create()
page.onConsoleMessage = log

child_process = require('child_process')

# displays a screenshot of the page, and returns the 'display' process object
exports.display_screenshot = display_screenshot = ->
  # FIXME use mktemp, or write to display process directly
  screenshot = '/tmp/hib-dlagent-phantomjs.png'
  page.render screenshot
  child_process.spawn 'display', [screenshot]

# handles login/captcha boxes, and calls the passed action() when logged in
exports.handle_login_captcha = handle_login_captcha = (action, username, password) ->
  need_to_submit = false

  # complete a login form if there is one
  if page.evaluate(-> document.querySelector 'input[name="username"]')
    log 'Entering login information...'
    page.evaluate (username, password) ->
      username_box = document.querySelector 'input[name="username"]'
      password_box = document.querySelector 'input[name="password"]'
      if username_box
        username_box.value = username
      if password_box
        password_box.value = password
    , username, password
    need_to_submit = true

  # handle a captcha box if there is one
  if page.evaluate(-> document.querySelector '#recaptcha_response_field')
    log 'Humble Bundle wants you to solve a captcha. Displaying screenshot...'
    display_process = display_screenshot()
    input = ask 'Enter the captcha solution, or press Enter to get a new challenge: '
    display_process.kill()

    page.evaluate (input)->
      if input is ''
        Recaptcha.reload()
      else
        captcha_box = document.querySelector '#recaptcha_response_field'
        captcha_box.value = input
    , input
    need_to_submit = true

  if need_to_submit
    # Entered information, submit and check for captcha/login again after load finishes
    log 'Submitting login information and/or captcha response...'
    page.onLoadFinished = -> handle_login_captcha action, username, password
    page.evaluate ->
      form = document.querySelector('form')
      if form
        form.submit()
  else
    log 'Logged in...'
    action()

