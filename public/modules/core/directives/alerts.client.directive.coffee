'use strict'
angular
  .module('core')
  .directive 'alerts', [ ->
    templateUrl: 'modules/core/views/alerts.client.view.html'
    restrict: 'E'

]
