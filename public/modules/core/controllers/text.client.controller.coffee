'use strict'

angular.module('core').controller 'TextController', [
    '$scope'
    '$http'
    '$stateParams'
    '$location'
    'Authentication'
    '$document'
    "AlertService"
    'WebApiService'
    'TimelineService'
    'DateService'
    ($scope, $http, $stateParams, $location, Authentication, $document, AlertService, WebApiService, TimelineService, DateService) ->
      $scope.authentication = Authentication

      $scope.text = ''

      $scope.getWordCounter = ->
        $scope.text.trim().split(/\s+/).length if $scope.text

      $scope.changed = false


      # Order is important. 1st
      $scope.insertText = (todayString)->
        if todayString is DateService.getTodayString()
          WebApiService.getToday()
          .then (response) ->
            $scope.text = response.data.text
            $scope.state = 'saved'
            setInterval $scope.save, 10000
            return
          , (err) ->
            return

      # second
      $scope.$watch "text", (newVal, oldVal) ->
        $scope.changed = newVal isnt oldVal
        if $scope.changed
          $scope.state = 'notsaved'
          TimelineService.setCounterValue DateService.getToday(), $scope.getWordCounter()
        return

      $scope.historyText = ''

      $scope.state = 'saved' # saved, notsaved, saving

      $scope.saveByKeys = (e) ->
        e.preventDefault()
        e.stopPropagation()
        if $scope.changed
          $scope.state = 'saving'
          WebApiService.postText $scope.text
          .then (data) ->
            if (data.data.message)
              AlertService.send "danger", data.data.message, 3000
              return
            else
              AlertService.send "success", "Продолжайте!", "Сохранение прошло успешно!", 2000
              $scope.state = 'saved'
              $scope.changed = false
          , (err) ->
            AlertService.send "danger", "Упс!", "Сервер не доступен, продолжайте и попробуйте сохраниться через 5 минут!", 4000

        else
          AlertService.send "success", "Продолжайте!", "Ничего не изменилось с прошлого сохранения!", 2000


        return false

      $scope.save = () ->
        if $scope.changed
            $scope.state = 'saving'
            WebApiService.postText $scope.text
              .then (data) ->
                  if (data.data.message)
                      AlertService.send "danger", data.message, 3000
                      return
                  else
                    $scope.state = 'saved'
                    $scope.changed = false


      $scope.showText = (date) ->
          if $scope.current_date.setHours(0,0,0,0) > (new Date($scope.curMonth + '-' + date)).setHours(0,0,0,0)
              date = date + ''
              date = if date.length is 2 then date else '0' + date
              $scope.hideToday = true
              $scope.curDate = (new Date($scope.curMonth + '-' + date))
              $http.get( '/text/' + $scope.curMonth + '-' + date).success((data, status, headers) ->
                      $scope.historyText = data.text
                      return
                  )
          else if $scope.current_date.setHours(0,0,0,0) is (new Date($scope.curMonth + '-' + date)).setHours(0,0,0,0)
              $scope.hideToday = false
              $scope.historyText = ''
              $scope.curDate = $scope.current_date
          else
              AlertService.send "info", "Машину времени пока изобретаем", "Давайте жить сегодняшним днем!", 3000
              return
          return
      return
]
