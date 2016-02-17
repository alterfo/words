angular
  .module('core')
  .controller 'TimelineController', [
    '$scope'
    'Authentication'
    'WebApiService'
    ($scope, Authentication, WebApiService) ->
      $scope.authentication = Authentication
      $scope.curDate = new Date()
      $scope.days = WebApiService.getTimeline((new Date()).getFullYear(), (new Date()).getDate())
]
