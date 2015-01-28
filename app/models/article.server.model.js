'use strict';

/**
 * Module dependencies.
 */
var mongoose = require('mongoose'),
	Schema = mongoose.Schema;

/**
 * Article Schema
 */
var ArticleSchema = new Schema({
	date: {
		type: Date,
		default: new Date()
	},
	text: {
		type: String,
		default: '',
		trim: true
	},
    counter: {
        type: Number,
        default: 0
    },
	user: {
		type: Schema.ObjectId,
		ref: 'User'
	}
});

mongoose.model('Article', ArticleSchema);