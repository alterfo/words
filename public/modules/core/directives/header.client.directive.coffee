'use strict'
angular
  .module('core')
  .directive 'sooHeader', [ ->
    templateUrl: 'modules/core/views/header.client.view.html'
    restrict: 'E'
    controller: 'HeaderController'
    scope: {}
]
