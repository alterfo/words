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
    ($scope, $http, $stateParams, $location, Authentication, $document, AlertService, WebApiService, TimelineService) ->
      $scope.authentication = Authentication

      $scope.insertText = (day)->
        if !day
          WebApiService.getToday()
          .then (data) ->
            $scope.text = data.text
            $scope.state = 'saved'
            setInterval $scope.save, 10000
            return
          , (err) ->
            return

      $scope.text = ''
      $scope.getWordCounter = ->
        $scope.text.trim().split(/\s+/).length if $scope.text

      $scope.changed = false

      $scope.$watch "text", (newVal, oldVal) ->
        $scope.changed = newVal isnt oldVal and oldVal isnt ''
        if $scope.changed
          $scope.state = 'notsaved'
          TimelineService.setCounterValue( $scope.getWordCounter())
        return





      $scope.historyText = ''

      $scope.state = 'saved' # saved, notsaved, saving



        #todo: вынести в директиву
      $document.bind "keydown", (event) ->
        if (event.which is 115 or event.which is 83) and (event.ctrlKey or event.metaKey)
          $scope.save('ctrls')

          event.stopPropagation()
          event.preventDefault()
          return false
        true

      $scope.save = (e) ->
          if $scope.changed
              $scope.state = 'saving'
              WebApiService.postText $scope.text
                .then (data) ->
                    if (data.data.message)
                        AlertService.send "danger", data.message, 3000
                        return
                    else
                      AlertService.send "success", "Продолжайте!", "Сохранение прошло успешно!", 2000 if e is 'ctrls'
                      $scope.state = 'saved'
                      $scope.changed = false
                , (err) ->
                    AlertService.send "danger", "Упс!", "Сервер не доступен, продолжайте и попробуйте сохраниться через 5 минут!", 4000 if e is 'ctrls'

          else
              AlertService.send "success", "Продолжайте!", "Ничего не изменилось с прошлого сохранения!", 2000 if e is 'ctrls'
          return

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
