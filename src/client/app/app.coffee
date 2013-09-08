require(["angular", "underscore"], (angular, _) ->
  homeUrl = "/"

  app = angular.module('meteorapp', ['meteor', 'ui.ace', 'app.directives'],
    ['$routeProvider', '$locationProvider', ($routeProvider, $locationProvider) ->
      $routeProvider.when(homeUrl, templateUrl: 'partials/home.html', controller: "MeteorCtrl")
      $routeProvider.otherwise(redirectTo: homeUrl)
      $locationProvider.html5Mode(true)
    ])

  class ToolButton
    constructor: (@name, icon, enabled) ->
      @icon = icon || @name
      @disabled = !enabled

  app.controller("MeteorCtrl", ["$scope", ($scope) ->
    $scope.toolbuttons = [
      new ToolButton("save", "disk"),
      new ToolButton("undo"),
      new ToolButton("redo"),
    ]
  ])

  app.controller("HomeCtrl", ["$scope", ($scope) ->
    # TODO: Make into directive
    editor = new ReactiveAce()
    editorId = '#editor'
    elem = $(editorId)[0]
    if !elem?
      throw new Error('#{editorId} not found')
    editor.attach(elem)
  ])
)