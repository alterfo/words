angular
  .module('core')
  .factory "WebApiService", ['$http', '$q',  ($http, $q) ->
    new class WebApiService

      timelineCache: []
      constructor: ->
        return

      getToday: ->
        $http.get '/today'

      fetchTimeline: (dateString, callback) ->
        def = $q.defer()

        if @timelineCache[dateString]
          callback && callback(@timelineCache[dateString])
          def.resolve()
          return def.promise

        working_date = dateString.yyyymmToDate()
        today = new Date()

        # /2015-01 январь
        daysN = working_date.daysInMonth()
        days = ('--' for [1..daysN-1])

        $http.get('/texts/' + dateString)
          .then (response) =>
            if working_date.isCurrentMonth() then limit = today.getDate()
            if working_date.isLessThenCurrentMonth() then limit = daysN
            days[0..limit-2] = (0 for [1..limit]) if limit
            response.data.forEach (e) ->
              days[(new Date(e.date)).getDate() - 1] = e.counter
              return
            @timelineCache[dateString] = days
            callback && callback(days)
            def.resolve()
        def.promise

      postText: (textString) ->
        $http.post '/texts',
            text: textString
            date: Date.now()
            counter: textString.trim().split(/\s+/).length

]
