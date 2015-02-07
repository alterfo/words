'use strict'
angular.module('core').directive 'text', [ ->
  {
    templateUrl: 'modules/core/views/text.client.view.html'
    restrict: 'E'
    scope:
    	editable: @
    	curDate: @
    link: (scope, element, attrs) ->
    	scope.editable = attrs.editable || false;
    	scope.curDate = curDate || (new Date()).yyyymmdd()
    	return

  }
 ]