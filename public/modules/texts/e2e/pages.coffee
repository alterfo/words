class LoginPage
  constructor: ->
    @username = element By.model('credentials.username')
    @password = element By.model('credentials.password')
    @login_button = element By.css 'form button[type=submit]'
    @login_error = element By.binding 'error'

  get: ->
    browser.get '/#!/signin'
    browser.getCurrentUrl()

  setUsername: (username) ->
    @username.clear()
    @username.sendKeys username
    @

  clearUsername: ->
    @username.clear()
    @

  setPassword: (password) ->
    @password.clear()
    @password.sendKeys(password)
    @

  clearPassword: ->
    @password.clear()

  login: ->
    @login_button.click()

  getErrorMessage: ->
    @login_error.getText()


