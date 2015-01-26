(function() {
  var User, callback, db, mongoose;

  mongoose = require("mongoose");

  mongoose.connect("mongodb://localhost/words");

  db = mongoose.connection;

  db.on("error", console.error.bind(console, "connection error: "));

  db.once("open", callback = function() {
    console.log("Connected to DB");
  });

  require("../models/Words.js");

  require("../models/Users.js");

  User = mongoose.model("User");

}).call(this);
