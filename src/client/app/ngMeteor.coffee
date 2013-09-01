define("ngMeteor", [], ->
  angular.module('ngMeteor.directives', [])

  angular.module('ngMeteor.services', [])

  angular.module('ngMeteor.templates', []).run(['$templateCache', '$rootScope', '$compile',
    ($templateCache, $rootScope, $compile) ->
      bodyTemplate = Template.body
#      if !bodyTemplate
#        throw new Error("A body template must be defined")

      # Render each template and place in Angular's template cache
      $templateCache.put key, render() for own key, render of Template

      # Render the body template and have Angular compile it, then inject it into the DOM's body element
      Meteor.startup(()->
        # Necessary?
        Spark.finalize(document.body)
        $('html').attr('data-ng-app', '')
#        $('body').html($compile(bodyTemplate())($rootScope))
        $rootScope.$apply()
      )
  ])
  angular.module('ngMeteor', ['ngMeteor.templates', 'ngMeteor.services', 'ngMeteor.directives'])
)
