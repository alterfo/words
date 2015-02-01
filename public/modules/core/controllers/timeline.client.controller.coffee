"use strict"
angular.module("core").controller "TimelineController", [
    "$scope"
    "Authentication"
    "$http"
    ($scope, Authentication, $http) ->
        $scope.authentication = Authentication
        
        DEBUG = 1

        $scope.current_date = new Date()
        cm = $scope.current_date.getMonth()
        cy = $scope.current_date.getFullYear()
        cd = $scope.current_date.getDate()

        $scope.date_to_show = new Date $scope.current_date

        $scope.nextMonth = ->
            $scope.date_to_show.setMonth(+1)
            return

        $scope.prevMonth = ->
            $scope.date_to_show.setMonth(-1)
            console.log($scope.date_to_show)
            return

        $scope.$watch 'date_to_show', ->
            console.log(arguments) if DEBUG

            sm = $scope.date_to_show.getMonth()
            sy = $scope.date_to_show.getFullYear()
            sd = $scope.date_to_show.getDate()

            # /2015-01 январь
            request_string = sy + "-" + ("0" + (sm + 1)).slice(-2)

            $scope.isCurrentMonth = (sm == cm && sy == cy)        
 
            $http.get('/articles/' + request_string).success((data, status, headers)->
                console.log("data:", data) if DEBUG

                
                # make empty days in month array with 0-s
                result = Array.apply(null, new Array(daysInMonth(sm, sy))).map(Number.prototype.valueOf,0)

                # set last index
                limit = cd if $scope.isCurrentMonth


                data.forEach (e, i) ->
                    result[(new Date(e.date)).getDate()] = e.counter
                    return

                if limit
                    result[limit..] = new Array(result.length - limit)

                $scope.days = result
                console.log(result) if DEBUG
                return
            )
            return

        daysInMonth = (month,year) ->
            return new Date(year, month, 0).getDate()

        return




]