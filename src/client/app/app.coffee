require(["angular", "underscore"], (angular, _) ->
  homeUrl = "/"

  app = angular.module('meteorapp', ['meteor', 'ui.ace'],
    ['$routeProvider', '$locationProvider', ($routeProvider, $locationProvider) ->
      $routeProvider.when(homeUrl, templateUrl: 'partials/home.html', controller: "MeteorCtrl")
      $routeProvider.otherwise(redirectTo: homeUrl)
      $locationProvider.html5Mode(true)
    ])

  class MenuItem
    constructor: (@name, @address) ->
      @isSelected = false

  app.controller("MeteorCtrl", ["$scope", ($scope) ->
    $scope.menuItems = [
      new MenuItem("Home", homeUrl),
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