'use strict'
angular.module('core').directive 'callbackform', [ ->
  {
    templateUrl: 'modules/core/views/callbackform.client.view.html'
    restrict: 'E'
    link: (scope, element, attrs) ->
        element.on 'click', (e) ->
            e.preventDefault()
            e.stopPropagation()
            return
          return
  }
 ]