(function() {
  module.exports = function(app) {
    require("./home")(app);
    require("./auth")(app);
    app.use(function(req, res, next) {
      var err;
      err = new Error("Not Found");
      err.status = 404;
      next(err);
    });
    if (app.get("env") === "development") {
      app.use(function(err, req, res, next) {
        res.status(err.status || 500);
        res.render("pages/error", {
          message: err.message,
          error: err
        });
      });
    }
    app.use(function(err, req, res, next) {
      res.status(err.status || 500);
      res.render("pages/error", {
        message: err.message,
        error: {}
      });
    });
  };

}).call(this);
