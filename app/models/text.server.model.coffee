'use strict'

mongoose = require('mongoose')
Schema = mongoose.Schema


TextSchema = new Schema(
  date:
    type: Date
    default: new Date()
  text:
    type: String
    default: ''
    trim: true
    required: "Text is required"
  counter:
    type: Number
    default: 0
    required: "Counter is required"
    min: 0
    max: 10000
  user:
    type: Schema.ObjectId
    ref: 'User')

mongoose.model 'Text', TextSchema
