'use strict';


angular.module('core').controller('HomeController', ['$scope', '$stateParams', '$location', 'Authentication', 'Articles',
 function ($scope, $stateParams, $location, Authentication, Articles) {
    // This provides Authentication context.
    $scope.authentication = Authentication;

    $scope.counter = 0;

    $scope.$watch('text', function (newVal, oldVal) {

            $scope.counter++;
            

            if (!($scope.counter%30)) {
                console.log('saveData', article);
                var article = new Articles({
                    text: $scope.text,
                    date: new Date(),
                    counter: $scope.counter
                });
                article.$save(function (response) {
                    console.log(response)

                }, function (errorResponse) {
                    $scope.error = errorResponse.data.message;
                });
            }
    });

        $scope.find = function () {
            $scope.articles = Articles.query();
        };

        $scope.findOne = function () {
            $scope.article = Articles.get({
            articleId: $stateParams.articleId
        });
            
        };
}]);