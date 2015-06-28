module.exports = ->
  # Project configuration
  @initConfig
    pkg: @file.readJSON 'package.json'

    connect:
      dev:
        options:
          hostname: '*'
          port: 4000
          base: '_site'

    sass:
      generate:
        options:
          sourcemap: true
          style: 'compressed'
        files:
          'css/main.css': 'css/main.scss'

    copy:
      css:
        files: [
          expand: true
          cwd: 'css/'
          src: ['main.*'],
          dest: 'build/css/'
        ]

    imagemin:
     dist:
       options:
         optimizationLevel: 7
       files: [
           expand: true # only compressing jpg right now
           cwd: 'img/'
           src: ['**/*.jpg']
           dest: 'img/',
           ext: '.jpg'
       ]

    jekyll:
      dev:
        options: {}

    # docco:
    #   noflo:
    #     src: ['_src/src/lib/*.coffee']
    #     options:
    #       output: 'api/'
    #       template: '_docco/docco.jst'

    shell:
      gitclone:
        command: 'git clone git://github.com/php-vcr/php-vcr.git _src'

    watch:
      # php-vcr-api-docs:
        # files: [
        #   '_docco/*.jst'
        # ]
        # tasks: ['docco']
      jekyll:
        files: [
          '_config.yml'
          'index.html'
          '**/*.html'
          '**/*.md'
          '**/*.js'
          '**/*.css'
          '**/_posts/*.md'
          # Ignore the generated files
          '!_site/*'
          '!_src/*'
          '!_site/**/*'
          '!_src/**/*'
          '!node_modules/**'
          '!.git/**'
        ]
        tasks: ['jekyll']
      sass:
        files: [
          'css/*.scss'
        ]
        tasks: ['sass', 'copy']

      # siteSass:
      #   files: [
      #     'build/css/*.scss'
      #   ]
      #   tasks: ['sass:site', 'copy:site2src']

  @loadNpmTasks 'grunt-jekyll'
  @loadNpmTasks 'grunt-shell'
  @loadNpmTasks 'grunt-contrib-connect'
  @loadNpmTasks 'grunt-contrib-watch'
  @loadNpmTasks 'grunt-contrib-sass'
  @loadNpmTasks 'grunt-contrib-copy'
  #@loadNpmTasks 'grunt-contrib-imagemin'

  #@registerTask 'img', [
  #  'copy:img'
  #  'imagemin:dist'
  #]
  @registerTask 'dev', [
    'connect:dev'
    'build'
    'watch'
  ]
  @registerTask 'build', [
    'sass'
    'copy'
    'jekyll'
  ]
  @registerTask 'default', ['dev']