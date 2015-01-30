'use strict'

angular.module('core').controller 'HomeController', [
    '$scope'
    '$http'
    '$stateParams'
    '$location'
    'Authentication'
    '$document'
    ($scope, $http, $stateParams, $location, Authentication, $document) ->
        $scope.authentication = Authentication
       
        $scope.text = ''
        $scope.changed = 0
        $scope.state = 'saved' # saved, notsaved, saving
        
        $scope.getWordCounter = ->
            return $scope.text.trim().split(/\s+/).length if $scope.text
        
        $document.bind "keydown", (event) ->
          if (event.which is 115 or event.which is 83) and (event.ctrlKey or event.metaKey)
            $scope.autosave()
            event.stopPropagation()
            event.preventDefault()
            return false
          true
    
        $scope.autosave = (e) -> 
            if e
                e.preventDefault()
                e.stopPropagation()
            
            if $scope.changed
                $scope.state = 'saving'
                $http(
                    method: 'POST'
                    url: '/articles'
                    data: 
                        text: $scope.text
                        date: new Date()
                        counter: $scope.counter
                )
                .success( (data, status, headers) ->
                    console.log data
                    $scope.state = 'saved'
                    return
                )
                .error( (data, status, headers) ->
                    $scope.error = data;
                    return
                )
                .finally((data, status, headers) ->
                    $scope.loading = false
                    return
                )
           
            return

        $scope.autosave()
        
        s = setTimeout $scope.autosave, 10000 # 10 seconds to autosave
    
        $http
            method: 'GET'
            url: '/articles'
        .success (data, status, headers) ->
            $scope.text = data.text
            return
        .error (data, status, headers) ->
            return
        
        $scope.$watch "text", (newVal, oldVal) ->
           
            $scope.changed = newVal isnt oldVal
            if $scope.changed 
                $scope.state = 'notsaved'
            return
]