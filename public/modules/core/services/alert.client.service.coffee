'use strict'

angular.module('core').factory "AlertService", [
  "$timeout"
  "$rootScope"
  ($timeout, $rootScope) ->
    new class AlertService
      constructor: ->
        $rootScope.alerts = []
        return
      send: (type, title, msg, timeout) ->
        $rootScope.alerts.push
          type: type
          title: title
          msg: msg
          close: =>
            @closeAlert @

        timeout = 7000  if typeof timeout is "undefined"
        if timeout
          $timeout =>
            @closeAlert this
            return
          , timeout
        return

      closeAlert: (alert) ->
        @closeAlertIdx $rootScope.alerts.indexOf(alert)

      closeAlertIdx: (index) ->
        $rootScope.alerts.splice index, 1

]
