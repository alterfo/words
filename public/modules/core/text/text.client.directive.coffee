'use strict'
angular.module('core').directive 'words', [ ->
  {
    templateUrl: 'modules/core/text/text.client.view.html'
    restrict: 'E'
    scope:
    	editable: "@"
    	curDate: "@"
    link: (scope, element, attrs) ->
    	scope.editable = true
    	scope.curDate = (new Date()).yyyymmdd()
    	return

  }
 ]
