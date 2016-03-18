gulp = require 'gulp'
browserSync = require('browser-sync').create()
g = require('gulp-load-plugins')()
reload = browserSync.reload
exec = require('child_process').exec

g.env.set
  NODE_ENV: "development"

config = require('./config/config');

onError = (err) ->
  console.log(err)
  this.emit('end')

runCommand = (command) ->
  (cb) ->
    exec command, (err, stdout, stderr) ->
      console.log(stdout)
      console.log(stderr)
      cb(err)

applicationJavaScriptFiles = config.assets.js
applicationCSSFiles = config.assets.css

watchFiles =
  serverViews: ['app/views/**/*.*']
  serverJS: ['gruntfile.js', 'server.js', 'config/**/*.js', 'app/**/*.js']
  clientViews: ['public/modules/**/views/**/*.html']
  clientJS: ['public/js/*.js', 'public/modules/**/*.js', '!public/modules/**/e2e/*.js']
  clientCSS: ['public/modules/**/*.css', 'public/modules/**/*.styl']
  mochaTests: ['app/tests/**/*.js']

gulp.task 'client-js', ->
  gulp.src applicationJavaScriptFiles
    .pipe g.browserify transform: ["ngify"]
    .on('error', onError)
#    .pipe g.uglify()
#    .on 'error', onError
    .pipe gulp.dest 'public/dist/'
    .pipe(browserSync.stream());

gulp.task 'client-js:prod', ->
  gulp.src applicationJavaScriptFiles
#    .pipe g.browserify transform: ["ngify"]
#    .on('error', onError)
    .pipe g.concat('application.min.js')
    .pipe g.uglify()
    .on 'error', onError
    .pipe gulp.dest 'public/dist/'

gulp.task 'client-css', ->
  gulp.src watchFiles.clientCSS
    .pipe g.stylus({compress: true})
    .pipe gulp.dest 'public/dist/css'
    .pipe(browserSync.stream());

gulp.task 'client-css:prod', ->
  gulp.src watchFiles.clientCSS
  .pipe g.stylus({compress: true})
  .pipe g.concatCss 'application.min.css'
  .pipe gulp.dest 'public/dist/'
  .pipe(browserSync.stream());

gulp.task 'client-html', ->
  gulp.src watchFiles.clientViews
  .pipe browserSync.stream();



gulp.task 'watch-js', ['client-js']
gulp.task 'watch-css', ['client-css']
gulp.task 'watch-html', ['client-html']

#gulp.task 'start-mongo', runCommand 'mongod --dbpath ./data'
#gulp.task 'stop-mongo', runCommand 'mongo --eval "use admin; db.shutdownServer();"'

gulp.task 'build', ['client-js:prod', 'client-css:prod']



gulp.task 'nodemon', ->
  g.nodemon
    script: 'server.js'
    env: 'NODE_ENV': 'development'
    watch: watchFiles.serverViews.concat(watchFiles.serverJS)

gulp.task 'browser-sync', ->
  browserSync.init
    proxy: "localhost:8000"
    notify: false


gulp.task 'serve', [ 'nodemon', 'browser-sync']

gulp.task 'default', ['serve'], ->
#  gulp.watch(watchFiles.clientViews).on("change", browserSync.stream)
  gulp.watch watchFiles.clientJS, ['watch-js']
  gulp.watch watchFiles.clientCSS, ['watch-css']
  gulp.watch watchFiles.clientViews, ['watch-html']


