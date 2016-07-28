'use strict'
angular.module('texts').directive 'text', [ 'TimelineService', 'AlertService', 'DateService', '$stateParams',
  (TimelineService, AlertService, DateService, $stateParams) ->
    templateUrl: 'modules/texts/directives/text/text.client.view.html'
    restrict: 'E'
    controller: 'TextController'
    link: (s,e,a) ->
      if $stateParams.date
        s.insertText($stateParams.date)
      else
        s.insertText('today')
      return
 ]
