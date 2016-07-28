'use strict'
angular
  .module('texts')
  .directive 'alerts', [ ->
    templateUrl: 'modules/texts/directives/alerts/alerts.client.view.html'
    restrict: 'E'

]
