'use strict';

(function() {
	describe('HeaderController', function() {
		//Initialize global variables
		var scope,
			HeaderController;

		// Load the main application module
		beforeEach(module(ApplicationConfiguration.applicationModuleName));

		beforeEach(inject(function($controller, $rootScope) {
			scope = $rootScope.$new();

			HeaderController = $controller('HeaderController', {
				$scope: scope
			});
		}));

		it('should expose the authentication service', function() {
			expect(scope.authentication).toBeTruthy();
		});

		it('should collapse menu', function () {
			scope.isCollapsed = false;

			scope.toggleCollapsibleMenu();

			expect(scope.isCollapsed).toBe(true)
		});

		it('should expose the menu', function () {
			expect(scope.menu).toBeTruthy();
		})
	});
})();
