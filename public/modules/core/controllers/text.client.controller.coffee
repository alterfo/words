'use strict'

angular.module('core').controller 'TextController', [
    '$scope'
    '$http'
    '$stateParams'
    '$location'
    'Authentication'
    '$document'
    "AlertService"
    ($scope, $http, $stateParams, $location, Authentication, $document, AlertService) ->
        $scope.authentication = Authentication
       
        $scope.text = ''
        $scope.changed = 0
        $scope.state = 'saved' # saved, notsaved, saving
        
        
        
        $scope.getWordCounter = ->
            return $scope.text.trim().split(/\s+/).length if $scope.text
        
        $document.bind "keydown", (event) ->
          if (event.which is 115 or event.which is 83) and (event.ctrlKey or event.metaKey)
            $scope.autosave('ctrls')
            
            event.stopPropagation()
            event.preventDefault()
            return false
          true
    
        $scope.autosave = (e) -> 
            if $scope.changed
                $scope.state = 'saving'
                $http(
                    method: 'POST'
                    url: '/articles'
                    data: 
                        text: $scope.text
                        date: new Date()
                        counter: $scope.getWordCounter()
                )
                .success( (data, status, headers) ->
                    AlertService.add "success", "Продолжайте!", "Сохранение прошло успешно!", 2000 if e is 'ctrls'
                    $scope.state = 'saved' 
                    return
                )
                .error( (data, status, headers) ->
                    AlertService.add "danger", "Упс!", "Сервер не доступен, продолжайте и попробуйте сохраниться через 5 минут!", 4000 if e is 'ctrls'
                    return
                )
                .finally((data, status, headers) ->
                    return
                )
           
            return

        $scope.autosave()
        
        s = setTimeout $scope.autosave, 10000 # 10 seconds to autosave
        
        AlertService.add "info", "С возвращением, " + $scope.authentication.user.displayName, "Давайте писать!", 3000
        
        $scope.$watch "text", (newVal, oldVal) ->
            $scope.changed = newVal isnt oldVal and oldVal isnt ''
            if $scope.changed 
                $scope.state = 'notsaved'
            return

        $http
            method: 'GET'
            url: '/today'
        .success (data, status, headers) ->
            $scope.text = data.text
            $scope.state = 'saved' 
            return
        .error (data, status, headers) ->
            return
]