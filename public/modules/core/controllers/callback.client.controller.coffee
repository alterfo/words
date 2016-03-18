"use strict"
angular
  .module("core")
  .controller "CallbackController",
  ['$scope', "Authentication", '$http',

    ($scope, Authentication, $http) ->
      $scope.authentication = Authentication

      $scope.preventClose = (e) ->
          e.stopPropagation();

      $scope.send_callback = ->
         $http.post '/callback',
           callback_text: $scope.callback_text

      return

]
