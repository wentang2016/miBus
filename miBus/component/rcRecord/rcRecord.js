exports.init = function() {

	var vm = new Vue({
		el: '#rcRecord',
		/*付款记录*/
		data: {
			rcList: []
		},
		methods: {
			setTab: function(tab) {
				//this.tab = tab
			}

		},
		computed: {

		}
	})

	$.ajax({
		type: "get",
		url: "http://wechat.xuweidong.com/ajax/finance/GetDeposit",
		success: function(data, status, xhr) {
			if(data.status == 200) {
				vm.rcList = data.result
				if(vm.rcList) {
					vm.rcList.forEach(function(item, index) {
						//status: 状态  
						//						var map = {
						//							0: '等待审核',
						//							1: '充值成功',
						//							18: '付款',
						//							19: '订单号有误',
						//							20: '管理员添加',
						//							21: '金额有误',
						//							22: '重复充值',
						//							23: '无效充值'
						//						}
						var map = {
							0: '等待审核',
							1: '充值成功',
							18: '付款',
							19: '订单号有误',
							20: '管理员添加',
							21: '金额有误',
							22: '重复充值',
							23: '无效充值',
							30: '提现成功',
							31: '帐号有误',
							32: '无效提现'
						}
						
						item.statusText = map[item.status]
					})
				}

			}
		},
		error: function(xhr, errorType, error) {

		}
	});

	return vm;
}