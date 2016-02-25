angular
  .module('core')
  .controller 'TimelineController', [
    '$scope'
    'TimelineService'
    '$stateParams'
    ($scope, TimelineService, $stateParams) ->

      $scope.languageMonth = TimelineService.monthLocaleString

      TimelineService.fetchTimeline(TimelineService.workingMonth).then ->
        $scope.days = TimelineService.timeline

      $scope.timeline_button_class = (counter, day) ->
        result = ''
        if counter is '--' then result = 'btn-default'
        if counter is 0 then result = 'btn-info'
        if counter >= 500 then result =  'btn-danger'
        if counter > 0 and counter < 500 then result = 'btn-success'
        if TimelineService.getWorkingDate is $scope.get_date_string(day) then result += ' active'
        result

      $scope.show_next_month = () ->
        TimelineService.workingMonthIsLessThenCurrentMonth()

      $scope.get_date_string = (day) ->
        day = day.toString()
        TimelineService.getWorkingMonth() + '-' + if day.length is 2 then day else "0" + day

      $scope.changeMonth = (direction) ->
        switch direction
          when 'prev' then TimelineService.prevmonth()
          when 'next' then TimelineService.nextmonth()
        TimelineService.fetchTimeline(TimelineService.workingMonth).then ->
          $scope.days = TimelineService.timeline
          $scope.languageMonth = TimelineService.monthLocaleString

      $scope.goToHistory = (dateString) ->


]
