// Generated by CoffeeScript 1.10.0
(function() {
  'use strict';
  angular.module('core').directive('timeline', [
    function() {
      return {
        templateUrl: 'modules/core/timeline/timeline.client.view.html',
        restrict: 'E',
        link: function(scope, element, attrs) {
          return console.log(scope, element, attrs);
        }
      };
    }
  ]);

}).call(this);