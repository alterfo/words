nodemailer = require 'nodemailer'
transporter = nodemailer.createTransport(require('nodemailer-sendmail-transport')(
  path: '/usr/sbin/sendmail'
))

'use strict'
exports.send = (req, res) ->
  transporter.sendMail
    from: 'Itservice ✔ <words@oleg-sidorkin.ru>'
    to: "kalinon7@gmail.com"
    subject: "[Words]"
    text: req.body.callback_text
  , (err, info) ->
      if err then console.error err
      res.end('Сообщение успешно отправлено!')
  #todo: save to database
