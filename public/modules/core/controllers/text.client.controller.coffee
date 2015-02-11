'use strict'

angular.module('core').controller 'TextController', [
    '$scope'
    '$http'
    '$stateParams'
    '$location'
    'Authentication'
    '$document'
    "AlertService"
    ($scope, $http, $stateParams, $location, Authentication, $document, AlertService) ->

        DEBUG = 1

        $scope.current_date = new Date()

        cm = $scope.current_date.getMonth()
        cy = $scope.current_date.getFullYear()
        cd = $scope.current_date.getDate()

        $scope.date_to_show = new Date $scope.current_date
        $scope.month_to_show = $scope.date_to_show.getFullYear() + '' + $scope.date_to_show.getMonth()
        $scope.curMonth = $scope.date_to_show.yyyymm()
        $scope.curDate = $scope.date_to_show.yyyymmdd()

        $scope.authentication = Authentication
        $scope.historyText = ''
        $scope.text = ''
        $scope.changed = false
        $scope.state = 'saved' # saved, notsaved, saving
        daysInMonth = (month,year) ->
            new Date(year, month, 0).getDate()
        $scope.nextMonth = ->
            $scope.curMonth = $scope.date_to_show.nextMonth().yyyymm()
            return

        $scope.prevMonth = ->
            $scope.curMonth = $scope.date_to_show.prevMonth().yyyymm()
            return
        
        $scope.getWordCounter = ->
            $scope.text.trim().split(/\s+/).length if $scope.text

        $document.bind "keydown", (event) ->
          if (event.which is 115 or event.which is 83) and (event.ctrlKey or event.metaKey)
            $scope.save('ctrls')
            
            event.stopPropagation()
            event.preventDefault()
            return false
          true
    
        $scope.save = (e) -> 
            if $scope.changed
                $scope.state = 'saving'
                $http(
                    method: 'POST'
                    url: '/texts'
                    data: 
                        text: $scope.text
                        date: new Date()
                        counter: $scope.getWordCounter()
                )
                .success( (data, status, headers) ->
                    AlertService.send "success", "Продолжайте!", "Сохранение прошло успешно!", 2000 if e is 'ctrls'
                    $scope.state = 'saved'
                    $scope.changed = false
                    return
                )
                .error( (data, status, headers) ->
                    AlertService.send "danger", "Упс!", "Сервер не доступен, продолжайте и попробуйте сохраниться через 5 минут!", 4000 if e is 'ctrls'
                    return
                )
                .finally((data, status, headers) ->
                    return
                )
            else
                AlertService.send "success", "Продолжайте!", "Ничего не изменилось с прошлого сохранения!", 2000 if e is 'ctrls'
            return
        
        $scope.showText = (date) ->
            console.log $scope.current_date, (new Date($scope.curMonth + '-' + date))
            if $scope.current_date.setHours(0,0,0,0) > (new Date($scope.curMonth + '-' + date)).setHours(0,0,0,0)
                date = date + ''
                date = if date.length is 2 then date else '0' + date
                $scope.hideToday = true
                $scope.curDate = new Date($scope.curMonth + '-' + date)
                $http.get( '/text/' + $scope.curMonth + '-' + date).success((data, status, headers) ->
                        $scope.historyText = data.text
                        return
                    )
            else if $scope.current_date.setHours(0,0,0,0) is (new Date($scope.curMonth + '-' + date)).setHours(0,0,0,0)
                $scope.hideToday = false
                $scope.historyText = ''
            else
                AlertService.send "info", "Машину времени пока изобретаем", "Давайте жить сегодняшним днем!", 3000
                return
            return


        AlertService.send "info", "С возвращением, " + $scope.authentication.user.displayName, "Давайте писать!", 3000 if $scope.authentication.user

        $scope.$watch "text", (newVal, oldVal) ->
            $scope.changed = newVal isnt oldVal and oldVal isnt ''
            if $scope.changed 
                $scope.state = 'notsaved'
                $scope.days[cd - 1] = $scope.getWordCounter()
            return



        $scope.$watch 'curMonth', ->
            console.log(arguments) if DEBUG

            sm = $scope.date_to_show.getMonth()
            sy = $scope.date_to_show.getFullYear()
            sd = $scope.date_to_show.getDate()

            # /2015-01 январь
            request_string = sy + "-" + ("0" + (sm + 1)).slice(-2)
            console.log request_string
            $scope.isCurrentMonth = (sm == cm && sy == cy)        
 
            $http.get('/texts/' + request_string).success((data, status, headers)->
                console.log("data:", data) if DEBUG

                
                # make empty days in month array with 0-s
                $scope.days = Array.apply(null, new Array(daysInMonth(sm, sy))).map(Number.prototype.valueOf,0)

                # set last index
                limit = cd if $scope.isCurrentMonth


                data.forEach (e, i) ->
                    $scope.days[(new Date(e.date)).getDate() - 1] = e.counter
                    return

                if limit
                    $scope.days[limit..32] = Array.apply(null, new Array($scope.days.length - limit)).map(String.prototype.valueOf, "--")

                $scope.days = $scope.days
                console.log($scope.days) if DEBUG
                return
            )
            return

        $http
            method: 'GET'
            url: '/today'
        .success (data, status, headers) ->
            $scope.text = data.text
            $scope.state = 'saved'
            setInterval $scope.save, 10000 # 10 seconds to autosave
            return
        .error (data, status, headers) ->
            return

        return
]