describe '500 words login', ->

  beforeEach ->
    browser.get 'http://localhost:3000'

  it 'should be able to login', ->
    $('.nav [href="/#!/signin"]').click()
    form = $('form.signin')
    username = form.element(By.model('credentials.username'))
    password = form.element(By.model('credentials.password'))
    username.sendKeys 'demo'
    password.sendKeys 'demodemo'
    form.submit()

    expect(element(By.model('authentication.user.displayName'))).toBe('Demo Demo')
    $('.nav [href="/auth/signout"]').click()
    expect(element(By.model('authentication.user'))).toBeFalthy()

