/*custom js*/ ;
(function() {

	if(!r) return;

	Vue.config.delimiters = ['[[', ']]']

	if(location.toJsonMap == null) {
		location.toJsonMap = function() {
			var searchString = this.search.substr(1)
			var allArr = searchString.split('&')

			var map = {}

			for(var k = 0; k < allArr.length; k++) {
				var arr = allArr[k].split('=')

				//				for(var i = 0; i < arr.length; i = i + 2) {
				var key = arr[0]
				var val = arr[1]
				map[key] = val
					//				}

			}

			return map
		}
	}
	var path = location.origin + '/jrctviews'
	var devHashChangeMap = {
		'#index': path + '/index.html',
		'#newVip': path + '/newVip.html',
		'#fnDetail': path + '/fnDetail.html',
		'#home_fn': path + '/home_fn.html',
		'#home': path + '/home.html',
		'#orderManage': path + '/orderManage.html',
		'#rcRecord': path + '/rcRecord.html',
		'#setAccount': path + '/setAccount.html',
		'#recruitPage': path + '/recruitPage.html',
		'#recruitNew': path + '/recruitNew.html'
	}

	var hashChangeMap = {
		'#index': '/member/index.html',
		'#newVip': '/member/create.html',
		'#fnDetail': '/member/fnDetail.html',
		'#home_fn': '/member/home_fn.html',
		'#home': '/member/home.html',
		'#orderManage': '/member/order.html',
		'#rcRecord': '/member/record.html',
		'#recruitPage': '/member/recruitPage.html',
		'#setAccount': '/member/account.html',
		'#recruitNew': '/member/recruitNew.html'

	}
//	if(location.hostname == '127.0.0.1' || location.hostname == 'localhost')
//		hashChangeMap = devHashChangeMap

	location.hash = ''

	$(window).on('hashchange', function(evt) {
		var path = location.hash.split('-')[0]
		var param = location.hash.split('-').slice(1).join('-')
		if(param==''){// 没有参数的时候
			param+='?__timestamp='+(new Date()).getTime()
		}else{
			param+='&__timestamp='+(new Date()).getTime()
		}

		if(hashChangeMap[path] != null) {
			location.href = hashChangeMap[path] + param
		}
	})

})();