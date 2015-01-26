passport        = require("passport")
flash               = require("connect-flash")
config = require("nconf")

LocalStrategy    = require("passport-local").Strategy
AuthLocalStrategy = require('passport-local').Strategy
AuthFacebookStrategy = require('passport-facebook').Strategy
AuthVKStrategy = require('passport-vkontakte').Strategy

passport.use "local", new AuthLocalStrategy((username, password, done) ->
  if username is "admin" and password is "admin"
    return done(null,
      username: "admin"
      photoUrl: "url_to_avatar"
      profileUrl: "url_to_profile"
    )
  done null, false,
    message: "Неверный логин или пароль"

)
passport.use "facebook", new AuthFacebookStrategy(
  clientID: config.get("auth:fb:app_id")
  clientSecret: config.get("auth:fb:secret")
  callbackURL: config.get("app:url") + "/auth/fb/callback"
  profileFields: [
    "id"
    "displayName"
    "profileUrl"
    "username"
    "link"
    "gender"
    "photos"
  ]
, (accessToken, refreshToken, profile, done) ->
  
  #console.log("facebook auth: ", profile);
  done null,
    username: profile.displayName
    photoUrl: profile.photos[0].value
    profileUrl: profile.profileUrl

)
passport.use "vk", new AuthVKStrategy(
  clientID: config.get("auth:vk:app_id")
  clientSecret: config.get("auth:vk:secret")
  callbackURL: config.get("app:url") + "/auth/vk/callback"
, (accessToken, refreshToken, profile, done) ->
  
  #console.log("facebook auth: ", profile);
  done null,
    username: profile.displayName
    photoUrl: profile.photos[0].value
    profileUrl: profile.profileUrl

)
passport.serializeUser (user, done) ->
  done null, JSON.stringify(user)
  return

passport.deserializeUser (data, done) ->
  try
    done null, JSON.parse(data)
  catch e
    done err
  return

module.exports = (app) ->