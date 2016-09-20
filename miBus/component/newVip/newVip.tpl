<link rel="stylesheet" href="newVip.css?__inline">
<template id="userinfo">
	<style>
		.userinfo {
			position: relative;
		}
		
		.userinfo .content {
			width: 80%;
			padding: 5px;
		}
		
		.userinfo .content span {
			display: inline-block;
			width: 22%;
		}
		
		.userinfo .content span input {
			width: 100%;
			text-align: center;
			padding: 0;
		}
		
		.userinfo input {
			color: inherit;
		}
		
		.userinfo button:nth-of-type(1) {
			position: absolute;
			top: 0;
			right: 0;
		}
		
		.userinfo button:nth-of-type(2) {
			position: absolute;
			bottom: 0;
			right: 0;
		}
	</style>
	<div class="userinfo c_small" :style="objStyle">

		<div class="c_border c_bd_radius content" style="display:inline-block;">
			<div><span style="width:21%">ID: [[id]]</span><span style="width:19%"><input type="text" readonly  :value="name"></span><span style="width:34%;"><input type="tel" readonly :value="tel"></span><span style="width:26%"><input type="text" readonly :value="weiXin"></span></div>
			<div style="margin-top:4px;"><input type="text" style="width:100%;" readonly :value="detailAddr"></div>
		</div>

		<button class="c_bt" @tap="editInfo"><label>编辑</label></button>
		<button v-if="status==0" class="c_bt" style="background:rgb(220,153,102)" @tap="payForUser">支付</button>
		<button v-else="status!=0" class="c_bt c_gray_background">已付</button>
	</div>
</template>

<div id="newVip">

	<section style="text-align:center;">
		<div style="display:inline-block;margin-right:2px;" @tap="tabTap(1)" class="c_big_bt c_green" :class="[tab==1?'bg_sel':'']">
			<img src="/img/addNewVip.png"><label>新建会员信息</label>
		</div>
		<div style="display:inline-block;margin-left:2px;" @tap="tabTap(2)" class="c_big_bt c_green" :class="[tab==2?'bg_sel':'']">
			<img src="/img/vipList.png"><label>会员信息列表</label>
		</div>
	</section>
	<hr class="c_border">
	<div id="secContainer">
		<div id="newVipSec" v-show="tab==1" v-cloak>
			<!--transition="swip"-->
			<section>
				<h3 class="c_green_tx">*新建会员信息</h3>

				<div class="c_small" style="margin:10px 0;white-space: nowrap;">
					<div class="c_bt stepBT" style="display:inline-block;max-width:34%;padding:4px;">
						<div style="transform:scale(0.9);">step <span>01粘贴资料</span></div>
					</div>
					<div class="c_bt" style="display:inline-block; max-width:65%;float:right;padding:4px 0;background:rgb(137,176,65)">
						<div style="transform:scale(0.9);">
							<a href="#recruitNew-?slug=[[openid]]">也可以点这里发送链接让会员填写哦</a>
						</div>
					</div>

				</div>

				<div class="margin">
					<textarea class="c_border c_bd_radius" @blur="textAreaInput" v-model="textAreaVal"></textarea>
					<div class="c_bt stepBT c_small" style="display:inline-block;max-width:34%;padding:4px;">
						<div style="transform:scale(0.9);">step <span>02编辑资料</span></div>
					</div>
					<div><label class="c_green_tx c_small"><!--ID: 6787--></label></div>
					<div class="threeCol">
						<span><label>姓名</label><input type="text" id="name" v-model="name"  class="c_border" ></span>
						<span><label>电话</label><input type="tel" id="telephone" @input="setTel" :value="tel" class="c_border" ></span>
						<span><label>微信</label><input type="text" id="weiXin" v-model="weiXin"  class="c_border" ></span>
					</div>
					<div class="threeCol" id="address">
						<label style="display:inline-block;max-width:10%;">地址</label>
						<span style="max-width:29%;" @tap="showPicker"><input type="text" readonly id="province" v-model="province"  class="c_border" ><img src="../../img/seleRImg.png"></span>
						<span style="max-width:29%;" @tap="showPicker"><input type="text" readonly id="capital" v-model="capital"   class="c_border"><img src="../../img/seleRImg.png"></span>
						<span style="max-width:29%;" @tap="showPicker"><input type="text" readonly id="district" v-model="district"  class="c_border" ><img src="../../img/seleRImg.png"></span>
					</div>
					<div>
						<input type="text" class="c_border c_bigBorder" v-model="detailAddr">
					</div>
					<div><button class="c_bt c_line_bt c_green" @click="save">保存到会员列表</button></div>
				</div>

			</section>

			<hr class="c_border">

			<section class="c_margin">
				<h3>*你最近添加成功的会员信息</h3>

				<user-info v-for="mem in memList" :info="mem" :index="$index" :limit="2"></user-info>

				<div style="margin-top:20px;"><button class="c_border c_bigBorder c_line_bt c_gray_text" v-on:tap="showAllMem">查看更多的会员信息&gt;</button></div>

			</section>
		</div>
		<div id="vipListSec" v-show="tab==2" v-cloak>
			<!--transition="swip"-->
			<section class="c_margin">
				<h3 style="color:rgb(91,153,76)">*会员信息列表</h3>
				<div style="text-align:right;">
					<span>
					<label>搜索 </label>
					<span class="commonSel" ><!--<input @tap="searchByName"  type="text"  readonly class="input c_border">-->
					<select v-model="searchType" class="input c_border">
						<option value="1" selected>姓名</option>
						<option value="2">微信号</option>
						<option value="3">手机号</option>
					</select><img src="../../img/seleRImg.png"></span>
					<span class="commonSel" style="margin-left:10px;">
						<input v-show="searchType==1"  class="input c_border" v-model="memberName">
						<input v-show="searchType==2"  class="input c_border" v-model="memberWeiXin">
						<input v-show="searchType==3"  class="input c_border" v-model="memberTel">
					</span>
					</span>
				</div>
				<user-info v-for="mem in memList | filterBy memberFilter" :info="mem"></user-info>

			</section>
		</div>
	</div>
	<div id="edituserinfo" v-show="show" class="maskPanel" transition="editUserShow" @tap="closeWin">
		<div class="usercont c_bigBorder c_margin" style="padding:0;" @tap.stop>
			<div class="header" style="border-radius:10px 10px 0 0;">会员资料编辑</div>
			<div><label class="c_green_tx">ID: [[id]]</label></div>
			<div>
				<div class="info"><label>姓名</label><input type="text" class="c_border c_bigRadius " v-model="name"></div>
			</div>
			<div>
				<div class="info"><label>电话</label><input type="tel" class="c_border c_bigRadius " v-model="tel"></div>
			</div>
			<div>
				<div class="info"><label>微信</label><input type="text" class="c_border c_bigRadius " v-model="weiXin"></div>
			</div>
			<div>
				<div class="info"><label>省份</label><span class="commonSel"><input type="text" v-el:province readonly class="c_border input" :value="province" @tap="showPicker"><img src="../../img/seleRImg.png"></span></div>
			</div>
			<div>
				<div class="info"><label>城市</label><span class="commonSel"><input type="text" v-el:capital readonly class="c_border input" :value="capital" @tap="showPicker"><img src="../../img/seleRImg.png"></span></div>
			</div>
			<div>
				<div class="info"><label>地区</label><span class="commonSel"><input type="text" v-el:district readonly class="c_border input" :value="district" @tap="showPicker"><img src="../../img/seleRImg.png"></span></div>
			</div>
			<div>
				<div class="info">
					<textarea class="c_border c_bigBorder" v-model="detailAddr"></textarea>
				</div>
			</div>
			<div><button class="c_border c_bigRadius c_green" @tap="save" style="color:rgba(255,255,255,0.7);padding:5px 15px;">保存</button></div>
		</div>
	</div>
	<div id="pay" v-show="show" class="maskPanel " transition="pay" @tap="closeWin">
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
							<!--<span><input type="password" :value="passwd[0]" @input="inputPasswd($event,0)" @keyup.delete="delePasswd" ></span>
							<span><input type="password" :value="passwd[1]" @input="inputPasswd($event,1)" @keyup.delete="delePasswd" ></span>
							<span><input type="password" :value="passwd[2]" @input="inputPasswd($event,2)" @keyup.delete="delePasswd" ></span>
							<span><input type="password" :value="passwd[3]" @input="inputPasswd($event,3)" @keyup.delete="delePasswd" ></span>
							<span><input type="password" :value="passwd[4]" @input="inputPasswd($event,4)" @keyup.delete="delePasswd" ></span>
							<span><input type="password" :value="passwd[5]" @input="inputPasswd($event,5)" @keyup.delete="delePasswd" ></span>-->

						</div>
					</div>
				</div>
				<div><button class="bt c_bigBorder c_green" v-el:pay_bt @tap="pay" style="width:initial;color:rgba(255,255,255,0.8);font-weight:normal;padding:10px 30px;"><label  v-show="step==1">支付</label><label v-else>确认</label></button></div>
				<div class="step2" v-show="step==2">
					<button class="bt c_small c_bigBorder" @click="setPasswd" style="background:white;padding:5px 5px;color:black">还没设置支付密码吗？前往设置<img src="../../img/arrow.png" style="margin-left:5px;"></button>
				</div>
			</div>
		</div>
	</div>

</div>

<script>
	require(['newVip'], function(newVip) {
		newVip.init();
	})
</script>