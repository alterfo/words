'use strict'
angular.module('core').directive 'timeline', [ ->
    templateUrl: 'modules/core/views/timeline.client.view.html'
    restrict: 'E'
    scope: {}
    controller: 'TimelineController'
 ]
