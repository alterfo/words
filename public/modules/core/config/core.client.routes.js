'use strict';

// Setting up route
angular.module('core').config(['$stateProvider', '$urlRouterProvider',
	function($stateProvider, $urlRouterProvider) {
		// Redirect to home view when route not found
		$urlRouterProvider.otherwise('/');

		$stateProvider.
			state('home', {
				url: '/',
				templateUrl: 'modules/core/home/home.client.view.html'
			});
	}
]);