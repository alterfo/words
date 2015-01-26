express = require("express")
passport = require("passport")
path = require("path")
flash = require("connect-flash")
config = require("nconf")
session                 = require("express-session")
partials                 = require("express-partials")
favicon                 = require("serve-favicon")
logger                     = require("morgan")
cookieParser = require("cookie-parser")
bodyParser            = require("body-parser")
router              = express.Router()
                
module.exports = (app) ->
    # view engine setup
    app.set "views", path.join(__dirname, "../views")
    app.set "view engine", "ejs"
 
    sessionOptions = config.get("session")
    if "production" is app.get("env")
        MemcachedStore = require("connect-memcached")(express)
        sessionOptions.store = new MemcachedStore(config.get("memcached"))

    #if behind a reverse proxy such as Varnish or Nginx
    #app.enable('trust proxy'); 
    app.use logger("dev")
    app.use bodyParser.json()
    app.use bodyParser.urlencoded(extended: false)
    app.use cookieParser()
    app.use express.static(path.join(__dirname, "public"))
    # uncomment after placing your favicon in /public
    #app.use(favicon(__dirname + '/public/favicon.ico'));
    app.use partials()
    app.use "/", router
    app.use session(sessionOptions)
    app.use flash()
    app.use passport.initialize()
    app.use passport.session()
    
    
   
    
    return