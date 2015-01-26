(function() {
  var app, config, express;

  express = require("express");

  app = express();

  config = require('nconf');

  config.argv().env().file({
    file: 'config.json'
  });

  require('./boot/index')(app);

  require('./routes/index')(app);

  module.exports = app;

}).call(this);
