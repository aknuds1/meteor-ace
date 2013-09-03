module.exports = (grunt) ->
    #rootUrl = 'http://$APP_HOST'
    shell = require('shelljs')
    grunt.initConfig({})

    grunt.registerTask('install', 'Install dependencies', ->
      shell.exec('npm install && bower install && cd src && mrt install')
    )

    grunt.registerTask('meteor', 'Run development server', ->
        grunt.task.requires('install')
        shell.exec('cd src && meteor')
    )

    grunt.registerTask('deploy', 'Deploy to meteor.com', ->
        grunt.task.requires('install')
        shell.exec('cd src && meteor deploy meteor-ace.meteor.com')
    )

    grunt.registerTask('default', ['install', 'meteor'])
