'use strict'
express = require("express")
router = express.Router()
console.log "Hello"
module.exports = (app) ->
    router.get "/", (req, res, next) ->
      if req.user
        res.redirect "/today"
      else
        res.render "pages/index",
          title: "Главная страница"
          message: "Hello!"

      return
    return
