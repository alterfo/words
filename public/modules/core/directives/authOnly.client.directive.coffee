angular
  .module 'core'
  .directive 'authHide', ['AuthService', (AuthService) ->
    restrict: 'A'
    link: (scope, element, attrs) ->
      scope.user = AuthService.getUser()
      scope.$watch scope.user, (value, oldValue) ->
          if (scope.user)
           element.addClass('ng-hide')
          else
            element.removeClass('ng-hide')
]
  .directive 'authShow', ['AuthService', (AuthService) ->
    restrict: 'A'
    link: (scope, element, attrs) ->
      scope.user = AuthService.getUser()
      scope.$watch scope.user, (value, oldValue) ->
        if (scope.user)
          element.removeClass('ng-hide')
        else
          element.addClass('ng-hide')
  ]
