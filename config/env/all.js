'use strict';

module.exports = {
	app: {
		title: '500 слов',
		description: 'Сервис шифрованных личных записей',
		keywords: 'слова, дневник, личные записи, шифрованный'
	},
	port: process.env.PORT || 8000,
	templateEngine: 'swig',
	sessionSecret: 'MEAN',
	sessionCollection: 'sessions',
	assets: {
		lib: {
			css: [
				'public/lib/bootstrap/dist/css/bootstrap.css',
				'public/lib/bootstrap/dist/css/bootstrap-theme.css'
			],
			js: [
				'public/modules/core/js/common.js',
				'public/lib/angular/angular.js',
                'public/lib/angular-i18n/angular-locale_ru-ru.js',
				//'public/lib/angular-resource/angular-resource.js',
				//'public/lib/angular-cookies/angular-cookies.js',
				//'public/lib/angular-animate/angular-animate.js',
				//'public/lib/angular-sanitize/angular-sanitize.js',
				'public/lib/angular-ui-router/release/angular-ui-router.js',
				//'public/lib/angular-ui-utils/ui-utils.js',
				//'public/lib/angular-bootstrap/ui-bootstrap-tpls.js',
				'public/lib/angular-elastic/elastic.js'
			]
		},
		css: [
			'public/modules/**/css/*.css'
		],
		js: [
			'public/config.js',
			'public/application.js',
			'public/modules/*/*.js',
			'public/modules/*/*[!tests|!e2e]*/*.js'
		],
		tests: [
			'public/lib/angular-mocks/angular-mocks.js',
			'public/modules/*/tests/*.js'
		]
	}
};
