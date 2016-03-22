'use strict'
angular.module ApplicationConfiguration.applicationModuleName, ApplicationConfiguration.applicationModuleVendorDependencies
angular
	.module(ApplicationConfiguration.applicationModuleName)
	.config(['$locationProvider', ($locationProvider) ->
		$locationProvider.hashPrefix '!'
		return
])


angular.element(document).ready ->
	if window.location.hash == '#_=_' then window.location.hash = '#!'
	angular.bootstrap document, [ ApplicationConfiguration.applicationModuleName ]
	return
