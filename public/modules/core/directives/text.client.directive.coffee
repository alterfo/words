'use strict'
angular.module('core').directive 'sooText', [ 'TimelineService', 'AlertService', 'DateService', (TimelineService, AlertService, DateService) ->
    templateUrl: 'modules/core/views/text.client.view.html'
    restrict: 'E'
    controller: 'TextController'
    scope: {
      textDate: '='
    }
    link: (s,e,a) ->
      s.insertText(DateService.getTodayString())
      return
 ]
