express         = require("express")
app               = express()
config          = require('nconf')

config.argv()
    .env()
    .file({ file: 'config.json' });

# boot
require('./boot/index')(app);

# routing
require('./routes/index')(app);

 
module.exports = app