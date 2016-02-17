angular
  .module('core')
  .factory "WebApiService", ['$http',  ($http) ->
    new class WebApiService
      constructor: ->
        return

      getToday: ->
        $http.get '/today'

      getTimeline: (year, month) ->
        date = new Date(new Date(year, month).setHours(0, 0, 0, 0))
        today = new Date((new Date()).setHours(0, 0, 0, 0))
        sy = date.getFullYear()
        sm = date.getMonth()

        # /2015-01 январь
        request_string = sy + "-" + ("0" + (sm + 1)).slice(-2)
        daysN = new Date(year, month+1, 0).getDate()
        days = ('--' for [1..daysN])

        $http.get('/texts/' + request_string)
          .then (data) ->
            limit = today.getDate()
            data.data.forEach (e) ->
              days[(new Date(e.date)).getDate() - 1] = e.counter
              return
            days[0..limit] = (0 for [1..limit])
            return
        days

      postText: (textString)->
        $http.post '/texts',
          data:
            text: textString
            date: Date.now()
            counter: textString.trim().split(/\s+/).length
]
