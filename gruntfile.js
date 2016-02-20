'use strict';

module.exports = function(grunt) {
	var watchFiles = {
		serverViews: ['app/views/**/*.*'],
		serverJS: ['gruntfile.js', 'server.js', 'config/**/*.js', 'app/**/*.js'],
		clientViews: ['public/modules/**/views/**/*.html'],
		clientJS: ['public/js/*.js', 'public/modules/**/*.js'],
		clientCSS: ['public/modules/**/*.css'],
		mochaTests: ['app/tests/**/*.js']
	};

	// Project Configuration
	grunt.initConfig({
		pkg: grunt.file.readJSON('package.json'),
		watch: {
			serverViews: {
				files: watchFiles.serverViews,
				options: {
					livereload: true
				}
			},
			serverJS: {
				files: watchFiles.serverJS,
				options: {
					livereload: true
				}
			},
			clientViews: {
				files: watchFiles.clientViews
			},
			clientJS: {
				files: watchFiles.clientJS,
                tasks: ['browserify', 'uglify']
			},
			clientCSS: {
				files: watchFiles.clientCSS,
				tasks: ['csslint']
			}
		},
		csslint: {
			options: {
				csslintrc: '.csslintrc'
			},
			all: {
				src: watchFiles.clientCSS
			}
		},
		cssmin: {
			combine: {
				files: {
					'public/dist/application.min.css': '<%= applicationCSSFiles %>'
				}
			}
		},
		nodemon: {
			dev: {
				script: 'server.js',
				watch: watchFiles.serverViews.concat(watchFiles.serverJS)
			}
		},
        browserify: {
            'public/dist/application.js': '<%= applicationJavaScriptFiles %>',
            options: {
                transform: ["ngify"]
            }
        },
        uglify: {
            all: {
                files: {
                    'public/dist/application.min.js': ['public/dist/application.js']
                }
            }
        },
        concurrent: {
            dev: {
                tasks: ['nodemon','browserSync'],
                options: {
                    logConcurrentOutput: true
                }
            }
        },
        browserSync: {
            dev: {
                bsFiles: {
                    src : [ watchFiles.clientViews, watchFiles.clientJS, watchFiles.clientCSS ]
                },
                options: {
                    logLevel: "info",
                    logConnections: true,
                    proxy: 'http://localhost:8000'
                }
            }
        },
		env: {
			test: {
				NODE_ENV: 'test'
			},
			secure: {
				NODE_ENV: 'secure'
			}
		},
		mochaTest: {
			src: watchFiles.mochaTests,
			options: {
				reporter: 'spec',
				require: 'server.js'
			}
		},
		karma: {
            unit: {
                configFile: 'karma.conf.js'
            }
        },
        protractor: {
            options: {
                configFile: "protractor-conf.js",
                keepAlive: true,
                noColor: false,
                args: {

                }
            },
            all: { }
        }
	});

	// Load NPM tasks
	require('load-grunt-tasks')(grunt, { pattern: ['grunt-*', '@*/grunt-*']});

	// Making grunt default to force in order not to break the project.
	grunt.option('force', true);

	// A Task for loading the configuration object
	grunt.task.registerTask('loadConfig', 'Task that loads the config into a grunt option.', function() {
		var init = require('./config/init')();
		var config = require('./config/config');

		grunt.config.set('applicationJavaScriptFiles', config.assets.js);
		grunt.config.set('applicationCSSFiles', config.assets.css);
	});

	// Default task(s).
	grunt.registerTask('default', [ 'concurrent' ]);

	// Secure task(s).
	grunt.registerTask('secure', ['env:secure', 'lint', 'concurrent:default']);

	// Build task(s).
	grunt.registerTask('build', ['loadConfig', 'browserify', 'uglify', 'cssmin']);

	// Test task.
	grunt.registerTask('test', ['env:test', 'mochaTest', 'karma:unit', 'protractor:all']);
};
