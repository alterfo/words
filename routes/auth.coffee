'use strict'
express = require("express")
router = express.Router()

module.exports = (app) ->
    router.get "/auth", (req, res, next) ->
      if req.user
        res.redirect "/today"
      else
        res.render "pages/index",
          title: "Главная страница"
          message: "Hello!"

      return
    return
