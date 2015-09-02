// Generated by CoffeeScript 1.9.3
'use strict';
angular.module('core').directive('text', [
  function() {
    return {
      templateUrl: 'modules/core/text/text.client.view.html',
      restrict: 'E',
      scope: {
        editable: this,
        curDate: this
      },
      link: function(scope, element, attrs) {
        scope.editable = attrs.editable || false;
        scope.curDate = curDate || (new Date()).yyyymmdd();
      }
    };
  }
]);