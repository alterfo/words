describe '500 words', ->

  beforeEach ->
    browser.get 'http://localhost:3000'

  it 'should have a title', ->
    expect(browser.getTitle()).toEqual '500 слов'

  it 'should show welcome', ->
    expect($('.jumbotron h1').getText())
      .toBe '500 слов'

  it 'should have register link', ->
    expect($('[href="/#!/signup"]').getText()).toBe 'Зарегистрироваться'

  it 'should have login link', ->
    expect($('[href="/#!/signin"]').getText()).toBe 'Войти'

  it 'should not have username', ->
    browser.driver.executeScript () ->
      window.user
    .then (result) ->
      expect(result).toBeFalsy()

  describe '500 words', ->

    it 'should be able to login', ->
      el = $('.nav [href="/#!/signin"]')
      if el.length
        el.click()
        form = $('form.signin')
        username = form.element(By.model('credentials.username'))
        password = form.element(By.model('credentials.password'))
        username.sendKeys 'demo'
        password.sendKeys 'demodemo'
        form.submit()
        browser.driver.executeScript () ->
          window.user
        .then (result) ->
          #todo: make more checks
          expect(result).toBeTruthy()
          expect(result.displayName).toBe('Demo Demo')

    it 'should be able to scroll monthes', ->
      #todo: scroll monthes

    it 'should be able to logout', ->
      el = $('.nav [href="/#!/signout"]')
      if el.length
        el.click()
        browser.driver.executeScript () ->
          window.user
        .then (result) ->
          expect(result).toBeFalsy()
          expect(result.displayName).toBe(undefined)
