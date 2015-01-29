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
                    return
                )
                .error( (data, status, headers) ->
                    $scope.error = data;
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
           
            $scope.changed =  newVal isnt oldVal
            return
]