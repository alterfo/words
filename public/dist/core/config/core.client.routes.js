(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);throw new Error("Cannot find module '"+o+"'")}var f=n[o]={exports:{}};t[o][0].call(f.exports,function(e){var n=t[o][1][e];return s(n?n:e)},f,f.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){
// Generated by CoffeeScript 1.9.3
(function() {
  'use strict';
  angular.module('core').config([
    '$stateProvider', '$urlRouterProvider', function($stateProvider, $urlRouterProvider) {
      $urlRouterProvider.otherwise('/today');
      return $stateProvider.state('today', {
        url: '/today',
        templateUrl: 'modules/core/views/home.client.view.html'
      }).state('history', {
        url: '/history/:date',
        templateUrl: 'modules/core/views/home.client.view.html'
      }).state('about', {
        url: '/about',
        templateUrl: 'modules/core/views/about.client.view.html'
      });
    }
  ]);

}).call(this);

//# sourceMappingURL=core.client.routes.js.map

},{}]},{},[1])