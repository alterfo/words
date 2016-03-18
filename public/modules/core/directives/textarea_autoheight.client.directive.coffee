'use strict'
angular
  .module('core')
  .directive 'sooText', () ->
    restrict: 'A'
    link: (s,e,a) ->
