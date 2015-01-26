var mongoose = require('mongoose');

var WordsSchema = new mongoose.Schema({
    text: String,
    date: Date,
    user: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User'
    }
});

mongoose.model('Words', WordsSchema);