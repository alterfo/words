'use strict';

/**
 * Module dependencies.
 */
var should = require('should'),
	mongoose = require('mongoose'),
	User = mongoose.model('User'),
	Text = mongoose.model('Text');

/**
 * Globals
 */
var user, text;

/**
 * Unit tests
 */
describe('Text Model Unit Tests:', function() {
	beforeEach(function(done) {
		user = new User({
			firstName: 'Full',
			lastName: 'Name',
			displayName: 'Full Name',
			email: 'test@test.com',
			username: 'username',
			password: 'password'
		});

		user.save(function() {
			text = new Text({
				text: 'Text Content',
				counter: 2
			});

			done();
		});
	});

	describe('Method Save', function() {
		it('should be able to save without problems', function(done) {
			return text.save(function(err) {
				should.not.exist(err);
				done();
			});
		});

		it('should be able to show an error when try to save without Text and Counter', function(done) {
			text.text = '';
			text.counter = undefined;

			return text.save(function(err) {
				should.exist(err);
				done();
			});
		});

		it('should be able to show an error when try to save Counter lt 0', function(done) {
			text.counter = -10;

			return text.save(function(err) {
				should.exist(err);
				done();
			});
		});

		it('should be able to show an error when try to save Counter gt 10000', function(done) {
			text.counter = 10001;

			return text.save(function(err) {
				should.exist(err);
				done();
			});
		});
	});

	afterEach(function(done) {
		Text.remove().exec();
		User.remove().exec();
		done();
	});
});