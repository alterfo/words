angular.module('words', [])

    .controller('TextController', function($scope) {
        $scope.counter = 0;
        $scope.text = '';

        $scope.$watch('text', function(newValue, oldValue) {
            $scope.counter += 1;
            if ($scope.counter >= 30) {
                console.log('TODO: save to server');
                $scope.counter = 0;
            }
        });
        $scope.save = function() {
            $http.post('/autosave', {text: $scope.text})
                .success(function() {
                    $scope.status = 'gooood';
                })
                error(function() {
                    $scope.status = 'baaaaad';
                });
        }
    })
    .controller('MainMenuController', function($scope) {
        $scope.navbarCollapsed = true;
    })
;