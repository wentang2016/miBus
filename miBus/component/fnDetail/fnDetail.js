var COMMON = require('../common')

//var earningList = [] //收益提现记录  收益明细
//var depositList = [] //预存款提现记录  预存款明细

var init = function(vm) {

	var depStatus = {
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
	var earnStatus = {
		0: '等待提现',
		1: '提现成功',
		2: '收益',
		21: '帐号有误',
		22: '无效提现'
	}

	$.ajax({
		type: 'GET',
		url: COMMON.DOMAIN + '/ajax/finance/GetWithdrawDeposit', //预存款提现 记录
		dataType: 'json',
		success: function(data, status, xhr) {
			if(data.status == 200) {
				vm.depositList = data.result
				vm.depositList.map(function(item, index) {
					item.textStatus = depStatus[item.status]
					return item
				})
			}
		},
		error: function(xhr, errorType, error) {

		}
	})

	$.ajax({
		type: 'GET',
		url: COMMON.DOMAIN + '/ajax/finance/GetWithdrawEarnings', //收益提现 记录
		dataType: 'json',
		success: function(data, status, xhr) {
			if(data.status == 200) {
				vm.earningList = data.result

				vm.earningList.map(function(item, index) {
					item.textStatus = earnStatus[item.status]
					return item
				})
			}
		},
		error: function(xhr, errorType, error) {

		}
	})

}
exports.initFnDetail = function() {

	var earnStatus = {
		0: '提现',
		1: '收益发放',
		2: '管理员添加'
	}
	var depStatus = {
		0: '充值',
		1: '提现',
		2: '管理员添加',
		3: '付款'
	}

	var vm = new Vue({
		el: '#fnDetail',
		/*财务详情 ，提现记录*/
		data: {
			tab: 1,
			earningList: [], //收益提现记录  收益明细
			depositList: [] //预存款提现记录  预存款明细

		},
		methods: {
			setTab: function(tab) {
				this.tab = tab
			}

		},
		computed: {

		}
	})

	//init(vm)

	$.ajax({
		type: 'GET',
		url: COMMON.DOMAIN + '/ajax/finance/GetDepositDetail', //预存款明细
		dataType: 'json',
		success: function(data, status, xhr) {
			if(data.status == 200) {
				vm.depositList = data.result
				vm.depositList.map(function(item, index) {
					item.textType = depStatus[item.type]
					return item
				})
			}
		},
		error: function(xhr, errorType, error) {

		}
	})

	$.ajax({
		type: 'GET',
		url: COMMON.DOMAIN + '/ajax/finance/GetEarningsDetail', //收益明细
		dataType: 'json',
		success: function(data, status, xhr) {
			if(data.status == 200) {
				vm.earningList = data.result

				vm.earningList.map(function(item, index) {
					item.textType = earnStatus[item.type]
					return item
				})
			}
		},
		error: function(xhr, errorType, error) {

		}
	})

	return vm;
}

exports.initWdRecords = function() {

	var vm = new Vue({
		el: '#wdRecord',
		/* 退款记录*/
		data: {
			tab: 1,
			earningList: [], //收益提现记录  收益提现 记录
			depositList: [] //预存款提现记录  预存款提现 记录
		},
		methods: {
			setTab: function(tab) {
				this.tab = tab
			}

		},
		computed: {

		}
	})

	init(vm)

	return vm;
}

exports.initWdManage = function() {

	var vm = new Vue({
		el: '#wdManage',
		/*退款管理 提款*/
		data: {
			tab: 1,
			aliaccount: '',
			aliname: '',
			amount: '100',
			remainDep: '0',
			remainEarn: '0',

			showPay: false // 显示支付框

		},
		wdUrl: '', // 提款要提交的地址
		wdData: {}, //提款需要的数据
		methods: {
			// pay component event method
			closeWin: function(e) {
				this.showPay = false
			},
			payForUser: function(passwd) {
				this.showPay = false
				var self = this
				this.wdData.password = passwd

				//200 成功
				//300 密码出错
				//400 失败
				$.ajax({
					type: "POST",
					url: self.wdUrl,
					async: true,
					data: self.wdData,
					success: function(data, status, xhr) {
						var self = this
						if(data.status == 200) {
							if(self.tab == 1) {
								self.remainDep -= self.amount * 1
							} else if(self.tab == 2) {
								self.remainEarn -= self.amount * 1
							}
							self.amount = '100' //恢复为默认的100 的字符串
							alertN('提交成功，等待审核，请查看提现记录')
						} else if(data.status == 300) {
							alertN('密码错误')
						} else {
							console.log(data.status)
							alertN('提现失败')
						}

					}.bind(this),
					error: function(xhr) {
						alertN('提现失败')
					}.bind(this)
				});
			},
			// end pay component event method
			setTab: function(tab) {
				if(typeof tab == 'string') tab = tab * 1
				this.tab = tab
			},
			checkNum: function(e) {
				e.target.value = e.target.value.match(/[1-9]\d*/)
				this.amount = e.target.value
			},
			wd: function(tab, e) {
				if(!this.aliaccount) {// 如果第一次没有账号信息则提示要设置帐号，账号信息通过ajax 去取得
					alertN('请先设置提现账号')
					return
				}

				var url = COMMON.DOMAIN
				var data = {}

				this.amount = (this.amount + '').trim() //强制转化为字符串，避免因为是数字错误
				if(this.amount.length == 0) {
					alertN('金额不能为空')
					return
				}
				if(/^0$/.test(this.amount)) {
					alertN('金额不能为0')
					return
				}

				if(!(/^[1-9]\d*$/.test(this.amount))) {
					alertN('格式不正确')
					return
				}

				if(this.amount * 1 < 100) {
					alertN('提现金额请填写大于或等于100的数字')
					return
				}
				if(this.tab == 1) { // 预存款提现

					if(this.amount * 1 > this.remainDep) {
						alertN('金额超过总金额')
						return
					}
					url += '/ajax/finance/StoreWithdrawDeposit'
					data.deposit = this.amount

				} else if(this.tab == 2) { // 收益提现

					if(this.amount * 1 > this.remainEarn) {
						alertN('金额超过总金额')
						return
					}
					url += '/ajax/finance/StoreWithdrawEarnings'
					data.earnings = this.amount

				}

				//保存变量，便于弹出密码支付框输入密码支付以后能取到要提交的数据
				this.wdUrl = url
				this.wdData = data

				this.showPay = true //弹出密码支付框

			},
			seeProgress: function(e) {
				window.location.hash = '#fnDetail-?path=wdRecord&tab=' + this.tab
			}

		},
		computed: {

		}
	})

	$.ajax({
		type: "get",
		url: COMMON.DOMAIN + "/ajax/finance/GetPayInfo",
		success: function(data, status, xhr) {

			if(data.status == 200) {

				vm.aliname = data.result.aliname
				vm.aliaccount = data.result.aliaccount
			}
		},
		error: function(xhr, errorType, error) {

		}
	});

	$.ajax({
		type: "get",
		url: COMMON.DOMAIN + "/ajax/finance/GetBalance",
		success: function(data, status, xhr) {

			if(data.status == 200) {
				vm.remainDep = data.deposit
				vm.remainEarn = data.earnings
			}
		},
		error: function(xhr, errorType, error) {

		}
	});

	return vm;
}