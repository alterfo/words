(function() {
  'use strict';
  angular.module('core').controller('TextController', [
    '$scope', '$http', '$stateParams', '$location', 'Authentication', '$document', "alertService", function($scope, $http, $stateParams, $location, Authentication, $document, alertService) {
      var s;
      $scope.authentication = Authentication;
      $scope.text = '';
      $scope.changed = 0;
      $scope.state = 'saved';
      $scope.getWordCounter = function() {
        if ($scope.text) {
          return $scope.text.trim().split(/\s+/).length;
        }
      };
      $document.bind("keydown", function(event) {
        if ((event.which === 115 || event.which === 83) && (event.ctrlKey || event.metaKey)) {
          $scope.autosave('ctrls');
          event.stopPropagation();
          event.preventDefault();
          return false;
        }
        return true;
      });
      $scope.autosave = function(e) {
        if ($scope.changed) {
          $scope.state = 'saving';
          $http({
            method: 'POST',
            url: '/articles',
            data: {
              text: $scope.text,
              date: new Date(),
              counter: $scope.getWordCounter()
            }
          }).success(function(data, status, headers) {
            if (e === 'ctrls') {
              alertService.add("success", "Продолжайте!", "Сохранение прошло успешно!", 2000);
            }
            $scope.state = 'saved';
          }).error(function(data, status, headers) {
            if (e === 'ctrls') {
              alertService.add("danger", "Упс!", "Сервер не доступен, продолжайте и попробуйте сохраниться через 5 минут!", 4000);
            }
          })["finally"](function(data, status, headers) {});
        }
      };
      $scope.autosave();
      s = setTimeout($scope.autosave, 10000);
      alertService.add("info", "С возвращением, " + $scope.authentication.user.displayName, "Давайте писать!", 3000);
      $scope.$watch("text", function(newVal, oldVal) {
        $scope.changed = newVal !== oldVal && oldVal !== '';
        if ($scope.changed) {
          $scope.state = 'notsaved';
        }
      });
      return $http({
        method: 'GET',
        url: '/today'
      }).success(function(data, status, headers) {
        $scope.text = data.text;
        $scope.state = 'saved';
      }).error(function(data, status, headers) {});
    }
  ]);

}).call(this);
