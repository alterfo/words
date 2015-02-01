'use strict'

angular.module('core').factory 'TextService', [
    '$http'
    '$q'
    ($http, $q) ->
        deffered = $q.defer()
        
        
        
        getTodaysText = ->
            $http 
                method: 'GET'
                url: '/articles'
        
        autosave = (e, data) ->
            $http
                method: 'POST'
                url: '/articles'
                data: data
        
        getListByMonth = (month) -> # 'YYYY-MM'
            $http
                method: 'GET'
                url: '/articles' + month
                    
        
        getTodaysText: getTodaysText
        autosave: autosave
        getListByMonth: getListByMonth
        
]