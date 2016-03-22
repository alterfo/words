'use strict'
# Setting up route
angular.module('users')
	.config [ '$stateProvider'
	($stateProvider) ->
		$stateProvider
			.state 'profile',
				url: '/settings/profile'
				templateUrl: 'modules/users/views/settings/edit-profile.client.view.html'
				access: {restricted: true}
			.state 'password',
				url: '/settings/password'
				templateUrl: 'modules/users/views/settings/change-password.client.view.html'
				access: {restricted: true}
		.state 'accounts',
				url: '/settings/accounts'
				templateUrl: 'modules/users/views/settings/social-accounts.client.view.html'
				access: {restricted: true}
			.state 'signup',
				url: '/signup'
				templateUrl: 'modules/users/views/authentication/signup.client.view.html'
				access: {restricted: false}
			.state 'signin',
				url: '/signin'
				templateUrl: 'modules/users/views/authentication/signin.client.view.html'
				access: {restricted: false}
			.state 'forgot',
				url: '/password/forgot'
				templateUrl: 'modules/users/views/password/forgot-password.client.view.html'
				access: {restricted: false}
			.state 'reset-invalid',
				url: '/password/reset/invalid'
				templateUrl: 'modules/users/views/password/reset-password-invalid.client.view.html'
				access: {restricted: false}
			.state 'reset-success',
				url: '/password/reset/success'
				templateUrl: 'modules/users/views/password/reset-password-success.client.view.html'
				access: {restricted: false}
			.state 'reset',
				url: '/password/reset/:token'
				templateUrl: 'modules/users/views/password/reset-password.client.view.html'
				access: {restricted: false}
		return
]
	.run ($rootScope, $location, $route, Auth) ->
		$rootScope.$on '$routeChangeStart', (event, next, current) ->
			if next.access.restricted and Auth.isLoggedIn() is false then $location.path '/login'
