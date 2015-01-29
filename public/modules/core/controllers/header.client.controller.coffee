"use strict"
angular.module("core").controller "HeaderController", [
  "$scope"
  "Authentication"
  "Menus"
  ($scope, Authentication, Menus) ->
    $scope.authentication = Authentication
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