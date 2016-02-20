angular
  .module('core')
  .factory "TimelineService", ['WebApiService', 'DateService', (WebApiService, DateService) ->
    new class TimelineService
      currentMonth: ''
      timeline: []
      constructor: ->
        @currentMonth = DateService.getTodayMonthString()
      fetchTimeline: (dateString) ->
        angular.copy(WebApiService.fetchTimeline(dateString), @timeline) # <- Yac, wierd
        return @timeline
      setCounterValue: (date, value) ->
        if date.yyyymm() is @currentMonth
          @timeline[date.getDate()-1] = value
  ]
