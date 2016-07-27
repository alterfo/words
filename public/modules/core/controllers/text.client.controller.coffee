'use strict'

angular.module('core').controller 'TextController', [
    '$scope'
    '$http'
    '$stateParams'
    '$location'
    'AuthService'
    '$document'
    "AlertService"
    'WebApiService'
    'TimelineService'
    'DateService'
    ($scope, $http, $stateParams, $location, AuthService, $document, AlertService, WebApiService, TimelineService, DateService) ->
      $scope.user = AuthService.getUser()

      $scope.history = {}
      $scope.todayDateString = DateService.getTodayString()

      $scope.getWordCounter = ->

        if $scope.text && $scope.text.trim()
          $scope.text.trim().split(/[\s,.;]+/).length
        else
          0

      $scope.changed = false





      $scope.$watch "text", (newVal, oldVal) ->
        $scope.changed = newVal isnt oldVal and oldVal isnt undefined
        if $scope.changed
          $scope.state = 'notsaved'
          TimelineService.setCounterValue DateService.getToday(), $scope.getWordCounter()
        return

      $scope.insertText = ()->
        WebApiService.getToday()
        .then (response) ->
          $scope.text = response.data.text
          $scope.state = 'saved'
          setInterval $scope.save, 10000
        , (err) ->
          return

      $scope.historyText = ''

      $scope.state = 'saved' # saved, notsaved, saving

      $scope.saveByKeys = (e) ->
        e.preventDefault()
        e.stopPropagation()
        if $scope.changed and $scope.text isnt undefined
          $scope.state = 'saving'
          WebApiService.postText $scope.text
          .then (data) ->
            if (data.data.message)
              AlertService.send "danger", data.data.message, 3000
              $scope.state = 'notsaved'
              return
            else
              AlertService.send "success", "Продолжайте!", "Сохранение прошло успешно!", 2000
              $scope.state = 'saved'
              $scope.changed = false
          , (err) ->
            AlertService.send "danger", "Упс!", err, 4000
            $scope.state = 'notsaved'

        else
          AlertService.send "success", "Продолжайте!", "Ничего не изменилось с прошлого сохранения!", 2000
        return false

      $scope.putTab = (e) ->
          e.preventDefault()
          start = e.target.selectionStart
          end = e.target.selectionEnd
          $scope.text = $scope.text.substring(0, start) + '\t' + $scope.text.substring(end)
          angular.element(e.target).val($scope.text)
          e.target.selectionStart = e.target.selectionEnd = start + 1

      $scope.save = () ->
        if $scope.changed and $scope.text isnt ''
            $scope.state = 'saving'
            WebApiService.postText $scope.text
              .then (data) ->
                  if (data.data.message)
                      AlertService.send "danger", data.message, 3000
                      return
                  else
                    $scope.state = 'saved'
                    $scope.changed = false
              , (err) ->
                AlertService.send "danger", "Упс!", err, 4000


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

      $scope.$watch ->
        TimelineService.workingDate
      , (value, oldval) ->
        if value isnt $scope.todayDateString
          WebApiService.getText(value)
            .then (response) ->
              $scope.history.text = response.data.text
              $scope.history.date = value
            , (err) ->
              return
        else
          $scope.history = {}


      return
]
