var express = require('express');
var router = express.Router();
var mongoose = require('mongoose');
var passport = require('passport');
var Words = mongoose.model('Words');
var User = mongoose.model('User');

/* GET home page. */
router.get('/', function(req, res, next) {
    if (req.user) {
        res.redirect('/today')
    } else {
        res.render('pages/index', { title: 'Главная страница', message: req.session.messages });
    }
});

router.get('/words', function(req, res, next) {
    Words.find(function(err, words) {
       if (err) return next(err);

       res.json(words);
    });
});

router.get('/login', function(req, res, next) {
    if (req.user) {
        res.redirect('/')
    } else {
        res.render('pages/login', {title: 'Страница входа', message: req.session.messages });
        req.session.messages = null;
    }
});

router.post('/login', passport.authenticate('local', { successRedirect: '/',
    failureRedirect: '/login' }));

module.exports = router;
