'use strict'
Date.prototype.yyyymm = ->
	yyyy = @getFullYear().toString()
	mm = (@getMonth()+1).toString()
	yyyy + '-' + (if mm.length == 2 then mm else "0" + mm)

Date.prototype.yyyymmdd = ->
	yyyy = @getFullYear().toString()
	mm = (@getMonth()+1).toString()
	dd  = @getDate().toString();
	yyyy + '-' + (if mm.length == 2 then mm else "0" + mm) + '-' + (if dd.length == 2 then dd else "0" + dd)

Date.prototype.nextMonth = ->
	new Date(@setMonth(@getMonth() + 1))

Date.prototype.prevMonth = ->
	new Date(@setMonth(@getMonth() - 1))

String.prototype.yyyymmToDate = ->
  new Date(@[0..3], +@[5..6]-1)

Date.prototype.isCurrentMonth = ->
  working_date = @
  today = new Date()

  ty = today.getFullYear()
  dy = working_date.getFullYear()
  tm = today.getMonth()
  dm = working_date.getMonth()

  tm is dm and ty is dy

Date.prototype.daysInMonth = ->
  new Date(@getFullYear(), @getMonth()+1, 0).getDate()

Date.prototype.isLessThenCurrentMonth = ->
  today = (new Date())
  today.setMonth(today.getMonth() - 1)
  Date.parse(today) > Date.parse(@)
