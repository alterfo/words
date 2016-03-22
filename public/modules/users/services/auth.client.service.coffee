
angular
  .module('users')
  .factory 'AuthService', ['$q', '$timeout', '$http', ($q, $timeout, $http) ->
    user = null

    isLoggedIn = ->
      !!user

    getUserStatus = ->
      user

    login = (credentials) ->
      deferred = $q.defer()
      $http.post '/auth/signin', credentials
      .success (data, status) ->
        if status == 200 and data.status
          user = true
          deferred.resolve()
        else
          user = false
          deferred.reject(data)
        return
      .error (data) ->
          user = false
          deferred.reject(data)
          return
      deferred.promise

    logout = ->
      deferred = $q.defer()
      $http.get '/auth/signout'
      .success (data) ->
        user = false
        deferred.resolve()
      .error (data) ->
        user = false
        deferred.reject()
      deferred.promise

    register = (credentials) ->
      deferred = $q.defer()
      $http.post '/auth/signup', credentials
      .success (data, status) ->
        if status == 200 and data.status
          deferred.resolve()
        else
          deferred.reject()
        return
      .error (data) ->
        deferred.reject(data)
      deferred.promise


    return {
      isLoggedIn: isLoggedIn
      getUserStatus: getUserStatus
      login: login
      logout: logout
      register: register
    }

]
