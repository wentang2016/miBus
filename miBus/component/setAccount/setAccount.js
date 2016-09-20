var COMMON = require('../common')

exports.init = function() {

	var payVm = new Vue({
		el: '#pay',
		data: {
			id: '',
			show: false,
			step: 1,
			passwd: ''
		},
		methods: {

			closeWin: function(e) {
				this.show = false
			},

			inputPasswd: function(evt, index) {
				if(evt.which == 8) { //delete action
					this.passwd.pop();
					if(this.passwd[index] != null) {
						evt.target.value = this.passwd[index]
					}
				} else {
					if(this.passwd[index] == null) evt.target.value = ''; // delete display value except in passwd

					if(this.passwd.length < 6) {
						this.passwd.push(String.fromCharCode(evt.which))
					} else {
						//evt.target.blur();

					}
				}

			},
			pay: function(evt) {
				//				console.log(evt)
				//				if(this.step == 1) {
				//					this.step = 2
				//					this.$els.pay_bt.classList.remove('c_green') // change button color
				//					this.$els.pay_bt.setAttribute('disabled', 'disabled') //disable button until passwd inputed
				//					return;
				//				}

				//				100 密码设置密码 - 跳到设置密码页
				//				200 成功设置支付信息
				//				300 密码错误
				//				400 保存出错
				//				500 用户信息不匹配

				var self = this
				var statusMap = {
					200: '成功设置支付信息',
					300: '密码错误',
					400: '保存出错',
					500: '用户信息不匹配'
				}
				$.ajax({
					type: "POST",
					url: COMMON.DOMAIN + "/ajax/finance/SetAli",
					async: true,
					data: {
						aliaccount: vm.aliAccountNew,
						aliname: vm.aliNameNew,
						password: this.passwd
					},
					success: function(data, status, xhr) {
						if(data.status == 200) {
							this.show = false
								//alertN('绑定成功')
							vm.aliAccount = vm.aliAccountNew
							vm.aliName = vm.aliNameNew
							alertN('您已成功修改绑定的提现账户')

						} else {
							if(statusMap[data.status]) {
								alertN(statusMap[data.status], function() {
									self.passwd = ''
								})
							} else {
								console.log('Error status: ' + data.status)
							}
						}

					}.bind(this),
					error: function(xhr, errorType, error) {

						console.log(xhr.statusText)
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
		} else { //if(n < o && n == 5)
			payVm.$els.pay_bt.classList.remove('c_green') // change button color
			payVm.$els.pay_bt.setAttribute('disabled', 'disabled') //enable button
		}
	})

	var vm = new Vue({
		el: '#setAccount',
		data: {
			tab: 1,
			aliName: '',
			aliAccount: '',
			aliNameNew: '',
			aliAccountNew: '',

			//tab 2
			old_passwd: '',
			new_passwd: '',
			conf_passwd: ''

		},
		methods: {
			setTab: function(tab) {
				this.tab = tab
			},

			bindAccount: function(e) {
				console.log(e)
				this.aliAccountNew = this.aliAccountNew.trim()
				this.aliNameNew = this.aliNameNew.trim()
				if(this.aliAccountNew == '' || this.aliNameNew == '') {
					alertN('帐号信息不能为空')
					return
				}

				payVm.step = 2 //一定要设置为2，绑定帐号不需要第一步
				payVm.passwd = ''
				payVm.show = true

			},

			deleAccount: function(e) { //删除帐号
				var info = confirm('删除帐号?')
				if(info) {
					$.ajax({
						type: "get",
						url: "",
						async: true
					});
				}

			},

			//tab 2
			onlyNum: function(e, type) {
				var valArr = e.target.value.match(/\d{1,6}/)
				var val = ''
				if(valArr && valArr[0]) val = valArr[0]
				this[type] = val
			},

			setPasswd: function(e) {
				this.new_passwd = this.new_passwd.trim()
				if(this.new_passwd == '') {
					alertN('新密码不能为空');
					return;
				}
				if(this.new_passwd.length != 6) {
					alertN('密码需要为6位');
					return;
				}
				if(this.new_passwd != this.conf_passwd) {
					alertN('新密码两次输入不一致');
					return;
				}

				this.new_passwd = this.new_passwd.toUpperCase()

				$.ajax({
					type: "POST",
					url: COMMON.DOMAIN + "/ajax/finance/SetPassword",
					async: true,
					data: {
						old_password: this.old_passwd.trim(),
						new_password: this.new_passwd.trim()
					},
					success: function(data, status, xhr) {
						if(data.status == 200) alertN('修改成功')
						else {
							console.log(data.status)
							alertN('密码设置失败请确认以前的密码是否填写正确')
						}
					},
					error: function(xhr, errorType, error) {
						alertN('网络请求失败' + xhr.statusText)
					}

				});
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

				vm.aliName = data.result.aliname
				vm.aliAccount = data.result.aliaccount
			}
		},
		error: function(xhr, errorType, error) {

		}
	});

	return vm;
}