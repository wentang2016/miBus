var COMMON = require('../common')

exports.init = function() {

	var headerVM = new Vue({
		el: '#home',
		data: {
			user: {},
			jData: {},
			aliaccount: '',
			aliname: '',

			//money
			depositBalance: 0,
			totalEarning: 0,
			earningsBalance: 0,
			thisMonthEarning: 0,
			thisMonthAllEarning:0,

			//charge
			tradeName: '',
			tradeAmount: '',
			tradeNo: ''
		},
		methods: {
			charge: function(e) {
				if(!this.tradeName.trim() || !this.tradeAmount.trim() || !this.tradeNo.trim()) {
					alertN('充值字段不能为空')
					return
				}
				
				if(this.tradeAmount * 1 >100000){
					alertN('充值金额不得大于10万')
					return
				}

				$.ajax({
					type: "POST",
					url: COMMON.DOMAIN + "/ajax/finance/recharge",
					data: {
						name: this.tradeName, // 充值帐号名称
						money: this.tradeAmount, // 金额
						order_number: this.tradeNo // 交易号
					},
					async: true,
					success: function(data, status, xhr) {

						if(data.status == 200) {
							//headerVM.jData=data
							//location.hash = "#rcRecord"
							alertN('提交成功，等待审核，请查看充值记录', function() {
								location.hash = '#home_fn'
							})

						} else if(data.status == 300) {
							alertN('该笔充值的订单号已经存在，请勿重复提交')
						} else {
							alertN('后台错误' + data.status)
						}
					},
					error: function(xhr, errorType, error) {
						alertN('后台错误' + xhr.statusText)
					}
				});
			}
		},
		computed: {
			levelStr: function() {
				//总代(文艺米商) 一级(清新米商) 二级(青春米商) 三级(自然米商)
				var map = {
					0: '总代(文艺米商)',
					1: '一级(清新米商)',
					2: '二级(青春米商)',
					3: '三级(自然米商)'
				}
				if(this.user) {
					return map[this.user.level]
				}

				return ''

			}
		}
	})

	$.ajax({
		type: "get",
		url: COMMON.DOMAIN + "/ajax/member/person",
		async: true,
		success: function(data, status, xhr) {

			if(data.status == 200) {
				//headerVM.jData=data
				headerVM.user = data.user[0]
				headerVM.depositBalance = data.depositBalance
				headerVM.totalEarning = data.totalEarning
				headerVM.thisMonthEarning = data.thisMonthEarning
				headerVM.thisMonthAllEarning = data.thisMonthAllEarning
				headerVM.earningsBalance = data.earningsBalance

			}
		},
		error: function(xhr, errorType, error) {

		}
	});

	$.ajax({
		type: "get",
		url: COMMON.DOMAIN + "/ajax/finance/GetPayInfo",
		success: function(data, status, xhr) {

			if(data.status == 200 && status == 'success') {

				headerVM.aliname = data.result.aliname
				headerVM.aliaccount = data.result.aliaccount
			}
		},
		error: function(xhr, errorType, error) {

		}
	});
}