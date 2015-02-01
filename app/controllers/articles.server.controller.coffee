"use strict"

###*
Module dependencies.
###
mongoose = require("mongoose")
errorHandler = require("./errors.server.controller")
Article = mongoose.model("Article")
_ = require("lodash")

###*
Create a article
###
exports.update = (req, res) ->
  today_start = new Date()
  today_start.setHours 0, 0, 0, 0
  today_end = new Date()
  today_end.setHours 23, 59, 59, 999
  Article.update
    date:
      $gte: today_start
      $lt: today_end

    user: req.user
  ,
    $set:
      text: req.body.text
      counter: req.body.counter
      date: today_start
  ,
    upsert: true
  , ->

  Article.find
    date:
      $gte: today_start
      $lt: today_end

    user: req.user
  , (err, articles) ->
    if err
      res.status(400).send message: errorHandler.getErrorMessage(err)
    else
      res.json articles[0]
    return

  return


###*
Show the current article
###
exports.read = (req, res) ->
  
  # 
  #    db.articles.find()({
  #        _id: {
  #            $lt: new ObjectId(Math.floor((new Date()).getTime() / 1000).toString(16) + '0000000000000000')
  #        }
  #    })
  
  #    db.posts.find({ '$where': 'this.created_on.toJSON().slice(0, 10) == "2012-07-14"' })
  today_start = new Date()
  today_start.setHours 0, 0, 0, 0
  today_end = new Date()
  today_end.setHours 23, 59, 59, 999
  Article.find
    date:
      $gte: today_start
      $lt: today_end

    user: req.user
  , (err, articles) ->
    if err
      res.status(400).send message: errorHandler.getErrorMessage(err)
    else
      console.log articles
      res.json articles[0]
    return

  return

exports.list = (req, res) ->
  res.jsonp req.articles
  return


###*
Article middleware
###
exports.articlesByMonth = (req, res, next, id) ->
  today = new Date(id) # 2014-01
  y = today.getFullYear()
  m = today.getMonth()
  first_day = new Date(y, m, 1)
  last_day = new Date(y, m + 1, 0)
  first_day.setHours 0, 0, 0, 0
  last_day.setHours 23, 59, 59, 999

  Article.find
    date:
      $gte: first_day
      $lt: last_day
    user: req.user,
    'date counter'
  , (err, articles) ->
    return next(err)  if err
    return next(new Error("Failed to load article " + id))  unless articles
    req.articles = articles
    next()
    return

  return


###*
Article middleware
###
exports.articleByID = (req, res, next, id) ->
  Article.findById(id).populate("user", "displayName").exec (err, article) ->
    return next(err)  if err
    return next(new Error("Failed to load article " + id))  unless article
    req.article = article
    next()
    return

  return


###*
Article authorization middleware
###
exports.hasAuthorization = (req, res, next) ->
  return res.status(403).send(message: "User is not authorized")  if req.article.user.id isnt req.user.id
  next()
  return