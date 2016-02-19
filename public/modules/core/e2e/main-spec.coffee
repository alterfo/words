describe '500 words main page from scratch', ->

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
    browser.takeScreenshot()
    expect(by.model('HeaderController.authentication.user')).toBeFalthy()
