'use strict'

module.exports = (app) ->
  callback = require('../../app/controllers/callback.server.controller')
  app
    .route '/callback'
    .post callback.send
