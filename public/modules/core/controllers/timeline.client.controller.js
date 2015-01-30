(function() {
  "use strict";
  angular.module("core").controller("TimelineController", [
    "$scope", "Authentication", "$http", function($scope, Authentication, $http) {
      var current_date;
      $scope.authentication = Authentication;
      current_date = new Date();
      $scope.current_month = current_date.getMonth();
      $http.get('/articles/2015-01').success(function(data, status, headers) {
        console.log(data, status, headers);
      });
    }
  ]);

}).call(this);
