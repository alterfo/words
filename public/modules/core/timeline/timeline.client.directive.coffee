'use strict'
angular.module('core').directive 'timeline', [ ->
  {
    templateUrl: 'modules/core/timeline/timeline.client.view.html'
    restrict: 'E'
    link: (scope, element, attrs) ->
    	console.log scope, element, attrs
      return

  }
 ]