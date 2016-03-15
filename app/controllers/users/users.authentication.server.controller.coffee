'use strict'
_ = require('lodash')
errorHandler = require('../errors.server.controller')
mongoose = require('mongoose')
passport = require('passport')
User = mongoose.model('User')
jwt = require 'jsonwebtoken'

secret = require('../../../config/secret').localtokensecret

exports.signup = (req, res) ->
	delete req.body.roles
	user = new User(req.body)
	user.provider = 'local'
	user.displayName = user.firstName + ' ' + user.lastName
	# Then save the user
	user.save (err) ->
		if err
			return res.status(400).send(message: errorHandler.getErrorMessage(err))
		else
			user.password = undefined
			user.salt = undefined
			req.login user, (err) ->
				if err
					res.status(400).send err
				else
					res.json user
				return
		return
	return

exports.signin = (req, res, next) ->
	passport.authenticate('local-token', (err, user, info) ->
		if err or !user
			res.status(400).send info
		else
			user.password = undefined
			user.salt = undefined
			req.login user, (err) ->
				if err
					res.status(400).send err
				else
					res.json user
				return
		return
	) req, res, next
	return

exports.signout = (req, res) ->
	req.logout()
	res.redirect '/'
	return

exports.oauthCallback = (strategy) ->
	(req, res, next) ->
		passport.authenticate(strategy, (err, user, redirectURL) ->
			if err or !user
				return res.redirect('/#!/signin')
			req.login user, (err) ->
				if err
					return res.redirect('/#!/signin')
				res.redirect redirectURL or '/'
			return
		) req, res, next
		return


exports.saveOAuthUserProfile = (req, providerUserProfile, done) ->
	if !req.user
# Define a search query fields
		searchMainProviderIdentifierField = 'providerData.' + providerUserProfile.providerIdentifierField
		searchAdditionalProviderIdentifierField = 'additionalProvidersData.' + providerUserProfile.provider + '.' + providerUserProfile.providerIdentifierField
		# Define main provider search query
		mainProviderSearchQuery = {}
		mainProviderSearchQuery.provider = providerUserProfile.provider
		mainProviderSearchQuery[searchMainProviderIdentifierField] = providerUserProfile.providerData[providerUserProfile.providerIdentifierField]
		# Define additional provider search query
		additionalProviderSearchQuery = {}
		additionalProviderSearchQuery[searchAdditionalProviderIdentifierField] = providerUserProfile.providerData[providerUserProfile.providerIdentifierField]
		# Define a search query to find existing user with current provider profile
		searchQuery = $or: [
			mainProviderSearchQuery
			additionalProviderSearchQuery
		]
		User.findOne searchQuery, (err, user) ->
			if err
				return done(err)
			else
				if !user
					possibleUsername = providerUserProfile.username or (if providerUserProfile.email then providerUserProfile.email.split('@')[0] else '')
					User.findUniqueUsername possibleUsername, null, (availableUsername) ->
						user = new User(
							firstName: providerUserProfile.firstName
							lastName: providerUserProfile.lastName
							username: availableUsername
							displayName: providerUserProfile.displayName
							email: providerUserProfile.email
							provider: providerUserProfile.provider
							providerData: providerUserProfile.providerData)
						# And save the user
						user.save (err) ->
							done err, user
						return
				else
					return done(err, user)
			return
	else
# User is already logged in, join the provider data to the existing user
		user = req.user
		# Check if user exists, is not signed in using this provider, and doesn't have that provider data already configured
		if user.provider != providerUserProfile.provider and (!user.additionalProvidersData or !user.additionalProvidersData[providerUserProfile.provider])
# Add the provider data to the additional provider data field
			if !user.additionalProvidersData
				user.additionalProvidersData = {}
			user.additionalProvidersData[providerUserProfile.provider] = providerUserProfile.providerData
			# Then tell mongoose that we've updated the additionalProvidersData field
			user.markModified 'additionalProvidersData'
			# And save the user
			user.save (err) ->
				done err, user, '/#!/settings/accounts'
		else
			return done(new Error('User is already connected using this provider'), user)
	return

###*
# Remove OAuth provider
###

exports.removeOAuthProvider = (req, res, next) ->
	user = req.user
	provider = req.param('provider')
	if user and provider
# Delete the additional provider
		if user.additionalProvidersData[provider]
			delete user.additionalProvidersData[provider]
			# Then tell mongoose that we've updated the additionalProvidersData field
			user.markModified 'additionalProvidersData'
		user.save (err) ->
			if err
				return res.status(400).send(message: errorHandler.getErrorMessage(err))
			else
				req.login user, (err) ->
					if err
						res.status(400).send err
					else
						res.json user
					return
			return
	return

