'use strict'

angular.module('core').controller 'TextController', [
    '$scope'
    '$http'
    '$stateParams'
    '$location'
    'Authentication'
    '$document'
    "AlertService"
    'moment'
    ($scope, $http, $stateParams, $location, Authentication, $document, AlertService, moment) ->

        DEBUG = 1

        @current_date = moment()

        cm = moment().month()
        cy = moment().year()
        cd = moment().date()

        @curMonth = moment().format('YYYYMM')
        @curDate = moment().format('YYYYMMDD')



        @authentication = Authentication
        @historyText = ''
        @text = ''
        @changed = false
        @state = 'saved' # saved, notsaved, saving

        daysInMonth = (month,year) ->
            new Date(year, month+1, 0).getDate()

        @nextMonth = =>
            @curMonth = @date_to_show.nextMonth().yyyymm()
            return

        @prevMonth = ->
            @curMonth = @date_to_show.prevMonth().yyyymm()
            return

        @getWordCounter = ->
            @text.trim().split(/\s+/).length if @text

        $document.bind "keydown", (event) =>
          if (event.which is 115 or event.which is 83) and (event.ctrlKey or event.metaKey)
            @save('ctrls')

            event.stopPropagation()
            event.preventDefault()
            return false
          true

        @save = (e) =>
            if @changed
                @state = 'saving'
                $http
                    method: 'POST'
                    url: '/texts'
                    data:
                        text: @text
                        date: @current_date
                        counter: @getWordCounter()
                .success (data, status, headers) =>
                    if (data.message)
                        AlertService.send "danger", data.message, 3000
                        return
                    AlertService.send "success", "Продолжайте!", "Сохранение прошло успешно!", 2000 if e is 'ctrls'
                    @state = 'saved'
                    @changed = false
                    return
                .error (data, status, headers) ->
                    AlertService.send "danger", "Упс!", "Сервер не доступен, продолжайте и попробуйте сохраниться через 5 минут!", 4000 if e is 'ctrls'
                    return

            else
                AlertService.send "success", "Продолжайте!", "Ничего не изменилось с прошлого сохранения!", 2000 if e is 'ctrls'
            return

        @showText = (date) =>
            if @current_date.setHours(0,0,0,0) > (new Date(@curMonth + '-' + date)).setHours(0,0,0,0)
                date = date + ''
                date = if date.length is 2 then date else '0' + date
                @hideToday = true
                @curDate = (new Date(@curMonth + '-' + date))
                $http.get( '/text/' + @curMonth + '-' + date).success((data, status, headers) =>
                        @historyText = data.text
                        return
                    )
            else if @current_date.setHours(0,0,0,0) is (new Date(@curMonth + '-' + date)).setHours(0,0,0,0)
                @hideToday = false
                @historyText = ''
                @curDate = @current_date
            else
                AlertService.send "info", "Машину времени пока изобретаем", "Давайте жить сегодняшним днем!", 3000
                return
            return


        AlertService.send "info", "С возвращением, " + @authentication.user.displayName, "Давайте писать!", 3000 if @authentication.user

        $scope.$watch "text", (newVal, oldVal) ->
            @changed = newVal isnt oldVal and oldVal isnt ''
            if @changed
                @state = 'notsaved'
                @days[cd - 1] = @getWordCounter()
            return



        $scope.$watch 'curMonth', =>

            # /2015-01 январь
            request_string = cy + "-" + ("0" + (cm + 1)).slice(-2)

            $http.get('/texts/' + request_string).success((data, status, headers) =>
                daysN = daysInMonth cm, cy

                # make empty days in month array with 0-s
                @days = Array.apply(null, new Array(daysN)).map(Number.prototype.valueOf,0)

                # set last index
                limit = cd if @isCurrentMonth


                data.forEach (e, i) =>
                    @days[(new Date(e.date)).getDate() - 1] = e.counter
                    return

                if limit
                    @days[limit..daysN] = Array.apply(null, new Array(daysN - limit)).map(String.prototype.valueOf, "--")

                return
            )
            return

        $http
            method: 'GET'
            url: '/today'
        .success (data, status, headers) =>
            @text = data.text
            @state = 'saved'
            setInterval @save, 10000 # 10 seconds to autosave
            return
        .error (data, status, headers) ->
            return

        return
]
