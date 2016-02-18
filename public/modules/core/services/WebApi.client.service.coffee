angular
  .module('core')
  .factory "WebApiService", ['$http',  ($http) ->
    new class WebApiService
      constructor: ->
        return

      getToday: ->
        $http.get '/today'

      getTimeline: (dateString) ->

        working_date = dateString.yyyymmToDate()
        today = new Date()

        # /2015-01 январь
        daysN = working_date.daysInMonth()
        days = ('--' for [1..daysN])

        $http.get('/texts/' + dateString)
          .then (data) ->
            if working_date.isCurrentMonth() then limit = today.getDate()
            if working_date.isLessThenCurrentMonth() then limit = daysN
            data.data.forEach (e) ->
              days[(new Date(e.date)).getDate() - 1] = e.counter
              return
            days[0..limit] = (0 for [1..limit]) if limit
            return
        days

      postText: (textString)->
        $http.post '/texts',
          data:
            text: textString
            date: Date.now()
            counter: textString.trim().split(/\s+/).length
]
