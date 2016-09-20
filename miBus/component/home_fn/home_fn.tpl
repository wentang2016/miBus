<link rel="stylesheet" href="home_fn.css?__inline">
<div id="home" v-cloak>
	<div class="header">
		<div class="pic">
			<div class="img" v-bind:style="'background-image:url('+user.headimg+')'">

			</div>
			<div class="des">
				[[user.name]]
			</div>
			<div style="position:absolute;top:120px;right:10px;color:inherit;" class="">
				<a href="#setAccount" style="text-decoration:underline;">设置</a>
				<a href="#fnDetail-?path=fnDetail" style="margin-left:10px;text-decoration:underline;">查看财务明细</a>
			</div>

		</div>
		<div class="loc">
			<img src="../../img/location.png" width="10px" style="vertical-align:middle;"> [[user.province+' '+user.city]]
		</div>
		<div class="bt">
			<span>[[levelStr]]</span>
			<span>ID: [[user.agent_id]]</span>
		</div>
	</div>

	<section class="c_secTB">

		<div class="c_hd">你的资产</div>

		<div class="c_bd">
			<div class="c_bd_hd"><span>你的预存款余额</span><span>你的未提现收益</span><span>你本月的总收益</span></div>
			<div class="c_bd_rw"><span>[[depositBalance]]</span><span>[[earningsBalance]]</span><span>[[thisMonthAllEarning]]</span></div>
			<div class="c_bd_rw"><span><a href="#fnDetail-?path=wdManage">提现</a></span><span><a href="#fnDetail-?path=wdManage&tab=2">提现</a></span><span class="c_gray_text">暂不能提现</span></div>
		</div>
		<div class="c_bt_sec" style="margin-right:3px;"><button class="c_bt c_small"><a href="#fnDetail-?path=wdRecord">查看提现纪录</a></button></div>

	</section>

	<section class="c_secTB">
		<div class="c_hd">预存款充值</div>
		<div class="c_margin c_input">
			<div class="c_alipay c_block_margin">
				<div class="payCorner">
					<img src="../../img/alipay.png" />
				</div>
			</div>
			<div>
				<label>付款人姓名</label><input type="text" v-model="tradeName" /> <br />

				<label>充值金额</label><input type="number" v-model="tradeAmount" /> <br />
				<label for="">订单号</label><input type="text" style="width:60%;calc(100%-110px)" v-model="tradeNo" />

			</div>

			<div>
				<button type="button" class="bt c_line_bt c_green c_bigRadius" @tap="charge">提交充值</button>
				<div class="c_bt_sec" style="margin-right:3px;"><button class="c_bt c_small"><a href="#rcRecord">查看充值纪录</a></button></div>
			</div>
			<div>
				<button class="c_blankBt">步骤1</button><br />
				<p style="margin-left:10px;">
					进入支付宝打款至(个人支付宝 李涛)
					<br> 支付宝帐号：msekkohy@163.com
				</p>

				<button class="c_blankBt">步骤2</button><br />
				<p style="margin-left:10px;">复制该笔支付记录的订单号，填写到上面的输入框并提交。</p>
				<div class="c_border c_bigBorder c_green_border" style="border-style:dashed;text-align: right;line-height:1.5;">
					<div><span style="float:left;">付款方式</span><span>余额宝 ></span></div>
					<div><span style="float:left;">转账说明</span><span>转账</span></div>
					<div><span style="float:left;">对方帐号</span><span>涛(*涛)mse***@163.com</span></div>
					<hr class="c_border" />
					<div><span style="float:left;">创建时间</span><span>2016-06-17 17:31</span></div>
					<div><span style="float:left;">订单号</span><span style="outline: 1px solid red; outline-offset: 3px;">2016xxxxxxxxxxxxxxxxxx</span></div>
					<div><span style="float:left;">商户订单号</span><span>2016xxxxxxxxxxxxxxxxxx</span></div>
				</div>
			</div>
		</div>

	</section>

</div>

<script>
	require(['home_fn'], function(home) {
		home.init();
	})
</script>