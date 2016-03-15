'use strict'

fs = require('fs')
http = require('http')
https = require('https')
express = require('express')
app = express()
morgan = require('morgan')
bodyParser = require('body-parser')
session = require('express-session')
compress = require('compression')
methodOverride = require('method-override')
cookieParser = require('cookie-parser')
helmet = require('helmet')
passport = require('passport')
MongoStore = require('connect-mongostore')(session)
flash = require('connect-flash')
config = require('./config')
consolidate = require('consolidate')
path = require('path')
extend = require('extend')
cors = require('cors')


module.exports = (db) ->
  config.getGlobbedFiles('./app/models/**/*.js').forEach (modelPath) ->
    require path.resolve(modelPath)
    return

  extend app.locals,
      title       : config.app.title
      description : config.app.description
      keywords    : config.app.keywords
      facebookAppId : config.facebook.clientID
      jsFiles     : config.getJavaScriptAssets()
      cssFiles    : config.getCSSAssets()

  app.use (req, res, next) ->
    res.locals.url = req.protocol + '://' + req.headers.host + req.url
    next()
    return

  app.use compress
    filter: (req, res) ->
      /json|text|javascript|css/.test res.getHeader('Content-Type')
    level: 9

  app.set 'showStackError', true
  app.engine 'server.view.html', consolidate[config.templateEngine]
  app.set 'view engine', 'server.view.html'
  app.set 'views', './app/views'
  if process.env.NODE_ENV is 'development'
    app.use morgan('dev')
    app.set 'view cache', false
  else if process.env.NODE_ENV is 'production'
    app.locals.cache = 'memory'

  app.use bodyParser.urlencoded(extended: true)
  app.use bodyParser.json()
  app.use methodOverride()

  app.use cors()
  app.use (req, res, next) ->
    res.setHeader('Access-Control-Allow-Origin', '*');
    res.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS, PUT, DELETE');
    res.setHeader('Access-Control-Allow-Headers', 'origin, x-requested-with, content-type, accept, x-xsrf-token');
    res.setHeader('Access-Control-Allow-Credentials', true);
    next();



  app.use cookieParser()
  app.use session
    secret: config.sessionSecret
    store: new MongoStore
      db: config.sessionCollection

  app.use passport.initialize()
  app.use passport.session()
  app.use flash()
  app.use helmet.xframe()
  app.use helmet.xssFilter()
  app.use helmet.nosniff()
  app.use helmet.ienoopen()
  app.disable 'x-powered-by'

  app.use express.static(path.resolve('./public'))

  config.getGlobbedFiles('./app/routes/**/*.js').forEach (routePath) ->
    require(path.resolve(routePath))(app)
    return

  app.use (err, req, res, next) ->
    if !err
      return next()
    console.error err.stack
    res.status(500).render '500', error: err.stack
    return

  app.use (req, res) ->
    res.status(404).render '404',
      url: req.originalUrl
    error: 'Not Found'
    return

  if process.env.NODE_ENV == 'secure'
    console.log 'Securely using https protocol'
    privateKey = fs.readFileSync('./config/sslcerts/key.pem', 'utf8')
    certificate = fs.readFileSync('./config/sslcerts/cert.pem', 'utf8')
    httpsServer = https.createServer({
      key: privateKey
      cert: certificate
    }, app)
    return httpsServer

  app

