define('ace.directives', ['angular'], (angular) ->
  angular.module('ace.directives', ["ace.services"])
    .directive('ace', ['aceManager', (aceManager)  ->
      if !window.ace?
        throw new Error("ace isn't included")

      return {
        restrict: 'A',
        require: '?ngModel',
        scope: {
          dirty: '='
        },
        # post-link callback
        link: (scope, elm, attrs, ngModel) ->
          aceManager.setElement(elm)

          # Value-binding
          if ngModel?
            ngModel.$formatters.push((value)->
              if !value?
                return ''
              if angular.isObject(value) || angular.isArray(value)
                throw new Error('Ace directive cannot use an object or an array as a model')
              return value
            )

            ngModel.$render = ->
              console.log('Model changed, resetting editor content')
              aceManager.setValue(ngModel.$viewValue)

          scope.$on('aceChanged', (e, newValue) ->
            console.log('aceChanged received')
            if newValue == scope.$eval(attrs.value) || scope.$$phase
              console.log("Editor content unchanged")
              return

            console.log('Editor content changed')
            scope.$apply(->
              scope.dirty = true
            )
            if !ngModel?
              return

            scope.$apply(->
              console.log('Setting model data')
              ngModel.$setViewValue(newValue)
            )
          )
      }
    ])
)