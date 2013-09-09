require(["angular", "underscore", "ace.directives", "ace.services"], (angular, _) ->
  app = angular.module('meteorapp', ['meteor', 'app.directives', 'ace.directives', 'ace.services'], ->
  )

  app.controller("MeteorCtrl", ["$scope", "aceManager", ($scope, aceManager) ->
    class ToolButton
      constructor: (@name, enabled, icon) ->
        @icon = icon || @name
        @enabled = $scope[enabled]
        $scope.$watch(enabled, ->
          value =  $scope[enabled]
          console.log("Changed: #{enabled}: #{value}")
          @enabled = value
        )

    $scope.document = ""
    $scope.dirty = false
    $scope.canUndo = false
    $scope.canRedo = false
    $scope.toolbuttons = [
      new ToolButton("save", "dirty", "disk"),
      new ToolButton("undo", "canUndo"),
      new ToolButton("redo", "canRedo"),
    ]

    checkUndoState = ->
      $scope.canUndo = aceManager.canUndo()
      $scope.canRedo = aceManager.canRedo()

    $scope.toolbuttonClicked = (name) =>
      name = name.toLowerCase()
      if name == 'save'
        if !$scope.dirty
          return
        $scope.dirty = false
      else if name == 'undo'
        if !$scope.canUndo
          return
        aceManager.undo()
      else if name == 'redo'
        if !$scope.canRedo
          return
        aceManager.redo()

      checkUndoState()
      console.log('toolbutton clicked:', name)

    $scope.$on('aceChanged', ->
      checkUndoState()
    )
  ])
)