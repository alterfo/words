
angular
  .module('users')
  .factory 'AuthService', ['$q', '$timeout', '$http', '$window', ($q, $timeout, $http, $window) ->

    $window.user = null

    getPayload = (token) ->
      JSON.parse $window.atob token.split('.')[1]

    saveToken = (token) ->
      $window.localStorage['token'] = token

    getToken = () ->
      $window.localStorage['token']

    removeToken = ->
      delete $window.localStorage['token']

    isLoggedIn = ->
      token = @getToken()
      if token
        payload = getPayload(token)
        new Date(payload.loginExpires) > Date.now()
      else
        false

    getUserFromToken = ->
      if @isLoggedIn()
        token = @getToken()
        payload = getPayload(token)
        return payload.username

    getUser = ->
      if @isLoggedIn()
        $window.user

    setUser = (user) ->
      $window.user = user


    login = (credentials) ->
      deferred = $q.defer()
      $http.post '/auth/signin', credentials
      .success (data, status) =>
        if status == 200 and data.loginToken #todo: проверка времени и роли
          $window.user = data
          @saveToken data.loginToken
          deferred.resolve()
        else
          $window.user = false
          @removeToken()
          deferred.reject(data)
        return
      .error (data) =>
          $window.user = false
          @removeToken()
          deferred.reject(data)
          return
      deferred.promise

    logout = ->
      deferred = $q.defer()
      $http.get '/auth/signout'
      .success (data) =>
        $window.user = false
        @removeToken()
        deferred.resolve()
      .error (data) ->
        $window.user = false
        @removeToken()
        deferred.reject()
      deferred.promise

    register = (credentials) ->
      deferred = $q.defer()
      $http.post '/auth/signup', credentials
      .success (data, status) =>
        if status == 200 and data.loginToken
          @saveToken data.loginToken
          deferred.resolve()
        else
          deferred.reject()
        return
      .error (data) ->
        deferred.reject(data)
      deferred.promise


    return {
      isLoggedIn: isLoggedIn
      getUser: getUser
      login: login
      logout: logout
      register: register
      saveToken: saveToken
      getToken: getToken
      getUserFromToken: getUserFromToken
      removeToken: removeToken
    }

]
