angular
  .module('core')
  .factory "TextService", ['$http',  ($http) ->
    self = this
    textObject = {}

    getText: (date) ->
      if date is undefined
        $http
          method: 'GET'
          url: '/today'
        .success (data) ->
          textObject = data
      else if typeof date is 'string'
        #todo: get text by date

    getTextDate: () ->
      textObject.date


    getCurrentText: () ->
      textObject

    saveText: (textString) ->
      #todo: create stateService
      $http(
        method: 'POST'
        url: '/texts'
        data:
          text: textString
          date: Date.now()
          counter: textObject.trim().split(/\s+/).length
      )




]
