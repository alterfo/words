angular
  .module('core')
  .controller 'TimelineController', [
    '$scope'
    'TimelineService'
    '$stateParams'
    ($scope, TimelineService, $stateParams) ->

      if $stateParams.date
        TimelineService.setWorkingMonth $stateParams.date

      $scope.languageMonth = TimelineService.monthLocaleString

      TimelineService.fetchTimeline(TimelineService.workingMonth).then ->
        $scope.days = TimelineService.timeline

      $scope.timeline_button_class = (counter) ->
        if counter is '--' then return 'btn-default'
        if counter is 0 then return 'btn-info'
        if counter > 500 then return 'btn-danger'
        if counter > 0 then return 'btn-success'


      $scope.prevmonth = TimelineService.prevMonthString()
      $scope.nextmonth = TimelineService.nextMonthString() if TimelineService.workingMonthIsLessThenCurrentMonth()
]
