// Generated by CoffeeScript 1.10.0
(function() {
  angular.module('core').controller('TimelineController', [
    '$scope', 'TimelineService', '$stateParams', '$locale', function($scope, TimelineService, $stateParams, $locale) {
      var dateString, working_date;
      dateString = $stateParams.date || (new Date()).yyyymm();
      working_date = dateString ? dateString.yyyymmToDate() : new Date();
      $scope.languageMonth = $locale.DATETIME_FORMATS.STANDALONEMONTH[+working_date.getMonth()];
      $scope.days = TimelineService.getTimeline(dateString);
      $scope.prevmonth = working_date.prevMonth().yyyymm();
      if (working_date.nextMonth().isLessThenCurrentMonth()) {
        return $scope.nextmonth = working_date.nextMonth().yyyymm();
      }
    }
  ]);

}).call(this);

//# sourceMappingURL=timeline.client.controller.js.map
