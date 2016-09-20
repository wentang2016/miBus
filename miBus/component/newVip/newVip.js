var COMMON = require('../common')

var cityPicker = new mui.PopPicker({
	layer: 3
})

var cityData = require('/component/cityData')

cityPicker.setData(cityData)

function validCityData(arr, children, level) {
	if(level >= arr.length) return level - 1; // 最后一层合法
	var name = arr[level]
	for(var i = 0; i < children.length; i++) {
		if(children[i].text == name) {
			return validCityData(arr, children[i].children, level + 1)
		}
	}

	return level - 1; //上一层是合格的数据

}

var namePicker = new mui.PopPicker({
	layer: 1
})

namePicker.setData([{
	value: 1,
	text: '张三'
}])

Vue.component('user-info', {
	template: '#userinfo',
	props: {
		'info': {
			type: Object,
			default: {}
		},
		index: ['Number'],
		limit: ['Number']

	},
	data: function() {
		return {
			id: this.info.member_id,
			name: this.info.name,
			tel: this.info.phone,
			weiXin: this.info.wechat,
			province: this.info.province,
			capital: this.info.city,
			district: this.info.area,
			detailAddr: this.info.address,
			status: this.info.status

		}
	},
	methods: {

		editInfo: function() {

			editVm.pushInfo({
				id: this.id,
				name: this.name,
				tel: this.tel,
				weiXin: this.weiXin,
				province: this.province,
				capital: this.capital,
				district: this.district,
				detailAddr: this.detailAddr,
			})
			editVm.show = true
			editVm.component = this

		},
		payForUser: function(evt) {
			payVm.id = this.id
			payVm.step = 1
			payVm.passwd = ''
			payVm.$els.pay_bt.classList.add('c_green') // change button color
			payVm.$els.pay_bt.removeAttribute('disabled') //enable button
			payVm.show = true
		}
	},
	computed: {
		objStyle: function() {
			var obj = {}
			if(this.index && this.index + 1 > this.limit) {
				obj.display = 'none'
			}

			return obj
		}
	},
	events: {

	}
})

var editVm = new Vue({
	el: '#edituserinfo',

	data: {
		show: false,
		id: '',
		name: '',
		tel: '',
		weiXin: '',
		province: '',
		capital: '',
		district: '',
		detailAddr: ''
	},
	component: null,
	methods: {
		closeWin: function(e) {
			this.show = false
		},
		save: function() {
			console.log(this.info)
			var self = this
			$.ajax({
				type: "GET",
				url: COMMON.DOMAIN + "/ajax/member/updateMember/" + this.id,
				data: {
					name: this.name,
					phone: this.tel,
					wechat: this.weiXin,
					province: this.province,
					city: this.capital,
					area: this.district,
					address: this.detailAddr
				},
				async: true,
				success: function(data) {
					console.log(data)
					if(data.status == 200 && self.component) { //refresh component

						self.component.name = self.name;
						self.component.tel = self.tel;
						self.component.weiXin = self.weiXin;
						self.component.province = self.province;
						self.component.capital = self.capital;
						self.component.district = self.district;
						self.component.detailAddr = self.detailAddr;
					}

				}
			});

			this.show = false
		},
		showPicker: function() {
			cityPicker.show(function(items) {
				this.province = items[0].text
				this.capital = items[1].text
				this.district = items[2].text == null ? '' : items[2].text
			}.bind(this))
		},
		pushInfo: function(info) {
			this.id = info.id
			this.name = info.name
			this.tel = info.tel
			this.weiXin = info.weiXin
			this.province = info.province
			this.capital = info.capital
			this.district = info.district
			this.detailAddr = info.detailAddr
			console.log(info)
		}
	}
})

var payVm = new Vue({
	el: '#pay',
	data: {
		id: '',
		show: false,
		step: 1,
		//		passwd: [],
		passwd: '',
		payIng:false //用来避免短时间内支付两次的
	},
	methods: {

		closeWin: function(e) {
			this.show = false
		},
		delePasswd: function(e) {
			this.rePasswd.pop()
		},
		inputPasswd: function(evt, index) {
			var oneChar = evt.target.value
				//evt.target.value = ''; // reset the value, when rePasswd changed it will updated

			if(this.passwd.length < 6) {
				if(oneChar && oneChar != '') {
					this.rePasswd.push(oneChar)
				}

			} else {
				//evt.target.blur();

			}

		},
		pay: function(evt) {
			//console.log('in')
			if(this.payIng){ //如果和第一次支付相隔太近就返回不执行。
				return
			}
			this.payIng=true// 表示正在支付, 避免马上遇到第二次支付。
			setTimeout(function () {
				this.payIng=false // 表示可以进行下一次支付了
			}.bind(this),1000)
			
			console.log(evt)
			if(this.step == 1) {
				this.step = 2
				this.$els.pay_bt.classList.remove('c_green') // change button color
				this.$els.pay_bt.setAttribute('disabled', 'disabled') //disable button until passwd inputed
				return;
			}

			//			200 支付成功
			//			300 余额不足
			//			400 支付出错

			var self = this
			$.ajax({
				type: "post",
				url: COMMON.DOMAIN + "/ajax/finance/pay",
				data: {
					member_id: this.id,
					password: this.passwd.toUpperCase()
				},
				async: true,
				success: function(data) {

					if(data.status == 200) {

						setTimeout(function() {
							//location.reload(true)
//							location.href = location.href.replace('#', '')
     						location.hash='#newVip' //refresh
						}, 700)
					} else if(data.status == 300) {
						alertN('余额不足')
					} else if(data.status == 400) {
						console.log(data.status)

						alertN('支付出错')
					} else if(data.status == 500) {
						console.log(data.status)
						self.passwd = ''
						alertN('支付密码错误')
					} else {
						console.log(data.status)
						alertN('支付失败')
					}

					payVm.show = false

				},
				error: function(xhr) {
					console.log(xhr.statusText)
					alertN('支付失败')
				}

			});

		},
		setPasswd: function(evt) {
			location.hash = '#setAccount-?tab=2'
		}

	},
	events: {
		pay: function(val) {

		}
	}
})

//watch passwd length
payVm.$watch('passwd.length', function(n, o) {
	if(n == 6) {
		payVm.$els.pay_bt.classList.add('c_green') // change button color
		payVm.$els.pay_bt.removeAttribute('disabled') //enable button
	} else {
		payVm.$els.pay_bt.classList.remove('c_green') // change button color
		payVm.$els.pay_bt.setAttribute('disabled', 'disabled') //enable button
	}
})

$('.margin').on('tap', 'input:not([readonly]), textarea', function() {
	cityPicker.hide()
})

exports.init = function() {
	var nameIdMap = {
		'姓名': 'name',
		'电话': 'tel',
		'微信': 'weiXin',
		'省份': 'province',
		'城市': 'capital',
		'地区': 'district',
		'详细地址': 'detailAddr'
	}

	var vm = new Vue({
		el: '#newVip',
		data: {
			textAreaVal: '',
			id: '',
			name: '',
			tel: '',
			weiXin: '',
			province: '',
			capital: '',
			district: '',
			detailAddr: '',
			tab: 1,

			searchType: '1', //搜索的类型
			memberName: '',
			memberWeiXin: '',
			memberTel: '',

			memList: [], //会员列表

			openid: ''

		},
		methods: {
			tabTap: function(tab) {
				this.tab = tab
			},
			textAreaPaste: function(evt) {
				evt.target.blur();
			},
			textAreaInput: function(evt) {
				//this.textAreaVal = evt.target.value + evt.clipboardData.getData('Text') //得到之前粘贴的值与最新粘贴进来的值
				//console.log(this.textAreaVal)
				var tempAddr = []
				var tempVal = this.textAreaVal.replace(/( |	)+/g, '') // remove all blank space 
				var arr = tempVal.split('\n')
				for(var i = 0; i < arr.length; i++) {
					var temp = arr[i].split(/:|：/) //english and chinese comma character 
					var k = temp[0]
					var v = temp[1] == null ? '' : temp[1]
					switch(nameIdMap[k]) {
						case 'province':
							tempAddr[0] = v;
							break;
						case 'capital':
							tempAddr[1] = v;
							break;
						case 'district':
							tempAddr[2] = v;
							break;
						default:
							{
								if(nameIdMap[k] != null) {
									this[nameIdMap[k]] = v
								}
							}
					}

				}

				if(tempAddr.length > 0) {
					var level = validCityData(tempAddr, cityData, 0)
					for(var i = 0; i <= level; i++) {
						switch(i) {
							case 0:
								this.province = tempAddr[0];
								$('.mui-picker').eq(0).find('li').each(function(index, item) {
									if(item.innerHTML == vm.province) {
										cityPicker.pickers[0].setSelectedIndex(index)
										return false;
									}

								})

								break;
							case 1:
								this.capital = tempAddr[1];
								$('.mui-picker').eq(1).find('li').each(function(index, item) {
									if(item.innerHTML == vm.capital) {
										cityPicker.pickers[1].setSelectedIndex(index)
										return false;
									}

								})
								break;
							case 2:
								this.district = tempAddr[2];
								$('.mui-picker').eq(2).find('li').each(function(index, item) {
									if(item.innerHTML == vm.district) {
										cityPicker.pickers[2].setSelectedIndex(index)
										return false;
									}

								})
								break;
						}
					}

				}

			},
			showPicker: function(evt) {
				cityPicker.show(function(items) {
					this.province = items[0].text
					this.capital = items[1].text
					this.district = items[2].text ? items[2].text : ''
				}.bind(this))
			},
			save: function() { // 保存新会员信息
				//console.log(this.textAreaVal)
				//alertN('save')
				if(!/^1\d{10}$/.test(this.tel)) {
					alertN('电话号码格式不正确')
					return
				}
				if(this.name.trim() == "" || this.weiXin.trim() == "" || this.province.trim() == "" || this.capital.trim() == ""  || this.detailAddr.trim() == "") {
					alertN('会员的字段不能有为空的')
					return
				}

				$.ajax({
					type: "POST",
					url: COMMON.DOMAIN + "/ajax/member/createMember",
					//agent_id:19,
					data: {
						submit_type: 0,
						name: this.name,
						phone: this.tel,
						wechat: this.weiXin,
						province: this.province,
						city: this.capital,
						area: this.district,
						address: this.detailAddr
					},
					success: function(data) {
						//console.log(data);
						if(data.status == 200) {
						//	location.reload(true)
//							location.href=location.href.replace('#','')
							location.hash = '#newVip' //refresh
							
						} else if(data.status == 300) {
							alertN('该会员的资料已经注册，请勿重复提交')
						} else {
							alertN('error status:' + data.status)
						}
					},
					error: function(xhr, errorType, error) {
						alertN('error:' + xhr.statusText)
					}
				});

			},
			setTel: function(evt) {
				var val = evt.target.value

				evt.target.value = ''
				if(val == null) return;

				var arr = val.match(/1\d{0,10}/)

				if(arr && arr.length > 0) {
					this.tel = arr.shift();
					evt.target.value = this.tel
				}

			},
			searchByName: function(evt) {
				namePicker.show(function(items) {
					//console.log(items[0])
					evt.target.value = items[0].text
						//console.log(evt.)
					if(items[0].value == 'all') {
						this.memberName = ''
					} else this.memberName = items[0].text

				}.bind(this))
			},

			showAllMem: function(evt) {
				$.each(document.querySelectorAll('.userinfo[style]'), function(index, item) {
					item.removeAttribute('style')
				})
				evt.target.style.display = 'none'
			}

		},
		computed: {
			memberFilter: function() {
				var searchStr = ''
				if(this.searchType == 1) {
					searchStr = this.memberName
				} else if(this.searchType == 2) {
					searchStr = this.memberWeiXin
				} else if(this.searchType == 3) {
					searchStr = this.memberTel
				}
				return searchStr
			}
		}
	})

	$.ajax({
		type: "get",
		url: COMMON.DOMAIN + "/ajax/member/getMember",
		async: true,
		success: function(data, status, xhr) {
			vm.memList = data.member
			vm.openid = data.openid
			var nameList = [{
				text: '全部',
				value: 'all'
			}]

			for(var i = 0; i < vm.memList.length; i++) {
				nameList.push({
					text: vm.memList[i].name,
					value: vm.memList[i].name
				})
			}

			namePicker.setData(nameList)

		},
		error: function(xhr, errorType, error) {

		}
	});
}