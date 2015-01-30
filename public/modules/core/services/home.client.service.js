(function() {
  'use strict';
  angular.module('core').factory("alertService", [
    "$timeout", "$rootScope", function($timeout, $rootScope) {
      var alertService;
      alertService = {};
      $rootScope.alerts = [];
      alertService.add = function(type, title, msg, timeout) {
        $rootScope.alerts.push({
          type: type,
          title: title,
          msg: msg,
          close: function() {
            return alertService.closeAlert(this);
          }
        });
        if (typeof timeout === "undefined") {
          timeout = 7000;
        }
        if (timeout) {
          $timeout((function() {
            alertService.closeAlert(this);
          }), timeout);
        }
      };
      alertService.closeAlert = function(alert) {
        return this.closeAlertIdx($rootScope.alerts.indexOf(alert));
      };
      alertService.closeAlertIdx = function(index) {
        return $rootScope.alerts.splice(index, 1);
      };
      return alertService;
    }
  ]);

}).call(this);
