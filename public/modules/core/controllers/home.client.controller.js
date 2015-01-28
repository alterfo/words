'use strict';


angular.module('core').controller('HomeController', ['$scope', '$stateParams', '$location', 'Authentication', 'Articles',
 function ($scope, $stateParams, $location, Authentication, Articles) {
    // This provides Authentication context.
    $scope.authentication = Authentication;

    var counter = 0;

    $scope.$watch('text', function (newVal, oldVal) {

            counter++;

            if (counter > 30) {
                console.log('saveData');
                var article = new Articles({
                    text: this.text,
                    date: Date.now
                });
                article.$save(function (response) {
                    // TODO: show message

                }, function (errorResponse) {
                    $scope.error = errorResponse.data.message;
                });
                counter = 0;
            }

        
    });

        $scope.find = function () {
            $scope.articles = Articles.query();
        };

        $scope.findOne = function () {
            $scope.article = Articles.get({
            articleId: $stateParams.articleId
        });
            
        $scope.findToday = function () {
            $scope.article = Articles.get({
                _id: 
            })
        }
        };
}]);