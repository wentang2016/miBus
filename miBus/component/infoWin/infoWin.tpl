<style type="text/css">
	/*transition for vue*/
	
	#infoWin.infoWin-transition {
		transition: background linear 0.5s;
		background: rgba(100, 100, 100, 0.6);
	}
	
	#infoWin.infoWin-enter,
	#infoWin.infoWin-leave {
		background: none;
	}
	
	#infoWin.infoWin-transition .content {
		top: 30%;
	}
	
	#infoWin.infoWin-enter .content,
	#infoWin.infoWin-leave .content {
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
	
	#infoWin .content {
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
	
	#infoWin .content h3 {
		background: rgb(211, 146, 96);
		border-radius: 10px 10px 0 0;
		height: 25px;
	}
	
	#infoWin .content .innerContent {
		padding: 0 35px;
		line-height: 1.7;
	}
	
	#infoWin .content .password {
		white-space: nowrap;
		position: relative;
	}
	
	#infoWin button {
		width: initial;
		color: rgba(255, 255, 255, 0.8);
		font-weight: normal;
		padding: 10px 30px;
		margin: 0 8px;
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
	
	#infoWin .content .password span input {
		width: 30px;
		height: 30px;
		text-align: center;
		border-radius: 5px;
		border: 1px solid rgb(200, 200, 200);
	}
</style>

<template id="info_tpl">
	<div id="infoWin" class="maskPanel " transition="infoWin" @tap="closeWin">
		<div class="content c_margin c_bigRadius" @tap.stop>
			<h3></h3>
			<div class="innerContent c_margin">
				<div class="step1 c_margin">
					<div><label style="font-weight:bold;">[[title]]</label></div>
					<div class="c_small" style="text-align: left;">
						[[content]]
					</div>
				</div>

				<div>
					<button class="bt c_bigBorder c_green" v-for="button in buttons" :data-index="$index" @click="btAction">[[button.name]]</button>

				</div>
			</div>
		</div>
	</div>
</template>

<script>
	Vue.component('info-win', {
		template: '#info_tpl',
		props: {
			buttons: {
				/*{
					name:String,
					callback:function
				}*/
				type: Array,
				default: []
			},
			title: {
				type: String,
				default: ''
			},
			content: {
				type: String,
				default: ''
			}
		},
		data: function() {
			return {
				//				show: false,
			}
		},
		methods: {

			closeWin: function(e) {
				this.$emit('closewin', e)
					//				this.show = false
			},

			btAction: function(e) {
				var index=e.target.getAttribute('data-index')
				var btInfo=this.buttons[index]
				if(btInfo && btInfo.callback){
					btInfo.callback(e)
				}
				this.$emit('closewin', e)
			}

		}
	})
</script>