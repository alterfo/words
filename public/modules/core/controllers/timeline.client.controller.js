// Generated by CoffeeScript 1.10.0
(function() {
  angular.module('core').controller('TimelineController', [
    '$scope', 'TimelineService', '$stateParams', '$locale', function($scope, TimelineService, $stateParams, $locale) {
      var dateString, working_date;
      dateString = $stateParams.date || (new Date()).yyyymm();
      working_date = dateString ? dateString.yyyymmToDate() : new Date();
      $scope.languageMonth = $locale.DATETIME_FORMATS.STANDALONEMONTH[+working_date.getMonth()];
      TimelineService.fetchTimeline(dateString);
      $scope.days = TimelineService.timeline;
      $scope.timeline_button_class = function(counter) {
        if (counter === '--') {
          return 'btn-default';
        }
        if (counter === 0) {
          return 'btn-info';
        }
        if (counter > 500) {
          return 'btn-danger';
        }
        if (counter > 0) {
          return 'btn-success';
        }
      };
      $scope.prevmonth = working_date.prevMonth().yyyymm();
      if (working_date.nextMonth().isLessThenCurrentMonth()) {
        return $scope.nextmonth = working_date.nextMonth().yyyymm();
      }
    }
  ]);

}).call(this);

//# sourceMappingURL=timeline.client.controller.js.map
