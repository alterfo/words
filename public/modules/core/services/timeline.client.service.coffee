angular
  .module('core')
  .factory "TimelineService", ['WebApiService', (WebApiService) ->
      timeline = []
      day = (new Date()).getDate()
      timelineCache = []
      getTimeline: (dateString) ->
        if  timelineCache[dateString]
          return timelineCache[dateString]
        else
          timeline = WebApiService.getTimeline(dateString)
          timelineCache[dateString] = timeline
          return timeline

      getDay: ->
        day

      setDay: (d) ->
        if typeof d is 'number' and d > 0 and d < 30
          day = d
        else throw new Error('Day is not appropriate')

      setCounterValue: (value) ->
        if day
          timeline[day] = value


  ]
