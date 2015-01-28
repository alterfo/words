'use strict';

/**
 * Module dependencies.
 */
var mongoose = require('mongoose'),
    errorHandler = require('./errors.server.controller'),
    Article = mongoose.model('Article'),
    _ = require('lodash');

/**
 * Create a article
 */
exports.update = function (req, res) {

    var today_start = new Date();
    today_start.setHours(0, 0, 0, 0);
    var today_end = new Date();
    today_end.setHours(23, 59, 59, 999);

    Article.update({
        'date': {
            '$gte': today_start,
            '$lt': today_end
        },
        'user': req.user
    }, {
        $set: {
            text: req.body.text
        }
    }, {
        upsert: true
    }, function () {});

    Article.find({
        'date': {
            '$gte': today_start,
            '$lt': today_end
        },
        'user': req.user
    }, function (err, article) {
        if (err) {
            return res.status(400).send({
                message: errorHandler.getErrorMessage(err)
            });
        } else {
            res.json(article);
        }
    });

};

/**
 * Show the current article
 */
exports.read = function (req, res) {

    var today_start = new Date();
    today_start.setHours(0, 0, 0, 0);
    var today_end = new Date();
    today_end.setHours(23, 59, 59, 999);

    Article.find({
        'date': {
            '$gte': today_start,
            '$lt': today_end
        },
        user: req.user._id
    }, function (err, article) {
        if (err) {
            return res.status(400).send({
                message: errorHandler.getErrorMessage(err)
            });
        } else {
            console.log(article);
            res.json(article);
        }
    });

};

/**
 * List of Articles
 */
exports.list = function (req, res) {
    Article.find().sort('-created').populate('user', 'displayName').exec(function (err, articles) {
        if (err) {
            return res.status(400).send({
                message: errorHandler.getErrorMessage(err)
            });
        } else {
            res.json(articles);
        }
    });
};

/**
 * Article middleware
 */
exports.articleByID = function (req, res, next, id) {
    Article.findById(id).populate('user', 'displayName').exec(function (err, article) {
        if (err) return next(err);
        if (!article) return next(new Error('Failed to load article ' + id));
        req.article = article;
        next();
    });
};

/**
 * Article authorization middleware
 */
exports.hasAuthorization = function (req, res, next) {
    if (req.article.user.id !== req.user.id) {
        return res.status(403).send({
            message: 'User is not authorized'
        });
    }
    next();
};