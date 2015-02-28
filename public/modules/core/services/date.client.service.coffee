angular.module('core').factory "DateService", [
  () ->
  	today = new Date()
  	date_to_show = new Date()

  	getTodayISO: () ->
  		today
  	getTodayString: () ->
  		today.yyyymmdd() # "2015-02-28"
  	getTodayDay: () ->
  		today.getDate()
  	getTodayMonthString: () ->
  		today.yyyymm()
  	daysInMonth: (m, y) ->
  		new Date(year, month+1, 0).getDate()
  	nextMonthString: (date) ->
  		(new Date(date.setMonth(date.getMonth() + 1))).yyyymm();
  	prevMonthString: (date) ->
  		(new Date(date.setMonth(date.getMonth() - 1))).yyyymm();


]