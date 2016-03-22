'use strict'
angular.module('users').controller 'AuthenticationController', [
	'$scope'
	'$http'
	'$location'
	'Authentication'
	'$rootScope'
	'Auth'
	($scope, $http, $location, Authentication, $rootScope, Auth) ->
		$scope.authentication = Authentication
		if $scope.authentication.user
			$location.path '/'

		$scope.signup = ->
			Auth.register $scope.credentials
			.then ->
				$location.path '/today'
				$scope.credentials = {}
			, (err) ->
				$scope.error = err.message



#		$scope.signup = ->
#			$http.post('/auth/signup', $scope.credentials).success((response) ->
#				$scope.authentication.user = response
#				# And redirect to the index page
#				$location.path '/'
#				return
#			).error (response) ->
#				$scope.error = response.message
#				return
#			return

		$scope.signup = ->


		$scope.signin = ->
			Auth.login $scope.credentials
			.then ->
				$location.path '/today'
				$scope.credentials = {}
			, (err) ->
				$scope.error = err.message

		$scope.logout = ->
			Auth.logout().then ->
				$location.path '/welcome'


#			$http.post('/auth/signin', $scope.credentials).success((response) ->
#				$scope.authentication.user = response
#				# And redirect to the index page
#				$location.path '/today'
#				return
#			).error (response) ->
#				$scope.error = response.message
#				return
#			return

		return
]

