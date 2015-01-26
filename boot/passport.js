(function() {
  var AuthFacebookStrategy, AuthLocalStrategy, AuthVKStrategy, LocalStrategy, config, flash, passport;

  passport = require("passport");

  flash = require("connect-flash");

  config = require("nconf");

  LocalStrategy = require("passport-local").Strategy;

  AuthLocalStrategy = require('passport-local').Strategy;

  AuthFacebookStrategy = require('passport-facebook').Strategy;

  AuthVKStrategy = require('passport-vkontakte').Strategy;

  passport.use("local", new AuthLocalStrategy(function(username, password, done) {
    if (username === "admin" && password === "admin") {
      return done(null, {
        username: "admin",
        photoUrl: "url_to_avatar",
        profileUrl: "url_to_profile"
      });
    }
    return done(null, false, {
      message: "Неверный логин или пароль"
    });
  }));

  passport.use("facebook", new AuthFacebookStrategy({
    clientID: config.get("auth:fb:app_id"),
    clientSecret: config.get("auth:fb:secret"),
    callbackURL: config.get("app:url") + "/auth/fb/callback",
    profileFields: ["id", "displayName", "profileUrl", "username", "link", "gender", "photos"]
  }, function(accessToken, refreshToken, profile, done) {
    return done(null, {
      username: profile.displayName,
      photoUrl: profile.photos[0].value,
      profileUrl: profile.profileUrl
    });
  }));

  passport.use("vk", new AuthVKStrategy({
    clientID: config.get("auth:vk:app_id"),
    clientSecret: config.get("auth:vk:secret"),
    callbackURL: config.get("app:url") + "/auth/vk/callback"
  }, function(accessToken, refreshToken, profile, done) {
    return done(null, {
      username: profile.displayName,
      photoUrl: profile.photos[0].value,
      profileUrl: profile.profileUrl
    });
  }));

  passport.serializeUser(function(user, done) {
    done(null, JSON.stringify(user));
  });

  passport.deserializeUser(function(data, done) {
    var e;
    try {
      done(null, JSON.parse(data));
    } catch (_error) {
      e = _error;
      done(err);
    }
  });

  module.exports = function(app) {};

}).call(this);
