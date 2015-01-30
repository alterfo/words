'use strict';

/**
 * Module dependencies.
 */
var users = require('../../app/controllers/users.server.controller'),
	articles = require('../../app/controllers/articles.server.controller');

module.exports = function(app) {
	// Article Routes
	app.route('/articles/:month')
		.get(articles.list);
    
	app.route('/articles')
        .post(articles.update);
    
    app.route('/today')
        .get(articles.read);

//	app.route('/articles/:articleId')
//		.get(users.requiresLogin, articles.hasAuthorization, articles.read)
//		.put(users.requiresLogin, articles.hasAuthorization, articles.update)
//		.delete(users.requiresLogin, articles.hasAuthorization, articles.delete);

	// Finish by binding the article middleware
	app.param('articleId', articles.articleByID);
    app.param('month', articles.articlesByMonth);
};