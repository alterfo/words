'use strict'
angular
  .module('core')
  .config ['$stateProvider', '$urlRouterProvider', ($stateProvider, $urlRouterProvider) ->

    $stateProvider
      .state 'today',
        url: '/today'
        templateUrl: 'modules/core/views/home.client.view.html'
        access: {restricted: true}
      .state 'history',
        url: '/history/:date'
        templateUrl: 'modules/core/views/home.client.view.html'
        access: {restricted: true}
      .state 'about',
        url: '/about',
        templateUrl: 'modules/core/views/about.client.view.html'
        access: {restricted: false}
      .state 'welcome',
        url: '/welcome'
        templateUrl: 'modules/core/views/welcome.client.view.html'
        access: {restricted: false}

    $urlRouterProvider.otherwise '/signin'

]
