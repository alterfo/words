"use strict"

###*
Module dependencies.
###
mongoose = require("mongoose")
errorHandler = require("./errors.server.controller")
Text = mongoose.model("Text")
_ = require("lodash")
moment = require('moment')

###*
Upsert
###
exports.upsert = (req, res) ->
  today = (new Date()).setHours 0,0,0,0
  if req.body.date is undefined 
    text_date = today 
  else 
    text_date = (new Date(req.body.date)).setHours 0, 0, 0, 0

  if text_date is today
    today_start = new Date(text_date)
    today_start.setHours 0, 0, 0, 0
    today_end = new Date(text_date)
    today_end.setHours 23, 59, 59, 999

    Text.update
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

    Text.find
      date:
        $gte: today_start
        $lt: today_end

      user: req.user
    , (err, texts) ->
      if err
        res.status(400).send message: errorHandler.getErrorMessage(err)
      else
        res.json texts[0]
      
  else
    res.send message: 'День прошел, перезагрузите, пожалуйста, страницу'
  return


###*
Show the current article
###
exports.today = (req, res) ->
  
  # 
  #    db.texts.find()({
  #        _id: {
  #            $lt: new ObjectId(Math.floor((new Date()).getTime() / 1000).toString(16) + '0000000000000000')
  #        }
  #    })
  
  #    db.posts.find({ '$where': 'this.created_on.toJSON().slice(0, 10) == "2012-07-14"' })
  today_start = new Date()
  today_start.setHours 0, 0, 0, 0
  today_end = new Date()
  today_end.setHours 23, 59, 59, 999
  Text.find
    date:
      $gte: today_start
      $lt: today_end

    user: req.user
  , (err, texts) ->
    if err
      res.status(400).send message: errorHandler.getErrorMessage(err)
    else
      res.json texts[0]
    return

  return

exports.list = (req, res) ->
  res.jsonp req.texts
  return


###*
Text middleware
###
exports.textsByMonth = (req, res, next, id) ->
  today = new Date(id) # 2014-01
  y = today.getFullYear()
  m = today.getMonth()
  console.log y, m
  first_day = new Date(y, m, 1)
  last_day = new Date(y, m + 1, 0)
  first_day.setHours 0, 0, 0, 0
  last_day.setHours 23, 59, 59, 999

  Text.find
    date:
      $gte: first_day
      $lt: last_day
    user: req.user,
    'date counter'
  , (err, texts) ->
    return next(err)  if err
    return next(new Error("Failed to load article " + id))  unless texts
    req.texts = texts
    next()
    return

  return


###*
Text middleware
###
exports.textByDate = (req, res, next, id) ->

  day_start = new Date(id) # 20150201
  day_end = new Date(id)
  
  day_start.setHours 0, 0, 0, 0
  day_end.setHours 23, 59, 59, 999
  
  Text.find
    date:
      $gte: day_start
      $lt: day_end

    user: req.user
  , (err, texts) ->
    if err
      res.status(400).send message: errorHandler.getErrorMessage(err)
    else
      req.text = texts[0]
      next()
    return

  return

exports.readOne = (req, res) ->
  res.jsonp req.text
  return

###*
Text authorization middleware
###
#todo: fix for get
exports.hasAuthorization = (req, res, next) ->
  if req.texts and req.texts.user
    return res.status(403).send(message: "User is not authorized")  if req.texts.user.id isnt req.user.id
  next()
  return
