'use strict'
angular.module('core').directive 'sooText', [ ->
    templateUrl: 'modules/core/views/text.client.view.html'
    restrict: 'E'
    controller: 'TextController'
 ]
