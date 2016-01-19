'use strict'
angular.module('core').directive 'text', [ ->
  {
    templateUrl: 'modules/core/text/text.client.view.html'
    restrict: 'E'
    scope:
    	editable: '@'
    	curDate: '@'
    link: (scope, element, attrs) ->
    	scope.editable = attrs.editable || false;
    	scope.curDate = attrs.curDate || (new Date()).yyyymmdd()
    	return
  }
 ]
