"use strict"
angular.module("core").controller "TimelineController", [
    "$scope"
    "Authentication"
    "$http"
    ($scope, Authentication, $http) ->
        $scope.authentication = Authentication

        current_date = new Date();

        $scope.current_month = current_date.getMonth()

        $http.get('/articles/2015-01').success((data, status, headers)->
            console.log data, status, headers
            return
        )
        return

]