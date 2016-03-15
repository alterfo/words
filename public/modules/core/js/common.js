// Generated by CoffeeScript 1.10.0
(function() {
  'use strict';
  Date.prototype.yyyymm = function() {
    var mm, yyyy;
    yyyy = this.getFullYear().toString();
    mm = (this.getMonth() + 1).toString();
    return yyyy + '-' + (mm.length === 2 ? mm : "0" + mm);
  };

  Date.prototype.yyyymmdd = function() {
    var dd, mm, yyyy;
    yyyy = this.getFullYear().toString();
    mm = (this.getMonth() + 1).toString();
    dd = this.getDate().toString();
    return yyyy + '-' + (mm.length === 2 ? mm : "0" + mm) + '-' + (dd.length === 2 ? dd : "0" + dd);
  };

  Date.prototype.nextMonth = function() {
    return new Date(this.setMonth(this.getMonth() + 1));
  };

  Date.prototype.prevMonth = function() {
    return new Date(this.setMonth(this.getMonth() - 1));
  };

  String.prototype.yyyymmToDate = function() {
    return new Date(this.slice(0, 4), +this.slice(5, 7) - 1);
  };

  Date.prototype.isCurrentMonth = function() {
    var dm, dy, tm, today, ty, working_date;
    working_date = this;
    today = new Date();
    ty = today.getFullYear();
    dy = working_date.getFullYear();
    tm = today.getMonth();
    dm = working_date.getMonth();
    return tm === dm && ty === dy;
  };

  Date.prototype.daysInMonth = function() {
    return new Date(this.getFullYear(), this.getMonth() + 1, 0).getDate();
  };

  Date.prototype.isLessThenCurrentMonth = function() {
    var today;
    today = new Date();
    today.setMonth(today.getMonth() - 1);
    return Date.parse(today) > Date.parse(this);
  };

}).call(this);
