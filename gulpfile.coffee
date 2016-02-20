gulp = require 'gulp'
browserSync = require('browser-sync').create()
g = require('gulp-load-plugins')()

g.env.set
  NODE_ENV: "development"

config = require('./config/config');

onError = (err) ->
  console.log(err)
  this.emit('end')



applicationJavaScriptFiles = config.assets.js
applicationCSSFiles = config.assets.css

watchFiles =
  serverViews: ['app/views/**/*.*']
  serverJS: ['gruntfile.js', 'server.js', 'config/**/*.js', 'app/**/*.js']
  clientViews: ['public/modules/**/views/**/*.html']
  clientJS: ['public/js/*.js', 'public/modules/**/*.js']
  clientCSS: ['public/modules/**/*.css', 'public/modules/**/*.styl']
  mochaTests: ['app/tests/**/*.js']

gulp.task 'client-js', ->
  gulp.src applicationJavaScriptFiles
    .pipe g.browserify transform: ["ngify"]
    .on('error', onError)
    .pipe g.uglify()
    .on 'error', onError
    .pipe gulp.dest 'public/dist/'

gulp.task 'client-css', ->
  gulp.src clientCSS
    .pipe g.stylus({compress: true})
    .pipe gulp.dest 'public/dist/css'


gulp.task 'watch-js', ['client-js'], browserSync.reload
gulp.task 'watch-html', browserSync.reload
gulp.task 'watch-css', ['client-css'], browserSync.reload

gulp.task 'nodemon', ->
  g.nodemon
    script: 'server.js'
    env: 'NODE_ENV': 'development'
    watch: watchFiles.serverViews.concat(watchFiles.serverJS)

gulp.task 'browser-sync', ->
  browserSync.init
    proxy: "localhost:8000"


gulp.task 'serve', ['nodemon', 'browser-sync']

gulp.task 'default', ['serve'], ->
  gulp.watch watchFiles.clientViews, ['watch-html']
  gulp.watch watchFiles.clientJS, ['watch-js']
  gulp.watch watchFiles.clientCSS, ['watch-css']

