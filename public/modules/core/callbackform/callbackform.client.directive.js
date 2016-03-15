// Generated by CoffeeScript 1.10.0
(function() {
  'use strict';
  angular.module('core').directive('callbackform', [
    function() {
      return {
        templateUrl: 'modules/core/callbackform/callbackform.client.view.html',
        restrict: 'E',
        link: function(scope, element, attrs) {
          element.on('click', function(e) {
            e.preventDefault();
            e.stopPropagation();
          });
        }
      };
    }
  ]);

}).call(this);