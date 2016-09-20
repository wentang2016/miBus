// default settings. fis3 release

// Global start
fis.hook('amd');

fis.set('project.ignore', ['dist/**', 'fis-conf.js', 'node_modules/**'])

fis.match('*', {
	release: 'jrctpublic/$0'
})

fis.match('(index.html)', {
	release: '/$1',
})

fis.match('(*.sh)', {
	release: '/$1',
})

fis.match('views/(**)', {
	release: 'jrctviews/$1'
})

fis.match('(*{_aio*.js,_map*.js,_aio*.css})', {
	release: 'jrctpublic/aio/$1'
})

fis.match('::package', {
	postpackager: fis.plugin('loader', {
		allInOne: false
	})
})

fis.media('pro').match('::package', {
	postpackager: fis.plugin('loader', {
		allInOne: true
	})
})

fis.match('/component/**.js', {
	isMod: true
})

fis.media('pro').match('*.{js,css}', {
	useHash: false
});

fis.media('pro').match('::image', {
	useHash: false
});

fis.media('pro').match('*.js', {
	optimizer: fis.plugin('uglify-js')
});

fis.match('*.min.js', {
	optimizer: null
})

fis.media('pro').match('*.css', {
	optimizer: fis.plugin('clean-css')
});

fis.match('*.min.css', {
	optimizer: null
})

fis.media('pro').match('*', {
	deploy: fis.plugin('local-deliver', {
		to: '/Users/baixiong/Documents/gitHub/wechat.msekko.com/resources/views/temp'
	})
})

//fis.media('pro').match('*.png', {
//optimizer: fis.plugin('png-compressor')
//});