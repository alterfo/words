angular
  .module('core')
  .factory "TimelineService", ['WebApiService', 'DateService', '$locale', (WebApiService, DateService, $locale) ->
    new class TimelineService
      workingMonth: ''
      timeline: []
      monthLocaleString: ''
      constructor: ->
        @workingMonth = DateService.getTodayMonthString()
        @monthLocaleString = $locale.DATETIME_FORMATS.STANDALONEMONTH[+@workingMonth[5..6]-1] + @workingMonth[0..3]
      fetchTimeline: (dateString) ->
        angular.copy(WebApiService.fetchTimeline(dateString), @timeline) # <- Yac, wierd
        return @timeline
      setCounterValue: (date, value) ->
        if date.yyyymm() is @workingMonth
          @timeline[date.getDate()-1] = value
      setWorkingMonth: (monthString) ->
        @workingMonth = monthString

      nextMonthString: () ->
        DateService.nextMonthString(new Date(@workingMonth))
      prevMonthString: () ->
        DateService.prevMonthString(new Date(@workingMonth))
      workingMonthIsLessThenCurrentMonth: () ->
        Date.parse(new Date @workingMonth) < Date.parse(DateService.getTodayMonthString())
      setMonthLocaleString: ->
        @monthLocaleString = $locale.DATETIME_FORMATS.STANDALONEMONTH[+@workingMonth[5..6]-1] + @workingMonth[0..3]
  ]
