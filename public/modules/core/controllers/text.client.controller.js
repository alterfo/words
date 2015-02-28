// Generated by CoffeeScript 1.9.0
'use strict';
angular.module('core').controller('TextController', [
  '$scope', '$http', '$stateParams', '$location', 'Authentication', '$document', "AlertService", function($scope, $http, $stateParams, $location, Authentication, $document, AlertService) {
    var DEBUG, cd, cm, cy, daysInMonth;
    DEBUG = 1;
    $scope.current_date = new Date();
    cm = $scope.current_date.getMonth();
    cy = $scope.current_date.getFullYear();
    cd = $scope.current_date.getDate();
    $scope.date_to_show = new Date($scope.current_date);
    $scope.month_to_show = $scope.date_to_show.getFullYear() + '' + $scope.date_to_show.getMonth();
    $scope.curMonth = $scope.date_to_show.yyyymm();
    $scope.curDate = $scope.date_to_show.yyyymmdd();
    $scope.authentication = Authentication;
    $scope.historyText = '';
    $scope.text = '';
    $scope.changed = false;
    $scope.state = 'saved';
    daysInMonth = function(month, year) {
      return new Date(year, month + 1, 0).getDate();
    };
    $scope.nextMonth = function() {
      $scope.curMonth = $scope.date_to_show.nextMonth().yyyymm();
    };
    $scope.prevMonth = function() {
      $scope.curMonth = $scope.date_to_show.prevMonth().yyyymm();
    };
    $scope.getWordCounter = function() {
      if ($scope.text) {
        return $scope.text.trim().split(/\s+/).length;
      }
    };
    $document.bind("keydown", function(event) {
      if ((event.which === 115 || event.which === 83) && (event.ctrlKey || event.metaKey)) {
        $scope.save('ctrls');
        event.stopPropagation();
        event.preventDefault();
        return false;
      }
      return true;
    });
    $scope.save = function(e) {
      if ($scope.changed) {
        $scope.state = 'saving';
        $http({
          method: 'POST',
          url: '/texts',
          data: {
            text: $scope.text,
            date: $scope.current_date,
            counter: $scope.getWordCounter()
          }
        }).success(function(data, status, headers) {
          if (data.message) {
            AlertService.send("danger", data.message, 3000);
            return;
          }
          if (e === 'ctrls') {
            AlertService.send("success", "Продолжайте!", "Сохранение прошло успешно!", 2000);
          }
          $scope.state = 'saved';
          $scope.changed = false;
        }).error(function(data, status, headers) {
          if (e === 'ctrls') {
            AlertService.send("danger", "Упс!", "Сервер не доступен, продолжайте и попробуйте сохраниться через 5 минут!", 4000);
          }
        })["finally"](function(data, status, headers) {});
      } else {
        if (e === 'ctrls') {
          AlertService.send("success", "Продолжайте!", "Ничего не изменилось с прошлого сохранения!", 2000);
        }
      }
    };
    $scope.showText = function(date) {
      if ($scope.current_date.setHours(0, 0, 0, 0) > (new Date($scope.curMonth + '-' + date)).setHours(0, 0, 0, 0)) {
        date = date + '';
        date = date.length === 2 ? date : '0' + date;
        $scope.hideToday = true;
        $scope.curDate = new Date($scope.curMonth + '-' + date);
        $http.get('/text/' + $scope.curMonth + '-' + date).success(function(data, status, headers) {
          $scope.historyText = data.text;
        });
      } else if ($scope.current_date.setHours(0, 0, 0, 0) === (new Date($scope.curMonth + '-' + date)).setHours(0, 0, 0, 0)) {
        $scope.hideToday = false;
        $scope.historyText = '';
        $scope.curDate = $scope.current_date;
      } else {
        AlertService.send("info", "Машину времени пока изобретаем", "Давайте жить сегодняшним днем!", 3000);
        return;
      }
    };
    if ($scope.authentication.user) {
      AlertService.send("info", "С возвращением, " + $scope.authentication.user.displayName, "Давайте писать!", 3000);
    }
    $scope.$watch("text", function(newVal, oldVal) {
      $scope.changed = newVal !== oldVal && oldVal !== '';
      if ($scope.changed) {
        $scope.state = 'notsaved';
        $scope.days[cd - 1] = $scope.getWordCounter();
      }
    });
    $scope.$watch('curMonth', function() {
      var request_string, sd, sm, sy;
      sm = $scope.date_to_show.getMonth();
      sy = $scope.date_to_show.getFullYear();
      sd = $scope.date_to_show.getDate();
      request_string = sy + "-" + ("0" + (sm + 1)).slice(-2);
      $scope.isCurrentMonth = sm === cm && sy === cy;
      $http.get('/texts/' + request_string).success(function(data, status, headers) {
        var daysN, limit, _ref;
        daysN = daysInMonth(sm, sy);
        $scope.days = Array.apply(null, new Array(daysN)).map(Number.prototype.valueOf, 0);
        if ($scope.isCurrentMonth) {
          limit = cd;
        }
        data.forEach(function(e, i) {
          $scope.days[(new Date(e.date)).getDate() - 1] = e.counter;
        });
        if (limit) {
          [].splice.apply($scope.days, [limit, daysN - limit + 1].concat(_ref = Array.apply(null, new Array(daysN - limit)).map(String.prototype.valueOf, "--"))), _ref;
        }
      });
    });
    $http({
      method: 'GET',
      url: '/today'
    }).success(function(data, status, headers) {
      $scope.text = data.text;
      $scope.state = 'saved';
      setInterval($scope.save, 10000);
    }).error(function(data, status, headers) {});
  }
]);
