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
  counter:
    type: Number
    default: 0
  user:
    type: Schema.ObjectId
    ref: 'User')

mongoose.model 'Text', TextSchema
