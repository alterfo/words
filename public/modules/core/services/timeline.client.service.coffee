angular
  .module('core')
  .factory "TimelineService", ['WebApiService', (WebApiService) ->

      day: (new Date()).getDate()
      timeline: []

      fetchTimeline: (dateString) ->
          angular.copy(WebApiService.fetchTimeline(dateString), @timeline) # <- Yac, wierd
          return @timeline

      getDay: ->
        @day

      setDay: (d) ->
        if typeof d is 'number' and d > 0 and d < 30
          @day = d
        else throw new Error('Day is not appropriate')

      setCounterValue: (value) ->
        if @day
          @timeline[@day-1] = value
  ]
