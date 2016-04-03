'use strict'
angular
	.module('users')
	.controller 'AuthenticationController', ['$scope'
	'$http'
	'$location'
	'$rootScope'
	'AuthService'
	($scope, $http, $location, $rootScope, AuthService) ->
		$scope.user = AuthService.getUser()
		if $scope.user
			$location.path '/'

		$scope.signup = ->
			console.log 'signup'
			AuthService.register $scope.credentials
			.then ->
				$location.path '/today'
				$scope.credentials = {}
			, (err) ->
				$scope.error = err.message

		$scope.signin = ->
			AuthService.login $scope.credentials
			.then ->
				$location.path '/today'
				$scope.credentials = {}
			, (err) ->
				$scope.error = err.message

		$scope.logout = ->
			AuthService.logout().then ->
				$location.path '/welcome'


		return
]

