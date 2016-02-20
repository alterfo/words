angular
  .module('core')
  .factory "DateService", [ ->
    new class DateService
      today: null
      working_date: null
      constructor: ->
        @today = new Date()

      getToday: () ->
        @today
      getTodayString: () ->
        @today.yyyymmdd() # "2015-02-28"
      getTodayDayNumber: () ->
        @today.getDate()
      getTodayMonthString: () ->
        @today.yyyymm()
      daysInMonth: (m, y) ->
        new Date(y, m+1, 0).getDate()
      nextMonthString: (date) ->
        (new Date(date.setMonth(date.getMonth() + 1))).yyyymm();
      prevMonthString: (date) ->
        (new Date(date.setMonth(date.getMonth() - 1))).yyyymm();

]
