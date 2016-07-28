angular
.module 'texts'
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
