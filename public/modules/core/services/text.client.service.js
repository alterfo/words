'use strict';
angular.module('core').factory('TextService', [
  '$http', '$q', function($http, $q) {
    var autosave, deffered, getListByMonth, getTodaysText;
    deffered = $q.defer();
    getTodaysText = function() {
      return $http({
        method: 'GET',
        url: '/articles'
      });
    };
    autosave = function(e, data) {
      return $http({
        method: 'POST',
        url: '/articles',
        data: data
      });
    };
    getListByMonth = function(month) {
      return $http({
        method: 'GET',
        url: '/articles' + month
      });
    };
    return {
      getTodaysText: getTodaysText,
      autosave: autosave,
      getListByMonth: getListByMonth
    };
  }
]);
