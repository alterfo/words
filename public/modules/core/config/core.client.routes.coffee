'use strict'
angular
  .module('core')
  .config ['$stateProvider', '$urlRouterProvider', ($stateProvider, $urlRouterProvider) ->
    $urlRouterProvider.otherwise '/today'

    $stateProvider
      .state 'today',
        url: '/today'
        templateUrl: 'modules/core/views/home.client.view.html'
      .state 'history',
        url: '/history/:date'
        templateUrl: 'modules/core/views/home.client.view.html'
      .state 'about',
        url: '/about',
        templateUrl: 'modules/core/views/about.client.view.html'
]
