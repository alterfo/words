!function e(t,n,r){function o(s,u){if(!n[s]){if(!t[s]){var i="function"==typeof require&&require;if(!u&&i)return i(s,!0);if(a)return a(s,!0);throw new Error("Cannot find module '"+s+"'")}var c=n[s]={exports:{}};t[s][0].call(c.exports,function(e){var n=t[s][1][e];return o(n?n:e)},c,c.exports,e,t,n,r)}return n[s].exports}for(var a="function"==typeof require&&require,s=0;s<r.length;s++)o(r[s]);return o}({1:[function(e,t,n){(function(){"use strict";angular.module("core").controller("TextController",["$scope","$http","$stateParams","$location","Authentication","$document","AlertService","WebApiService","TimelineService","DateService",function(e,t,n,r,o,a,s,u,i,c){e.authentication=o,e.text="",e.getWordCounter=function(){return e.text?e.text.trim().split(/\s+/).length:void 0},e.changed=!1,e.insertText=function(t){return t===c.getTodayString()?u.getToday().then(function(t){e.text=t.data.text,e.state="saved",setInterval(e.save,1e4)},function(e){}):void 0},e.$watch("text",function(t,n){e.changed=t!==n,e.changed&&(e.state="notsaved",i.setCounterValue(c.getToday(),e.getWordCounter()))}),e.historyText="",e.state="saved",e.saveByKeys=function(t){return t.preventDefault(),t.stopPropagation(),e.changed?(e.state="saving",u.postText(e.text).then(function(t){return t.data.message?void s.send("danger",t.data.message,3e3):(s.send("success","Продолжайте!","Сохранение прошло успешно!",2e3),e.state="saved",e.changed=!1)},function(e){return s.send("danger","Упс!","Сервер не доступен, продолжайте и попробуйте сохраниться через 5 минут!",4e3)})):s.send("success","Продолжайте!","Ничего не изменилось с прошлого сохранения!",2e3),!1},e.save=function(){return e.changed?(e.state="saving",u.postText(e.text).then(function(t){return t.data.message?void s.send("danger",t.message,3e3):(e.state="saved",e.changed=!1)})):void 0},e.showText=function(n){if(e.current_date.setHours(0,0,0,0)>new Date(e.curMonth+"-"+n).setHours(0,0,0,0))n+="",n=2===n.length?n:"0"+n,e.hideToday=!0,e.curDate=new Date(e.curMonth+"-"+n),t.get("/text/"+e.curMonth+"-"+n).success(function(t,n,r){e.historyText=t.text});else{if(e.current_date.setHours(0,0,0,0)!==new Date(e.curMonth+"-"+n).setHours(0,0,0,0))return void s.send("info","Машину времени пока изобретаем","Давайте жить сегодняшним днем!",3e3);e.hideToday=!1,e.historyText="",e.curDate=e.current_date}}}])}).call(this)},{}]},{},[1]);