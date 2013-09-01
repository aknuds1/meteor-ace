require(["angular", "ngMeteor", "underscore"], (angular, ngMeteor, _) ->
  angular.element(document).ready(->
    angular.bootstrap(document, ['app'])
  )

  homeUrl = "/"

  app = angular.module('app', ['ngMeteor', 'ui.ace'],
    ['$routeProvider', '$locationProvider', ($routeProvider, $locationProvider) ->
      $routeProvider.when(homeUrl, templateUrl: 'home', controller: "HomeCtrl")
      $routeProvider.otherwise(redirectTo: homeUrl)
      $locationProvider.html5Mode(true)
    ])

  class MenuItem
    constructor: (@name, @address) ->
      @isSelected = false

  app.controller("AppCtrl", ["$scope", ($scope) ->
    $scope.menuItems = [
      new MenuItem("Home", homeUrl),
    ]
  ])

  app.controller("HomeCtrl", ["$scope", ($scope) ->
    markSelected($scope, homeUrl)
  ])

  markSelected = ($scope, url) ->
    _($scope.menuItems).each((item) =>
      item.isSelected = item.address == url
    )
)