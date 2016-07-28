"use strict"
angular
  .module("texts")
  .controller "HeaderController", ['$scope'
  "AuthService"
  "Menus"
  ($scope, AuthService, Menus) ->
    $scope.user = AuthService.getUser()
    $scope.isCollapsed = false
    $scope.menu = Menus.getMenu("topbar")
    $scope.toggleCollapsibleMenu = ->
      $scope.isCollapsed = not $scope.isCollapsed
      return

    
    # Collapsing the menu after navigation
    $scope.$on "$stateChangeSuccess", ->
      $scope.isCollapsed = false
      return
]
