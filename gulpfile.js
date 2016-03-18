// Generated by CoffeeScript 1.10.0
(function() {
  var applicationCSSFiles, applicationJavaScriptFiles, browserSync, config, exec, g, gulp, onError, reload, runCommand, vendorJavaScriptFiles, watchFiles;

  gulp = require('gulp');

  browserSync = require('browser-sync').create();

  g = require('gulp-load-plugins')();

  reload = browserSync.reload;

  exec = require('child_process').exec;

  g.env.set({
    NODE_ENV: "development"
  });

  config = require('./config/config');

  onError = function(err) {
    console.log(err);
    return this.emit('end');
  };

  runCommand = function(command) {
    return function(cb) {
      return exec(command, function(err, stdout, stderr) {
        console.log(stdout);
        console.log(stderr);
        return cb(err);
      });
    };
  };

  applicationJavaScriptFiles = config.assets.js;

  vendorJavaScriptFiles = config.assets.lib.js;

  applicationCSSFiles = config.assets.css;

  watchFiles = {
    serverViews: ['app/views/**/*.*'],
    serverJS: ['gruntfile.js', 'server.js', 'config/**/*.js', 'app/**/*.js'],
    clientViews: ['public/modules/**/views/**/*.html'],
    clientJS: ['public/js/*.js', 'public/modules/**/*.js', '!public/modules/**/e2e/*.js'],
    clientCSS: ['public/modules/**/*.css', 'public/modules/**/*.styl'],
    mochaTests: ['app/tests/**/*.js']
  };

  gulp.task('client-js', function() {
    return gulp.src(applicationJavaScriptFiles).pipe(g.browserify({
      transform: ["ngify"]
    })).on('error', onError).pipe(gulp.dest('public/dist/')).pipe(browserSync.stream());
  });

  gulp.task('vendor-js:prod', function() {
    return gulp.src(vendorJavaScriptFiles).pipe(g.concat('vendor.min.js')).pipe(g.uglify()).on('error', onError).pipe(gulp.dest('public/dist/'));
  });

  gulp.task('client-js:prod', function() {
    return gulp.src(applicationJavaScriptFiles).pipe(g.concat('application.min.js')).pipe(g.uglify()).on('error', onError).pipe(gulp.dest('public/dist/'));
  });

  gulp.task('client-css', function() {
    return gulp.src(watchFiles.clientCSS).pipe(g.stylus({
      compress: true
    })).pipe(gulp.dest('public/dist/css')).pipe(browserSync.stream());
  });

  gulp.task('client-css:prod', function() {
    return gulp.src(watchFiles.clientCSS).pipe(g.stylus({
      compress: true
    })).pipe(g.concatCss('application.min.css')).pipe(gulp.dest('public/dist/')).pipe(browserSync.stream());
  });

  gulp.task('client-html', function() {
    return gulp.src(watchFiles.clientViews).pipe(browserSync.stream());
  });

  gulp.task('watch-js', ['client-js']);

  gulp.task('watch-css', ['client-css']);

  gulp.task('watch-html', ['client-html']);

  gulp.task('build', ['client-js:prod', 'client-css:prod']);

  gulp.task('nodemon', function() {
    return g.nodemon({
      script: 'server.js',
      env: {
        'NODE_ENV': 'development'
      },
      watch: watchFiles.serverViews.concat(watchFiles.serverJS)
    });
  });

  gulp.task('browser-sync', function() {
    return browserSync.init({
      proxy: "localhost:8000",
      notify: false
    });
  });

  gulp.task('serve', ['nodemon', 'browser-sync']);

  gulp.task('default', ['serve'], function() {
    gulp.watch(watchFiles.clientJS, ['watch-js']);
    gulp.watch(watchFiles.clientCSS, ['watch-css']);
    return gulp.watch(watchFiles.clientViews, ['watch-html']);
  });

}).call(this);

//# sourceMappingURL=gulpfile.js.map
