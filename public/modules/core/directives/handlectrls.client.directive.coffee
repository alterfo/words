angular
  .module('core')
  .directive 'handleCtrlS', [ '$document', ($document) ->
    S_KEY = 83
    F4 = 115

    restrict: 'A'
    scope:
      handleCtrls: '@'
    link: (s,e,a) ->
      ctrlsHandler = (e) ->
        if event.keyCode is S_KEY and event.ctrlKey or event.keyCode is F4 and event.metaKey
          s.handleCtrls()
          e.preventDefault()

      $document.on 'keydown', ctrlsHandler

      s.$on '$destroy', ->
        $document.off 'keydown', ctrlsHandler

]
