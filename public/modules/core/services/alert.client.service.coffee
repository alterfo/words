'use strict'

angular.module('core').factory "alertService", [
  "$timeout"
  "$rootScope"
  ($timeout, $rootScope) ->
    alertService = {}
    $rootScope.alerts = []
    alertService.add = (type, title, msg, timeout) ->
      $rootScope.alerts.push
        type: type
        title: title
        msg: msg
        close: ->
          alertService.closeAlert this

      timeout = 7000  if typeof timeout is "undefined"
      if timeout
        $timeout (->
          alertService.closeAlert this
          return
        ), timeout
      return

    alertService.closeAlert = (alert) ->
      @closeAlertIdx $rootScope.alerts.indexOf(alert)

    alertService.closeAlertIdx = (index) ->
      $rootScope.alerts.splice index, 1

    return alertService
]