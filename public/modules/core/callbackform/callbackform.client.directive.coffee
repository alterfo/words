'use strict'
angular.module('core').directive 'callbackform', [ ->
  {
    templateUrl: 'modules/core/callbackform/callbackform.client.view.html'
    restrict: 'E'
    link: (scope, element, attrs) ->
        element.on 'click', (e) ->
            e.preventDefault()
            e.stopPropagation()
            return
        return
  }
 ]
