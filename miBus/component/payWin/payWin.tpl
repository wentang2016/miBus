<style type="text/css">
	/*transition for vue*/
	
	#pay.pay-transition {
		transition: background linear 0.5s;
		background: rgba(100, 100, 100, 0.6);
	}
	
	#pay.pay-enter,
	#pay.pay-leave {
		background: none;
	}
	
	#pay.pay-transition .content {
		top: 30%;
	}
	
	#pay.pay-enter .content,
	#pay.pay-leave .content {
		top: 110%;
	}
	/*mask style*/
	
	.maskPanel {
		position: fixed;
		/*only fixed can be used as fixed picker will stumble animation */
		z-index: 10;
		top: 0;
		left: 0;
		right: 0;
		bottom: 0;
		text-align: center;
	}
	/*pay style*/
	
	#pay .content {
		position: absolute;
		left: 0;
		top: 110%;
		right: 0;
		margin: auto;
		width: 80%;
		overflow: scroll;
		font-size: 1.2em;
		color: #847d73;
		background: white url(../../img/editUserInfo.png) repeat top center;
		transition: top ease 0.5s;
	}
	
	#pay .content h3 {
		background: rgb(211, 146, 96);
		border-radius: 10px 10px 0 0;
		height: 25px;
	}
	
	#pay .content .innerContent {
		padding: 0 35px;
		line-height: 1.7;
	}
	
	#pay .content .password {
		white-space: nowrap;
		position: relative;
	}
	/*#pay .content .password .fakeInput {
	position: absolute;
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	opacity: 1;
	z-index:10;
	background:black;
}*/
	
	#pay .content .password span input {
		width: 30px;
		height: 30px;
		text-align: center;
		border-radius: 5px;
		border: 1px solid rgb(200, 200, 200);
	}
	
	#pay .content .password input {
		padding: 6px;
		border-radius: 7px;
		/* font-size: 1.2em; */
		text-align: center;
	}
</style>

<template id="pay_tpl">
	<div id="pay" class="maskPanel " transition="pay" @tap="closeWin">
		<div class="content c_margin c_bigRadius" @tap.stop>
			<h3></h3>
			<div class="innerContent c_margin">
				<div class="step1 c_margin" v-show="step==1">
					<div><label style="font-weight:bold;">你确定要为该会员支付吗</label></div>
					<div class="c_small">
						支付后，将扣除你的预存款，而且无法撤销，请核对信息后再支付。
					</div>
				</div>
				<div class="step2 c_margin" v-show="step==2">
					<div><label style="font-weight:bold;">请输入6位纯数字支付密码</label></div>
					<div>
						<div class="password" v-el:ipt>
							<input type="number" maxlength="6" v-model="passwd">
							<!--<span><input type="password" :value="passwd[0]" @keyup="inputPasswd($event,0)"  maxlength="1"></span>
							<span><input type="password" :value="passwd[1]" @keyup="inputPasswd($event,1)" maxlength="1"></span>
							<span><input type="password" :value="passwd[2]" @keyup="inputPasswd($event,2)" maxlength="1"></span>
							<span><input type="password" :value="passwd[3]" @keyup="inputPasswd($event,3)" maxlength="1"></span>
							<span><input type="password" :value="passwd[4]" @keyup="inputPasswd($event,4)" maxlength="1"></span>
							<span><input type="password" :value="passwd[5]" @keyup="inputPasswd($event,5)" maxlength="1"></span>-->

						</div>
					</div>
				</div>
				<div>
					<button class="bt c_bigBorder c_green" v-show="step==1" @click="nextStep" style="width:initial;color:rgba(255,255,255,0.8);font-weight:normal;padding:10px 30px;">支付</button>
					<button class="bt c_bigBorder" :class="this.passwd.length==6?'c_green':''" v-show="step==2" v-el:pay_bt @click="pay" style="width:initial;color:rgba(255,255,255,0.8);font-weight:normal;padding:10px 30px;">确认</button></div>
				<div class="step2" v-show="step==2">
					<button class="bt c_small c_bigBorder" @tap.stop.prevent="setPasswd" style="background:white;padding:5px 5px;color:black">还没设置支付密码吗？前往设置<img src="../../img/arrow.png" style="margin-left:5px;"></button>
				</div>
			</div>
		</div>
	</div>

</template>

<script>
	Vue.component('pay-win', {
		template: '#pay_tpl',
		data: function() {
			return {
				//				show: false,
				step: 2,
				passwd: ''
			}
		},
		methods: {

			closeWin: function(e) {
				this.passwd = ''
				this.$emit('closewin', e)
					//				this.show = false
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
			nextStep: function() {
				console.log(evt)
				if(this.step == 1) {
					this.step = 2
					return;
				}
			},
			pay: function(evt) {

				//			200 支付成功
				//			300 余额不足
				//			400 支付出错

				if(this.passwd.length < 6) return;

				this.$emit('pay', this.passwd)
				this.passwd = ''
					//				this.show = false

			},
			setPasswd: function(evt) {
				location.hash = '#setAccount-?tab=2'
			}

		}

	})
</script>