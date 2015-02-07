'use strict';

/**
 * Module dependencies.
 */
var users = require('../../app/controllers/users.server.controller'),
	texts = require('../../app/controllers/texts.server.controller');

module.exports = function(app) {
	app.route('/texts/:month')
		.get(texts.list);

	app.route('/text/:textDate')
		.get(texts.readOne);

	app.route('/texts')
        .post(texts.upsert);
    
    app.route('/today')
        .get(texts.today);

	app.param('textDate', texts.textByDate);
    app.param('month', texts.textsByMonth);
};


/*
'use strict';

module.exports = function(app) {
	var users = require('../../app/controllers/users.server.controller');
	var words = require('../../app/controllers/words.server.controller');

	// Words Routes
	app.route('/words')
		.get(words.list)
		.post(users.requiresLogin, words.create);

	app.route('/words/:wordId')
		.get(words.read)
		.put(users.requiresLogin, words.hasAuthorization, words.update)
		.delete(users.requiresLogin, words.hasAuthorization, words.delete);

	// Finish by binding the Word middleware
	app.param('wordId', words.wordByID);
};

*/