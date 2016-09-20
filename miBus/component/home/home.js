var COMMON = require('../common')

exports.init = function() {

	var vm = new Vue({
		el: '#home',
		data: {
			user: {
				description: 'hi，我爱玩，爱生活。从一个米家产品的粉丝，到成为米家正式认证的美容顾问，米可儿对我来说，已经是一种生活方式，清新、自然、有态度。给你自己一次机会，来感受不一样的米可儿吧！'
			},
			domain: COMMON.DOMAIN,
			input: null,
			edit: false,
			jData: {},
			openid: ''
		},
		methods: {
			uploadImg: function(evt) {
				var $body = $('body');
				if(!this.input) {
					this.input = $('<input type="file" accept="image/*" style="display:none;" />')[0]
					$body.append(this.input)
				}

				this.input.click()

				var self = this;

				this.input.onchange = function() {
					var file = this.files[0]
						//console.log(file)
					if(!window.FormData) {
						alertN('此版本不支持上传，请更新浏览器或者微信')
						return
					}
					var formData = new FormData()

					if(file != null) {
						formData.append('qrcode', file)
						if(!window.XMLHttpRequest) {
							alertN('浏览器不支持上传功能')
							return
						}
						var xhr = new XMLHttpRequest()
						xhr.addEventListener('load', function(e) {
							if(e.target.status == 200) {
								try {
									//location.hash = '#home'
									var obj = eval('(' + e.target.responseText + ')')
									if(obj.status == 200) {
										location.hash = '#home'
									}else{
										alertN('服务器反馈错误，无法上传')
									}
								} catch(e) {
									console.log(e.message)
								}

							}
						})
						xhr.open('POST', COMMON.DOMAIN + "/ajax/member/updateQrcode", true)
						xhr.send(formData)

					}
				}


			},
			editCon: function() {
				this.edit = !this.edit;
				if(!this.edit) {
					$.ajax({
						type: "POST",
						url: COMMON.DOMAIN + "/ajax/member/updateDescription",
						data: {
							desc: this.user.description != null ? this.user.description : ''
						},
						success: function(data) {
							console.log(data);
						}
					});
				}
			}

		},
		computed:{
			levelStr:function(){
				//总代(文艺米商) 一级(清新米商) 二级(青春米商) 三级(自然米商)
				var map={
					0:'总代(文艺米商)',
					1:'一级(清新米商)',
					2:'二级(青春米商)',
					3:'三级(自然米商)'
				}
				
				return map[this.user.level]
			}
		}
		
	})

	var headerVM = new Vue({
		el: '.header',
		data: {
			user: {}
		}
	})

	$.ajax({
		type: "get",
		url: COMMON.DOMAIN + "/ajax/member/person",
		async: true,
		success: function(data, status, xhr) {

			if(data.status == 200 && status == 'success') {
				vm.jData = data

				vm.user = data.user[0]
				headerVM.user = data.user[0]

				if(vm.user.description == null || vm.user.description.trim() == '')
					vm.user.description = 'hi，我爱玩，爱生活。从一个米家产品的粉丝，到成为米家正式认证的美容顾问，米可儿对我来说，已经是一种生活方式，清新、自然、有态度。给你自己一次机会，来感受不一样的米可儿吧！'

				COMMON.USER = Vue.extend({}, data.user[0])
			}
		},
		error: function(xhr, errorType, error) {

		}
	});

	//get openid only
	$.ajax({
		type: "get",
		url: COMMON.DOMAIN + "/ajax/member/getMember",
		async: true,
		success: function(data, status, xhr) {
			vm.openid = data.openid

		},
		error: function(xhr, errorType, error) {

		}
	});
}