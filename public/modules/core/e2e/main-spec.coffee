
Pages = require './pages'
Mocks = require './mocks'

describe 'Aughentication', ->
  ptor = protractor.getInstance()
  ptor.addMockModule 'httpBackendMock', Mocks.httpBackendMock
  login_page = new Pages.LoginPage()


  it

#
#
#
#
#
#describe '500 words', ->
#
#  it 'should have a title, welcome message, register and login link and should not have username', ->
#    browser.get 'http://localhost:3000'
#    expect(browser.getTitle()).toEqual '500 слов'
#    expect($('.jumbotron h1').getText())
#      .toBe '500 слов'
#    expect($('[href="/#!/signup"]').getText()).toBe 'Зарегистрироваться'
#    expect($('[href="/#!/signin"]').getText()).toBe 'Войти'
#    browser.driver.executeScript () ->
#      window.user
#    .then (result) ->
#      expect(result).toBeFalsy()
#
#  describe '500 words', ->
#
#    browser.get 'http://localhost:3000'
#
#    it 'should be able to login', ->
#      el = $('.nav [href="/#!/signin"]')
#      if el.length
#        el.click()
#        form = $('form.signin')
#        username = form.element(By.model('credentials.username'))
#        password = form.element(By.model('credentials.password'))
#        username.sendKeys 'demo'
#        password.sendKeys 'demodemo'
#        form.submit()
#        browser.driver.executeScript () ->
#          window.user
#        .then (result) ->
#          expect(result).toBeTruthy()
#          expect(result.displayName).toBe('Demo Demo')
#
#    it 'has properly working timeline', ->
#      expect($('.timeline')).toBeDefined()
#      $$('li.item .timeline__date').then (items) ->
#        expect(items.length).toBeGreaterThan(20)
#
#
#
#    it 'has properly working text input', ->
#      textinput = element(By.model('text'))
#      timeline = element(By.css('.timeline'))
#
#      expect(textinput).toBeDefined()
#      browser.pause()
#      textinput.sendKeys('Тестовый текст ')
#
#      timeline.evaluate('days').then (value) ->
#        console.log value
#
#
#
#
#
#
#
#
#    it 'should be able to logout', ->
#      el = $('.nav [href="/#!/signout"]')
#      if el.length
#        el.click()
#        browser.driver.executeScript () ->
#          window.user
#        .then (result) ->
#          expect(result).toBeFalsy()
#          expect(result.displayName).toBe(undefined)
#
#
##todo: просмотр истории
##todo: сохранение введенного текста и обновление каунтера.
