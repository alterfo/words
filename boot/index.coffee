module.exports = (app) ->
    require("./express")(app);
    require("./passport")(app);
    require("./db")
    return