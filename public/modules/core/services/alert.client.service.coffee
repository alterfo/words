'use strict'

angular.module('core').factory "AlertService", [
  "$timeout"
  "$rootScope"
  ($timeout, $rootScope) ->
    AlertService = {}
    $rootScope.alerts = []
    AlertService.add = (type, title, msg, timeout) ->
      $rootScope.alerts.push
        type: type
        title: title
        msg: msg
        close: ->
          AlertService.closeAlert this

      timeout = 7000  if typeof timeout is "undefined"
      if timeout
        $timeout ->
          AlertService.closeAlert this
          return
        , timeout
      return

    AlertService.closeAlert = (alert) ->
      @closeAlertIdx $rootScope.alerts.indexOf(alert)

    AlertService.closeAlertIdx = (index) ->
      $rootScope.alerts.splice index, 1

    return AlertService
]