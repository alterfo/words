(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);throw new Error("Cannot find module '"+o+"'")}var f=n[o]={exports:{}};t[o][0].call(f.exports,function(e){var n=t[o][1][e];return s(n?n:e)},f,f.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){
// Generated by CoffeeScript 1.10.0
(function() {
  angular.module('core').factory("TimelineService", [
    'WebApiService', 'DateService', '$locale', function(WebApiService, DateService, $locale) {
      var TimelineService;
      return new (TimelineService = (function() {
        TimelineService.prototype.workingMonth = '';

        TimelineService.prototype.timeline = [];

        TimelineService.prototype.monthLocaleString = '';

        function TimelineService() {
          this.workingMonth = DateService.getTodayMonthString();
          this.monthLocaleString = $locale.DATETIME_FORMATS.STANDALONEMONTH[+this.workingMonth.slice(5, 7) - 1] + this.workingMonth.slice(0, 4);
        }

        TimelineService.prototype.fetchTimeline = function(dateString) {
          return WebApiService.fetchTimeline(dateString, (function(_this) {
            return function(days) {
              return angular.copy(days, _this.timeline);
            };
          })(this));
        };

        TimelineService.prototype.setCounterValue = function(date, value) {
          if (date.yyyymm() === this.workingMonth) {
            return this.timeline[date.getDate() - 1] = value;
          }
        };

        TimelineService.prototype.setWorkingMonth = function(monthString) {
          return this.workingMonth = monthString;
        };

        TimelineService.prototype.nextMonthString = function() {
          return DateService.nextMonthString(new Date(this.workingMonth));
        };

        TimelineService.prototype.prevMonthString = function() {
          return DateService.prevMonthString(new Date(this.workingMonth));
        };

        TimelineService.prototype.workingMonthIsLessThenCurrentMonth = function() {
          return Date.parse(new Date(this.workingMonth)) < Date.parse(DateService.getTodayMonthString());
        };

        TimelineService.prototype.setMonthLocaleString = function() {
          return this.monthLocaleString = $locale.DATETIME_FORMATS.STANDALONEMONTH[+this.workingMonth.slice(5, 7) - 1] + this.workingMonth.slice(0, 4);
        };

        return TimelineService;

      })());
    }
  ]);

}).call(this);

},{}]},{},[1])