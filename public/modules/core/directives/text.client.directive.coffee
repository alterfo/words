'use strict'
angular.module('core').directive 'sooText', [ 'TimelineService', 'AlertService', (TimelineService, AlertService) ->
    templateUrl: 'modules/core/views/text.client.view.html'
    restrict: 'E'
    controller: 'TextController'
    scope: {
      textDate: '='
    }
    link: (s,e,a) ->
      s.insertText(TimelineService.getDay())
      AlertService.send "info", "С возвращением, " + s.authentication.user.displayName, "Давайте писать!", 3000 if s.authentication.user
      return
 ]
