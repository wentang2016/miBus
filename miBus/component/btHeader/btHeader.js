exports.init = function(names, cb, tab) {

	var vm = new Vue({
		el: '#btHeader',
		data: {
			names: [],
			tab: 1
		},
		methods: {
			tabTap: function(tab) {
				this.tab = tab
				cb && typeof cb == 'function' && cb(tab)
			},
			setTab: function(tab) {
				if(typeof tab == 'number') {
					this.tab = tab
				}
			}

		},
		computed: {

		}
	})

	if(Array.isArray(names)) vm.names = names

	if(typeof tab == 'number') {
		vm.tab = tab
	}

	return vm

}