'use strict';

/**
 * Module dependencies.
 */
exports.index = function (req, res) {

    var mongoose = require('mongoose'),
        errorHandler = require('./errors.server.controller'),
        Article = mongoose.model('Article'),
        _ = require('lodash');

    var today_start = new Date();
    today_start.setHours(0, 0, 0, 0);
    var today_end = new Date();
    today_end.setHours(23, 59, 59, 999);

    var article = Article.find({
        'date': {
            '$gte': today_start,
            '$lt': today_end
        },
        "user": req.user
    }, function (err, article) {
            console.log(article);
    });

    //    var article = Article.find({date: {$gte: today_start, $lt: today_end}});
    //    if 

    article.user = req.user;

    res.render('index', {
        user: req.user || null,
        request: req,
        article: article
    });
};