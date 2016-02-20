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

      TimelineService.fetchTimeline(dateString)

      $scope.days = TimelineService.timeline

      $scope.timeline_button_class = (counter) ->
        if counter is '--' then return 'btn-default'
        if counter is 0 then return 'btn-info'
        if counter > 500 then return 'btn-danger'
        if counter > 0 then return 'btn-success'


      $scope.prevmonth = working_date.prevMonth().yyyymm()
      $scope.nextmonth = working_date.nextMonth().yyyymm() if working_date.nextMonth().isLessThenCurrentMonth()
]
