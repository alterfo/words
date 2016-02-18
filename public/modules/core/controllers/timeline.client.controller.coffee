angular
  .module('core')
  .controller 'TimelineController', [
    '$scope'
    'TimelineService'
    '$stateParams'
    '$locale'
    ($scope, TimelineService, $stateParams, $locale) ->

      dateString = $stateParams.date || (new Date()).yyyymm()

      working_date = if dateString then dateString.yyyymmToDate() else new Date()

      $scope.languageMonth = $locale.DATETIME_FORMATS.STANDALONEMONTH[+working_date.getMonth()]

      $scope.days = TimelineService.getTimeline(dateString)

      $scope.prevmonth = working_date.prevMonth().yyyymm()
      $scope.nextmonth = working_date.nextMonth().yyyymm() if working_date.nextMonth().isLessThenCurrentMonth()
]
