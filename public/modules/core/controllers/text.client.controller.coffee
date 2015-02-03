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
        Date.prototype.yyyymm = ->
           yyyy = this.getFullYear().toString()
           mm = (this.getMonth()+1).toString()
           yyyy + (if mm.length == 2 then mm else "0" + mm)

        Date.prototype.yyyymmdd = ->
           yyyy = this.getFullYear().toString()
           mm = (this.getMonth()+1).toString()
           dd  = this.getDate().toString();
           console.log yyyy + (mm[1]?mm:"0"+mm[0]) + (dd[1]?dd:"0"+dd[0])
           yyyy + (if mm.length == 2 then mm else "0" + mm) + (if dd.length == 2 then dd else "0" + dd)

        Date.prototype.nextMonth = ->
           new Date(this.setMonth(this.getMonth() + 1))

        Date.prototype.prevMonth = ->
           new Date(this.setMonth(this.getMonth() - 1))

        DEBUG = 1

        $scope.current_date = new Date()
        cm = $scope.current_date.getMonth()
        cy = $scope.current_date.getFullYear()
        cd = $scope.current_date.getDate()

        $scope.date_to_show = new Date $scope.current_date
        $scope.month_to_show = $scope.date_to_show.getFullYear() + '' + $scope.date_to_show.getMonth()
        $scope.curMonth = $scope.date_to_show.yyyymm
        $scope.curDate = $scope.date_to_show.yyyymmdd

        $scope.authentication = Authentication
       
        $scope.text = ''
        $scope.changed = 0
        $scope.state = 'saved' # saved, notsaved, saving
        
        $scope.nextMonth = ->
            $scope.curMonth = $scope.date_to_show.nextMonth().yyyymm()
            return

        daysInMonth = (month,year) ->
            return new Date(year, month, 0).getDate()

        $scope.prevMonth = ->
            $scope.curMonth = $scope.date_to_show.prevMonth().yyyymm()
            return
        
        $scope.getWordCounter = ->
            return $scope.text.trim().split(/\s+/).length if $scope.text
        
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
                    url: '/articles'
                    data: 
                        text: $scope.text
                        date: new Date()
                        counter: $scope.getWordCounter()
                )
                .success( (data, status, headers) ->
                    AlertService.add "success", "Продолжайте!", "Сохранение прошло успешно!", 2000 if e is 'ctrls'
                    $scope.state = 'saved' 
                    return
                )
                .error( (data, status, headers) ->
                    AlertService.add "danger", "Упс!", "Сервер не доступен, продолжайте и попробуйте сохраниться через 5 минут!", 4000 if e is 'ctrls'
                    return
                )
                .finally((data, status, headers) ->
                    return
                )
            else
                AlertService.add "success", "Продолжайте!", "Ничего не изменилось с прошлого сохранения!", 2000 if e is 'ctrls'
            return
        
        AlertService.add "info", "С возвращением, " + $scope.authentication.user.displayName, "Давайте писать!", 3000
        
        $scope.$watch "text", (newVal, oldVal) ->
            $scope.changed = newVal isnt oldVal and oldVal isnt ''
            if $scope.changed 
                $scope.state = 'notsaved'
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
 
            $http.get('/articles/' + request_string).success((data, status, headers)->
                console.log("data:", data) if DEBUG

                
                # make empty days in month array with 0-s
                result = Array.apply(null, new Array(daysInMonth(sm, sy))).map(Number.prototype.valueOf,0)

                # set last index
                limit = cd if $scope.isCurrentMonth


                data.forEach (e, i) ->
                    result[(new Date(e.date)).getDate() - 1] = e.counter
                    return

                if limit
                    result[limit..32] = Array.apply(null, new Array(result.length - limit)).map(String.prototype.valueOf, "--")

                $scope.days = result
                console.log(result) if DEBUG
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