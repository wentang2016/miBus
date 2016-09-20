var COMMON = require('../common')

exports.init = function() {

	var vm = new Vue({
		el: '#orderManage',
		data: {
			tab: 1,
			memList: [],
			undelivered: [],
			delivered: [],

			showOrder: false,
			//tab 1
			limitNum: 3,

			//infowind
			infoWinTitle: '',
			infoWinContent: '',
			infoWinButtons:[],
			showInfoWin: false,

			//member info
			id: '',
			name: '',
			tel: '',
			weiXin: '',
			address: '',
			unorderList: {}, //全部人的可选产品和已寄出产品信息

			seleOrderId: '', //选中的订单信息

			//订单搜索条件，目前已经发货和待发货搜索时的变量是共用的

			searchTypeUnDel: '1', // 未发货搜索条件
			searchTypeDel: '1', // 已经发货搜索条件

			toDate: '',
			fromDate: '',
			memberName: '',
			memberId: '',
			memberTel: '',
			memberExpressNo: ''

		},
		methods: {
			setTab: function(tab) {
				this.tab = tab
			},
			showOD: function(e) {
				this.showOrder = true
			},
			takeOrder: function(e) { // 选择不同的会员
				this.id = e.currentTarget.getAttribute('data-id')
				this.name = e.currentTarget.getAttribute('data-name')
				this.tel = e.currentTarget.getAttribute('data-tel')
				this.weiXin = e.currentTarget.getAttribute('data-weiXin')
				this.address = e.currentTarget.getAttribute('data-address')

				this.showOrder = false
			},

			order: function(e) { //下单
				var self=this
				
				if(this.seleOrderId == '') {
					alertN('请选择产品')
					return;
				}
				var chooseOrder = function() {
					if(this.id != '') {
						var self = this
						$.ajax({
							type: "post",
							url: COMMON.DOMAIN + "/ajax/order/postOrder",
							data: {
								product_id: this.seleOrderId,
								member_id: this.id
							},
							async: true,
							success: function(data, status, xhr) {
								if(data.status == 200) {
									alertN('提交成功', function() {
										localStorage.setItem('memberid', self.id)
										location.hash = '#orderManage' //refresh

									})
								}
							},
							error: function(xhr, errorType, error) {

							}
						});
					}
				}
				
				
				this.infoWinButtons=[{
					name:'取消'
				},{
					name:'确定',
					callback:function (e) {
						chooseOrder.call(self)
					}
				}]
				this.infoWinTitle=''
				this.infoWinContent='下单后，将无法撤销，且无法修改地址，请确认！'
				this.showInfoWin=true
		
			},

			seeMoreOrder: function(e) {
				this.limitNum = 100
				e.target.style.display = 'none'
			},
			//used for filter
			dateRangeFilter: function(item) {
				var date = item.order_date
				if(!date) return false
				date = date.replace(/-/g, '/')

				//转换为日期类型
				try {
					date = new Date(date)
				} catch(e) {
					console.log(e)
					return false
				}

				var fromDate = null
				var toDate = null

				if(this.fromDate) {
					fromDate = new Date(this.fromDate)
				}
				if(this.toDate) {
					toDate = new Date(this.toDate)
					toDate.setHours(24)
						//往后推一天，由于this.toDate 只包含日期没有时间，
						//默认是toDate的开始，需要加24小时代表是toDate的最迟时间
				}

				var match = true

				if(fromDate && date < fromDate) {
					match = false
				}
				if(toDate && date > toDate) {
					match = false
				}

				return match
			},
			searchFilter: function(searchType) {

				//				memberName: '',
				//				memberId: '',
				//				memberTel: '',
				//				memberOrderNo: ''
				var map = {
					1: [this.memberName, 'name'],
					2: [this.memberTel, 'phone'],
					3: [this.memberId, 'member_id'],
					4: [this.memberExpressNo, 'express_number']
				}

				return map[searchType]
			}

		},
		computed: {
			memListCP: {
				set: function(list) {
					this.memList = list
					var memberId = localStorage.getItem('memberid')
					if(memberId != null) {
						for(var i = 0; i < this.memList.length; i++) {
							var temp = this.memList[i]
							if(temp.member_id == memberId) {
								this.id = temp.member_id
								this.name = temp.name
								this.tel = temp.phone
								this.weiXin = temp.wechat
								this.address = temp.address
								break
							}
						}
					}

					if((this.id == null || this.id == '') && this.memList[0]) {
						var temp = this.memList[0]
						this.id = temp.member_id
						this.name = temp.name
						this.tel = temp.phone
						this.weiXin = temp.wechat
						this.address = temp.address

					}

				}
			},
			seleNowDate: function() { //用来初始化现在显示的时间
				var d = new Date()
				var year = d.getFullYear()
				var month = d.getMonth() + 1
				if(month < 10) month = '0' + month
				var day = d.getDate()
				if(day < 10) day = '0' + day

				return year + '-' + month + '-' + day
			},
			fromDateCal: {
				get: function() {
					return this.fromDate
				},
				set: function(val) {
					var from = new Date(val)
					var to = new Date(this.toDateCal)
					if(from > to) {
						this.fromDate = this.toDateCal
					} else
						this.fromDate = val
				}
			},
			toDateCal: {
				get: function() {
					return this.toDate
				},
				set: function(val) {

					var from = new Date(this.fromDateCal)
					var to = new Date(val)
					if(from > to) {
						this.toDate = this.fromDateCal
					} else
						this.toDate = val
				}
			}

		}
	})

	//number 	返回记录数   空则返回全部
	//status 	默认0  	0-未付费会员	1-已付费会员
	//type 	默认0 	0-代理提交	1-会员提交
	//	$.ajax({
	//		type: "get",
	//		url: COMMON.DOMAIN + "/ajax/member/getMember",
	//		async: true,
	//		success: function(data, status, xhr) {
	//			var tempMem = data.member
	//			vm.memListCP = tempMem
	//
	//		},
	//		error: function(xhr, errorType, error) {
	//
	//		}
	//	});

	$.ajax({
		type: "get",
		url: COMMON.DOMAIN + "/ajax/order/unorderList",
		async: true,
		success: function(data, status, xhr) {
			if(data.status == 200)
				delete data.status
			vm.unorderList = data
			var arr = []
			for(var key in data) {
				arr.push(data[key].member)
			}
			//			var tempMem = data.member
			vm.memListCP = arr

		},
		error: function(xhr, errorType, error) {

		}
	});

	$.ajax({
		type: 'get',
		url: COMMON.DOMAIN + '/ajax/order/delivered',
		dataType: 'json',
		success: function(data, status, xhr) {
			if(data.status == 200) {
				vm.delivered = data.order
			}
		},
		error: function(xhr, errorType, error) {

		}
	})

	$.ajax({
		type: 'get',
		url: COMMON.DOMAIN + '/ajax/order/undelivered',
		dataType: 'json',
		success: function(data, status, xhr) {
			if(data.status == 200) {
				vm.undelivered = data.order
			}
		},
		error: function(xhr, errorType, error) {

		}
	})

	return vm;
}