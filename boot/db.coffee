mongoose       = require("mongoose")

mongoose.connect "mongodb://localhost/words"
db = mongoose.connection
db.on "error", console.error.bind(console, "connection error: ")
db.once "open", callback = ->
  console.log "Connected to DB"
  return

require "../models/Words.js"
require "../models/Users.js"

User = mongoose.model("User")
