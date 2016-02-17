angular
  .module('core')
  .controller 'TimelineController', [ '$scope', 'Authentication', 'TextService', ($scope, Authentication, TextService) ->
    $scope.authentication = Authentication

    $scope.curDate = TextService.getTextDate()



]
