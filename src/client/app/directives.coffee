angular.module('app.directives', [])
  .directive('toolbar', ->
    return {
      # Elements only
      restrict: 'E',
      # If replacing the parent element, ng-repeat itself gets repeated :(
      #        replace: true
    template: """<div class="toolbar">
  <a href="#" class="toolbar-btn" ng-repeat='btn in toolbuttons' ng-class="{enabled: dirty}" ng-click="toolbuttonClicked(btn.name)">
    <span class="icon-{{btn.icon}}"></span>
  </a>
</div>
"""
#      template: """<div class="toolbar">
#  <a href="#" class="toolbar-btn" ng-repeat='btn in toolbuttons' ng-disabled="!{{btn.enabled}}"
#    ng-class="{enabled: {{btn.enabled}}, disabled: !{{btn.enabled}}}" ng-click="toolbuttonClicked(btn.name)">
#    <span class="icon-{{btn.icon}}"></span>
#  </a>
#</div>
#"""
    }
  )