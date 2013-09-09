angular.module('app.directives', [])
  .directive('toolbar', ->
    return {
      # Elements only
      restrict: 'E',
      # If replacing the parent element, ng-repeat itself gets repeated :(
      #        replace: true
      scope: {toolbuttons: "="},
      template: """<div class="toolbar">
  <a href="#" class="toolbar-btn" ng-repeat='btn in toolbuttons' ng-class="{enabled: btn.enabled,disabled: !btn.enabled}"
    ng-disabled="!btn.enabled" ng-click="toolbuttonClicked(btn.name)">
    <span class="icon-{{btn.icon}}"></span>
  </a>
</div>
"""
    }
  )
  .directive("toolbutton", ->
    return {
      restrict: "E",
      scope: {
        name: "@",
        icon: "@",
        enabled: "=",
        clicked: "&"
      },
      template: """<a href="#" class="toolbar-btn" ng-class="{enabled: enabled, disabled: !enabled}"
    ng-disabled="!enabled" ng-click="clicked({name: name})">
  <span class="icon-{{icon}}"></span>
</a>
"""
    }
  )
