'use strict'
mongoose = require('mongoose')
Schema = mongoose.Schema
crypto = require('crypto')

validateLocalStrategyProperty = (property) ->
	@provider != 'local' and !@updated or property.length

validateLocalStrategyPassword = (password) ->
	@provider != 'local' or password and password.length > 6

UserSchema = new Schema(
	firstName:
		type: String
		trim: true
		default: ''
		validate: [
			validateLocalStrategyProperty
			'Please fill in your first name'
		]
	lastName:
		type: String
		trim: true
		default: ''
		validate: [
			validateLocalStrategyProperty
			'Please fill in your last name'
		]
	displayName:
		type: String
		trim: true
	email:
		type: String
		trim: true
		default: ''
		validate: [
			validateLocalStrategyProperty
			'Please fill in your email'
		]
		match: [/.+\@.+\..+/,	'Please fill a valid email address']
	username:
		type: String
		unique: 'testing error message'
		required: 'Please fill in a username'
		trim: true
	password:
		type: String
		default: ''
		validate: [
			validateLocalStrategyPassword
			'Password should be longer'
		]
	salt: type: String
	provider:
		type: String
		required: 'Provider is required'
	providerData: {}
	additionalProvidersData: {}
	roles:
		type: [ {
			type: String
			enum: [
				'user'
				'admin'
			]
		} ]
		default: [ 'user' ]
	updated: type: Date
	created:
		type: Date
		default: Date.now
	loginToken: type: String
	loginExpires: type: Date
	resetPasswordToken: type: String
	resetPasswordExpires: type: Date)


UserSchema.pre 'save', (next) ->
	if @password and @password.length > 6
		if not @salt
			@salt = new Buffer(crypto.randomBytes(16).toString('base64'), 'base64')
			@password = @hashPassword(@password)
	next()
	return

UserSchema.methods.hashPassword = (password) ->
	if @salt and password
		crypto.pbkdf2Sync(password, @salt, 10000, 64).toString 'base64'
	else
		password

UserSchema.methods.authenticate = (password) ->
	@password == @hashPassword(password)

UserSchema.statics.findUniqueUsername = (username, suffix, callback) ->
	_this = this
	possibleUsername = username + (suffix or '')
	_this.findOne { username: possibleUsername }, (err, user) ->
		if !err
			if !user
				callback possibleUsername
			else
				return _this.findUniqueUsername(username, (suffix or 0) + 1, callback)
		else
			callback null
		return
	return

mongoose.model 'User', UserSchema
