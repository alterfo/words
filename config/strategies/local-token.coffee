passport = require 'passport'
LocalStrategy = require('passport-local').Strategy
User = require('mongoose').model('User')
jwt = require 'jsonwebtoken'
secret = require('./../secret').localtokensecret

module.exports = () ->
  passport.use 'local-token', new LocalStrategy
    usernameField: 'username',
    passwordField: 'password'
  , (username, password, done) ->
      User.findOne
        username: username
      , (err, user) ->
          return done(err) if err
          return done(null, false, message: 'Неизвестный пользователь') if not user
          return done(null, false, message: 'Невалидный пароль') if not user.authenticate password

          tokenPayload =
            username: user.username,
            loginExpires: user.loginExpires

          user.loginToken = jwt.sign(tokenPayload, secret)
          user.loginExpires = Date.now() + (2*60*60*1000) # 2h

          user.save (err) ->
            if err then done(err) else done(null, user)
            return
      return
  return

