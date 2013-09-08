require(["angular", "underscore"], (angular, _) ->
  angular.module('app.directives', [])
    .directive('toolbar', ->
      return {
        # Elements only
        restrict: 'E',
        # If replacing the parent element, ng-repeat itself gets repeated :(
#        replace: true,
        # Accept a toolbuttons variable in own scope
        scope: {
          toolbuttons: '='
        },
        template: """<div class="toolbar">
  <a data-ng-repeat='btn in toolbuttons' data-ng-class="{disabled: btn.disabled, enabled: !btn.disabled}" href="#" class="toolbar-btn">
    <span class="icon-{{btn.icon}}"></span>
  </a>
</div>
"""
      }
    )
)