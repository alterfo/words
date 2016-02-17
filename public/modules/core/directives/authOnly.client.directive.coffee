angular
  .module 'core'
  .directive 'authHide', ['Authentication', (Authentication) ->
    restrict: 'A'
    scope: {
      hide: '='
    }
    link: (scope, element, attrs) ->
      scope.$watch Authentication.user, (value, oldValue) ->
          if (Authentication.user)
           element.addClass('ng-hide')
          else
            element.addClass('ng-hide')
]
  .directive 'authShow', ['Authentication', (Authentication) ->
    restrict: 'A'
    scope: {
      hide: '='
    }
    link: (scope, element, attrs) ->
      scope.$watch Authentication.user, (value, oldValue) ->
        if (!Authentication.user)
          element.addClass('ng-hide')
        else
          element.addClass('ng-hide')
  ]
