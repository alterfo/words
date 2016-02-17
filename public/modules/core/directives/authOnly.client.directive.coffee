angular
  .module 'core'
  .directive 'authHide', ['Authentication', (Authentication) ->
    restrict: 'A'
    link: (scope, element, attrs) ->
      scope.authentication = Authentication
      scope.$watch scope.authentication, (value, oldValue) ->
          if (scope.authentication.user)
           element.addClass('ng-hide')
          else
            element.addClass('ng-hide')
]
  .directive 'authShow', ['Authentication', (Authentication) ->
    restrict: 'A'
    link: (scope, element, attrs) ->
      scope.authentication = Authentication
      scope.$watch scope.authentication, (value, oldValue) ->
        if (!scope.authentication.user)
          element.addClass('ng-hide')
        else
          element.addClass('ng-hide')
  ]
