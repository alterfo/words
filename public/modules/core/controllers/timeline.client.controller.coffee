angular
  .module('core')
  .controller 'TimelineController', [
    '$scope'
    'WebApiService'
    '$locale'
    ($scope, WebApiService, $locale) ->
      $scope.curDate = $locale.DATETIME_FORMATS.STANDALONEMONTH[(new Date()).getMonth()]
      $scope.days = WebApiService.getTimeline((new Date()).getFullYear(), (new Date()).getDate())
]
