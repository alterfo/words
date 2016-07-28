'use strict'
angular
  .module('texts')
  .directive 'sooHeader', [ ->
    templateUrl: 'modules/texts/directives/header/header.client.view.html'
    restrict: 'E'
    controller: 'HeaderController'
    scope: {}
]
