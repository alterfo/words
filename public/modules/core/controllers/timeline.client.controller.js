// Generated by CoffeeScript 1.9.0
"use strict";
angular.module("core").controller("TimelineController", [
  "$scope", "Authentication", "$http", function($scope, Authentication, $http) {
    var DEBUG, cd, cm, cy, daysInMonth;
    $scope.authentication = Authentication;
    Date.prototype.yyyymm = function() {
      var mm, yyyy;
      yyyy = this.getFullYear().toString();
      mm = (this.getMonth() + 1).toString();
      return yyyy + (typeof mm[1] === "function" ? mm[1]({
        mm: "0" + mm[0]
      }) : void 0);
    };
    Date.prototype.yyyymmdd = function() {
      var dd, mm, yyyy;
      yyyy = this.getFullYear().toString();
      mm = (this.getMonth() + 1).toString();
      dd = this.getDate().toString();
      return yyyy + (typeof mm[1] === "function" ? mm[1]({
        mm: "0" + mm[0]
      }) : void 0) + (typeof dd[1] === "function" ? dd[1]({
        dd: "0" + dd[0]
      }) : void 0);
    };
    Date.prototype.nextMonth = function() {
      return this.setMonth(this.getMonth() + 1);
    };
    Date.prototype.prevMonth = function() {
      return this.setMonth(this.getMonth() + 1);
    };
    DEBUG = 1;
    $scope.current_date = new Date();
    cm = $scope.current_date.getMonth();
    cy = $scope.current_date.getFullYear();
    cd = $scope.current_date.getDate();
    $scope.date_to_show = new Date($scope.current_date);
    $scope.month_to_show = $scope.date_to_show.getFullYear() + '' + $scope.date_to_show.getMonth();
    $scope.nextMonth = function() {
      var curMonth;
      curMonth = $scope.date_to_show.nextMonth().yyyymm();
    };
    $scope.prevMonth = function() {
      var curMonth;
      curMonth = $scope.date_to_show.prevMonth().yyyymm();
    };
    $scope.$watch('month_to_show', function() {
      var request_string, sd, sm, sy;
      if (DEBUG) {
        console.log(arguments);
      }
      sm = $scope.date_to_show.getMonth();
      sy = $scope.date_to_show.getFullYear();
      sd = $scope.date_to_show.getDate();
      request_string = sy + "-" + ("0" + (sm + 1)).slice(-2);
      $scope.isCurrentMonth = sm === cm && sy === cy;
      $http.get('/articles/' + request_string).success(function(data, status, headers) {
        var limit, result, _ref;
        if (DEBUG) {
          console.log("data:", data);
        }
        result = Array.apply(null, new Array(daysInMonth(sm, sy))).map(Number.prototype.valueOf, 0);
        if ($scope.isCurrentMonth) {
          limit = cd;
        }
        data.forEach(function(e, i) {
          result[(new Date(e.date)).getDate()] = e.counter;
        });
        if (limit) {
          [].splice.apply(result, [limit, 9e9].concat(_ref = new Array(result.length - limit))), _ref;
        }
        $scope.days = result;
        if (DEBUG) {
          console.log(result);
        }
      });
    });
    daysInMonth = function(month, year) {
      return new Date(year, month, 0).getDate();
    };
  }
]);
