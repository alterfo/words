"use strict"
angular
  .module("texts")
  .controller "CallbackController",
  ['$scope', "AuthService", '$http',

    ($scope, AuthService, $http) ->
      $scope.user = AuthService.getUser()

      $scope.preventClose = (e) ->
          e.stopPropagation();

      $scope.send_callback = ->
         $http.post '/callback',
           callback_text: $scope.callback_text

      return

]
