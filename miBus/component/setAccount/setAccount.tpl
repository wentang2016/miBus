<link rel="stylesheet" href="setAccount.css?__inline">

<link rel="import" href="../btHeader/btHeader.tpl?__inline" />
<div id="setAccount">

	<section v-cloak v-show="tab==1" class="c_input c_margin">
		<p class="c_green_tx">*绑定提现帐号</p>
		<p>请添加你要绑定的支付宝帐号</p>
		<div class="c_alipay noBorder">
			<img src="../../img/alipay.png" />
		</div>
		<div>
			<label>支付宝帐号</label><input type="text" v-model="aliAccountNew" :value="aliAccount" /><br />
			<label>支付宝全名</label><input type="text" v-model="aliNameNew"  :value="aliName" />

		</div>
		<button type="button" class="c_blankBt" style="line-height: 1.5" @tap="bindAccount">提交绑定</button>
		<p class="c_small">请确保提交的资料准确性，你最多可以设置1个帐号。</p>
		<hr class="c_border" />
		<div style="display: table-row;">
			<div class="c_alipay noBorder" style="display:table-cell;">
				<img src="../../img/alipay.png" />
			</div>
			<span style="display: table-cell;padding-left:10px;vertical-align:middle;">提现时我们将把你提现的金额打入此绑定帐号</span>
		</div>
		<div>
			<div style="display:inline-block;width:40%;">
				<button type="button" class="c_bt" style="width:100%;"><a href="#fnDetail-?path=wdManage">提现</a></button>
			</div>
			<div style="display:inline-block;margin-left:20px;">
				<!--<button type="button" @tap="deleAccount" class="c_bt" style="background:none;color:orange;">删除</button>-->
			</div>
		</div>
		<hr class="c_border" style="border-style:dashed;" />
		<div class="c_small">
			<span style="margin:0 10px;">支付宝</span><span style="margin:0 5px;">帐号： [[aliAccount]]</span><span>姓名： [[aliName]]</span>
		</div>

	</section>

	<section v-cloak v-show="tab==2" class="c_input c_margin">
		<h3 style="color:rgb(91, 153, 76);">*修改支付密码(密码必须为6位纯数字，首次设置时原密码为空)</h3>
		<div><label for="">原密码</label><input type="number" v-model="old_passwd" @input="onlyNum($event,'old_passwd')" maxlength="6" /></div>
		<div><label for="">新密码</label><input type="number" v-model="new_passwd" @input="onlyNum($event,'new_passwd')" maxlength="6" /></div>
		<div><label for="">确认密码</label><input type="number" v-model="conf_passwd" @input="onlyNum($event,'conf_passwd')" maxlength="6" /></div>
		<div>
			<button type="button" class="c_bt c_line_bt" @tap="setPasswd">提交</button>
		</div>
	</section>

	<div id="pay" v-cloak v-show="show" class="maskPanel " transition="pay" @tap="closeWin">
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
				<div><button class="bt c_bigBorder" disabled v-el:pay_bt @click="pay" style="width:initial;color:rgba(255,255,255,0.8);font-weight:normal;padding:10px 30px;"><label>确认</label></button></div>
				<div class="step2" v-show="step==2">
					<button class="bt c_small c_bigBorder" @click="setPasswd" style="background:white;padding:5px 5px;color:black">还没设置支付密码吗？前往设置<img src="../../img/arrow.png" style="margin-left:5px;"></button>
				</div>
			</div>
		</div>
	</div>

</div>

<script>
	require(['../btHeader/btHeader', 'setAccount'], function(btHeader, setAcount) {
		var vm = setAcount.init();
		var btHVM = btHeader.init(['绑定提现帐号', '设置支付密码'], function(tab) {
			vm.setTab(tab)
		});

		var tab = 1;
		if(location.toJsonMap().tab != null) {
			tab = location.toJsonMap().tab
			console.log(tab)
			btHVM.setTab(tab*1)
			vm.setTab(location.toJsonMap().tab)
		}

	})
</script>