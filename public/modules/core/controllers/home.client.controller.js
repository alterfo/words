'use strict';


angular.module('core').controller('HomeController', ['$scope', '$http', '$stateParams', '$location', 'Authentication',
 function ($scope, $http, $stateParams, $location, Authentication) {
    // This provides Authentication context.
    $scope.authentication = Authentication;
    $scope.counter = 0;
    $scope.text = '';
     
    $http({
        method: 'GET',
        url: '/articles'
    }).
    success(function(data, status, headers) {
        $scope.text = data.text;
        console.log(data, 'data from http get');
    }).
    error(function(data, status, headers){
        console.log(arguments, this);
    });
     
    
    

    $scope.$watch('text', function (newVal, oldVal) {

            $scope.counter++;
            

            if ($scope.counter%10 === 0) {
                $http({
                    method: 'POST',
                    url: '/articles',
                    data: {
                        text: $scope.text,
                        date: new Date(),
                        counter: $scope.counter
                    }
                }).
                success(function(data, status, headers) {
                    console.log(data);
                }).
                error(function(data, status, headers) {
                    $scope.error = data;
                    console.log('error');
                });
            }
    });
}]);