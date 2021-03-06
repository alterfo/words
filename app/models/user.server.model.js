// Generated by CoffeeScript 1.10.0
(function() {
  'use strict';
  var Schema, UserSchema, crypto, mongoose, validateLocalStrategyPassword, validateLocalStrategyProperty;

  mongoose = require('mongoose');

  Schema = mongoose.Schema;

  crypto = require('crypto');

  validateLocalStrategyProperty = function(property) {
    return this.provider !== 'local' && !this.updated || property.length;
  };

  validateLocalStrategyPassword = function(password) {
    return this.provider !== 'local' || password && password.length > 6;
  };

  UserSchema = new Schema({
    firstName: {
      type: String,
      trim: true,
      "default": '',
      validate: [validateLocalStrategyProperty, 'Please fill in your first name']
    },
    lastName: {
      type: String,
      trim: true,
      "default": '',
      validate: [validateLocalStrategyProperty, 'Please fill in your last name']
    },
    displayName: {
      type: String,
      trim: true
    },
    email: {
      type: String,
      trim: true,
      "default": '',
      validate: [validateLocalStrategyProperty, 'Please fill in your email'],
      match: [/.+\@.+\..+/, 'Please fill a valid email address']
    },
    username: {
      type: String,
      unique: 'testing error message',
      required: 'Please fill in a username',
      trim: true
    },
    password: {
      type: String,
      "default": '',
      validate: [validateLocalStrategyPassword, 'Password should be longer']
    },
    salt: {
      type: String
    },
    provider: {
      type: String,
      required: 'Provider is required'
    },
    providerData: {},
    additionalProvidersData: {},
    roles: {
      type: [
        {
          type: String,
          "enum": ['user', 'admin']
        }
      ],
      "default": ['user']
    },
    updated: {
      type: Date
    },
    created: {
      type: Date,
      "default": Date.now
    },
    loginToken: {
      type: String
    },
    loginExpires: {
      type: Date
    },
    resetPasswordToken: {
      type: String
    },
    resetPasswordExpires: {
      type: Date
    }
  });

  UserSchema.pre('save', function(next) {
    if (this.password && this.password.length > 6) {
      if (!this.salt) {
        this.salt = new Buffer(crypto.randomBytes(16).toString('base64'), 'base64');
        this.password = this.hashPassword(this.password);
      }
    }
    next();
  });

  UserSchema.methods.hashPassword = function(password) {
    if (this.salt && password) {
      return crypto.pbkdf2Sync(password, this.salt, 10000, 64).toString('base64');
    } else {
      return password;
    }
  };

  UserSchema.methods.authenticate = function(password) {
    return this.password === this.hashPassword(password);
  };

  UserSchema.statics.findUniqueUsername = function(username, suffix, callback) {
    var _this, possibleUsername;
    _this = this;
    possibleUsername = username + (suffix || '');
    _this.findOne({
      username: possibleUsername
    }, function(err, user) {
      if (!err) {
        if (!user) {
          callback(possibleUsername);
        } else {
          return _this.findUniqueUsername(username, (suffix || 0) + 1, callback);
        }
      } else {
        callback(null);
      }
    });
  };

  mongoose.model('User', UserSchema);

}).call(this);

//# sourceMappingURL=user.server.model.js.map
