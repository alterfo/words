(function() {
  'use strict';
  angular.module('core').controller('HomeController', [
    '$scope', '$http', '$stateParams', '$location', 'Authentication', '$document', function($scope, $http, $stateParams, $location, Authentication, $document) {
      var s;
      $scope.authentication = Authentication;
      $scope.text = '';
      $scope.changed = 0;
      $scope.getWordCounter = function() {
        if ($scope.text) {
          return $scope.text.trim().split(/\s+/).length;
        }
      };
      $document.bind("keydown", function(event) {
        if ((event.which === 115 || event.which === 83) && (event.ctrlKey || event.metaKey)) {
          $scope.autosave();
          event.stopPropagation();
          event.preventDefault();
          return false;
        }
        return true;
      });
      $scope.autosave = function(e) {
        if (e) {
          e.preventDefault();
          e.stopPropagation();
        }
        if ($scope.changed) {
          $http({
            method: 'POST',
            url: '/articles',
            data: {
              text: $scope.text,
              date: new Date(),
              counter: $scope.counter
            }
          }).success(function(data, status, headers) {
            console.log(data);
          }).error(function(data, status, headers) {
            $scope.error = data;
          });
        }
      };
      $scope.autosave();
      s = setTimeout($scope.autosave, 10000);
      $http({
        method: 'GET',
        url: '/articles'
      }).success(function(data, status, headers) {
        $scope.text = data.text;
      }).error(function(data, status, headers) {});
      return $scope.$watch("text", function(newVal, oldVal) {
        $scope.changed = newVal !== oldVal;
      });
    }
  ]);

}).call(this);
