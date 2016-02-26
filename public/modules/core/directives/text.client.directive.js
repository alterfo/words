// Generated by CoffeeScript 1.9.3
(function() {
  'use strict';
  angular.module('core').directive('sooText', [
    'TimelineService', 'AlertService', 'DateService', '$stateParams', function(TimelineService, AlertService, DateService, $stateParams) {
      return {
        templateUrl: 'modules/core/views/text.client.view.html',
        restrict: 'E',
        controller: 'TextController',
        link: function(s, e, a) {
          if ($stateParams.date) {
            s.insertText($stateParams.date);
          } else {
            s.insertText('today');
          }
        }
      };
    }
  ]);

}).call(this);

//# sourceMappingURL=text.client.directive.js.map
