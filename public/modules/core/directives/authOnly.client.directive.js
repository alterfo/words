// Generated by CoffeeScript 1.10.0
(function() {
  angular.module('core').directive('authHide', [
    'Authentication', function(Authentication) {
      return {
        restrict: 'A',
        link: function(scope, element, attrs) {
          scope.authentication = Authentication;
          return scope.$watch(scope.authentication, function(value, oldValue) {
            if (scope.authentication.user) {
              return element.addClass('ng-hide');
            } else {
              return element.removeClass('ng-hide');
            }
          });
        }
      };
    }
  ]).directive('authShow', [
    'Authentication', function(Authentication) {
      return {
        restrict: 'A',
        link: function(scope, element, attrs) {
          scope.authentication = Authentication;
          return scope.$watch(scope.authentication, function(value, oldValue) {
            if (scope.authentication.user) {
              return element.removeClass('ng-hide');
            } else {
              return element.addClass('ng-hide');
            }
          });
        }
      };
    }
  ]);

}).call(this);
