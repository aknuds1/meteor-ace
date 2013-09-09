define('ace.services', ['angular'], (angular) ->
  angular.module('ace.services', [])
    .factory('aceManager', ['$rootScope', ($rootScope) ->
      console.log('Creating aceManager service')
      return new AceManager($rootScope)
    ])

  class AceManager
    constructor: (@rootScope) ->
      if !@rootScope?
        throw new Error('rootScope is undefined')

    setElement: (elm) =>
      @_aceObj = window.ace.edit(elm[0])
      @_session = @_aceObj.getSession()
      @_session.setMode("ace/mode/javascript")
      @_undoManager = @_session.getUndoManager()
      console.log('Set Ace element successfully')

      # Events
      @_session.on('change', =>
        newValue = @_session.getValue()
        console.log("broadcasting via #{@rootScope}")
        @rootScope.$broadcast("aceChanged", newValue)
      )

    setValue: (value) =>
      @_session.setValue(value)

    undo: =>
      @_undoManager.undo()

    canUndo: =>
      return @_undoManager.hasUndo()

    redo: =>
      @_undoManager.redo()

    canRedo: =>
      return @_undoManager.hasRedo()
)