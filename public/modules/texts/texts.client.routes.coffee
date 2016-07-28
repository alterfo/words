'use strict'
angular
  .module('texts')
  .config ['$stateProvider', '$urlRouterProvider', ($stateProvider, $urlRouterProvider) ->

    $stateProvider
      .state 'today',
        url: '/today'
        templateUrl: 'modules/texts/main-views/today/today.view.html'
        controller: 'todayCtrl'
        access: {restricted: true}
      .state 'history',
        url: '/history/:date'
        templateUrl: 'modules/texts/main-views/history/history.view.html'
        access: {restricted: true}
      .state 'about',
        url: '/about',
        templateUrl: 'modules/texts/main-views/about/about.client.view.html'
        access: {restricted: false}
      .state 'welcome',
        url: '/welcome'
        templateUrl: 'modules/texts/main-views/welcome/welcome.client.view.html'
        access: {restricted: false}

    $urlRouterProvider.otherwise '/signin'

]
