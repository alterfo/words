angular
  .module('core')
  .controller 'TimelineController', [
    '$scope'
    'Authentication'
    'WebApiService'
    '$locale'
    ($scope, Authentication, WebApiService, $locale) ->
      $scope.authentication = Authentication
      $scope.curDate = $locale.DATETIME_FORMATS.STANDALONEMONTH[(new Date()).getMonth()]
      $scope.days = WebApiService.getTimeline((new Date()).getFullYear(), (new Date()).getDate())

]
