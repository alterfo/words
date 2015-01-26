(function() {
  'use strict';
  var express, router;

  express = require("express");

  router = express.Router();

  console.log("Hello");

  module.exports = function(app) {
    router.get("/", function(req, res, next) {
      if (req.user) {
        res.redirect("/today");
      } else {
        res.render("pages/index", {
          title: "Главная страница",
          message: "Hello!"
        });
      }
    });
  };

}).call(this);
