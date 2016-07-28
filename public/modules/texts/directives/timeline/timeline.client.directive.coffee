'use strict'
angular.module('texts').directive 'timeline', [ ->
    templateUrl: 'modules/texts/directives/timeline/timeline.client.view.html'
    restrict: 'E'
    scope: {}
    controller: 'TimelineController'
 ]
