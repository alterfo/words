"use strict"
angular.module("core").controller "TimelineController", [
    "$scope"
    "Authentication"
    "$http"
    ($scope, Authentication, $http) ->
        $scope.authentication = Authentication

        current_date = new Date();
        $scope.current_year = current_date.getFullYear()
        $scope.current_month = current_date.getMonth()
        $scope.current_date = current_date.getDate()


        $http.get('/articles/2015-01').success((data, status, headers)->
            $scope.days = data
            return
        )
        return

]