'use strict'
angular.module('core').directive 'sooText', [ 'TimelineService', 'AlertService', 'DateService', '$stateParams',
  (TimelineService, AlertService, DateService, $stateParams) ->
    templateUrl: 'modules/core/views/text.client.view.html'
    restrict: 'E'
    controller: 'TextController'
    link: (s,e,a) ->
      if $stateParams.date
        s.insertText($stateParams.date)
      else
        s.insertText('today')
      return
 ]
