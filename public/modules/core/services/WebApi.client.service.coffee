angular
  .module('core')
  .factory "WebApiService", ['$http',  ($http) ->
    new class WebApiService
      constructor: ->
        return

      getToday: ->
        $http.get '/today'

      fetchTimeline: (dateString) ->

        working_date = dateString.yyyymmToDate()
        today = new Date()

        # /2015-01 январь
        daysN = working_date.daysInMonth()
        days = ('--' for [1..daysN])

        $http.get('/texts/' + dateString)
          .then (response) ->
            if working_date.isCurrentMonth() then limit = today.getDate()
            if working_date.isLessThenCurrentMonth() then limit = daysN
            response.data.forEach (e) ->
              days[(new Date(e.date)).getDate() - 1] = e.counter
              return
            days[0..limit-2] = (0 for [1..limit]) if limit
            return
        days

      postText: (textString)->
        $http.post '/texts',
            text: textString
            date: Date.now()
            counter: textString.trim().split(/\s+/).length
]
