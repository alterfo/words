'use strict';

var mongoose  = require('mongoose'),
    Schema    = mongoose.Schema;


var UserSchema = new Schema({
    name: String,
    email: {
        type: String,
        required: true,
        match: [/^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/, 'Please enter a valid email'],
        unique: true
    },
    admin: Boolean,
    password: {
        type: String, required: true
    },
    created_at: Date,
    updated_at: Date
});

mongoose.model('User', UserSchema);
