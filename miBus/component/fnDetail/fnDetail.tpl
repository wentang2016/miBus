<link rel="stylesheet" href="fnDetail.css?__inline">
<link rel="import" href="../btHeader/btHeader.tpl?__inline" />
<link rel="import" href="../payWin/payWin.tpl?__inline" />

<div id="">
	<div id="fnDetail" v-cloak>
		<section v-cloak v-show="tab==1" class="c_input c_margin">
			<div class="c_table c_border">
				<div class="c_table_header">
					<span>日前时间</span>
					<span>类型</span>
					<span>事项</span>
					<span>收入</span>
					<span>支出</span>
					<span>余额</span>
				</div>

				<div class="c_table_row" v-for="item in depositList">
					<span>
					<div>[[item.created]]</div>
					<!--<div>16:32</div>-->
				   </span>
					<span>[[item.textType]]</span>
					<span>[[item.item]]</span>
					<span>[[item.revenue]]</span>
					<span>[[item.payment]]</span>
					<span>[[item.balance]]</span>
				</div>
				<!--<div class="c_table_row">
					<span>
					<div>2016.06.07</div>
					<div>16:32</div>
				</span>
					<span>提现</span>
					<span>特殊退回</span>
					<span>0</span>
					<span>1000</span>
					<span>3106</span>
				</div>
				<div class="c_table_row">
					<span>
					<div>2016.06.07</div>
					<div>16:32</div>
				</span>
					<span>付款</span>
					<span>2016161616161616161616161616161756</span>
					<span>0</span>
					<span>1000</span>
					<span>3106</span>
				</div>-->
			</div>
		</section>
		<section v-cloak v-show="tab==2" class="c_input c_margin">
			<div class="c_table c_border">
				<div class="c_table_header">
					<span>日前时间</span>
					<span>类型</span>
					<span>事项</span>
					<span>收入</span>
					<span>支出</span>
					<span>余额</span>
				</div>
				<div class="c_table_row" v-for="item in earningList">
					<span>
					<div>[[item.created]]</div>
					<!--<div>16:32</div>-->
				   </span>
					<span>[[item.textType]]</span>
					<span>[[item.item]]</span>
					<span>[[item.revenue]]</span>
					<span>[[item.payment]]</span>
					<span>[[item.balance]]</span>
				</div>
			</div>
		</section>
	</div>

	<div id="wdRecord" v-cloak>
		<section v-cloak v-show="tab==1" class="c_input c_margin">
			<div class="c_table c_border">
				<div class="c_table_header">
					<span>创建时间</span>
					<span>提现帐号</span>
					<span>提现金额</span>
					<span>状态</span>
				</div>
				<div class="c_table_row" v-for="item in depositList" v-if="item.payment > 0">
					<span>
						<div>[[item.created]]</div>
						<!--<div>16:32</div>-->
					</span>
					<span>
						<div>[[item.item]]</div>
						<!--<div>(庞世祥)</div>-->
					</span>
					<span>[[item.payment]]</span>
					<span>[[item.textStatus]]</span>

				</div>
				<!--<div class="c_table_row">
					<span>
						<div>2016.06.07</div>
						<div>16:32</div>
					</span>
					<span>
						<div>reaibao@163.com</div>
						<div>(庞世祥)</div>
					</span>
					<span>1000</span>
					<span>等待提现</span>

				</div>
				<div class="c_table_row">
					<span>
						<div>2016.06.07</div>
						<div>16:32</div>
					</span>
					<span>
						<div>reaibao@163.com</div>
						<div>(庞世祥)</div>
					</span>
					<span>1000</span>
					<span style="color:red;">帐号有误</span>

				</div>-->

			</div>
		</section>
		<section v-cloak v-show="tab==2" class="c_input c_margin">
			<div class="c_table c_border">
				<div class="c_table_header">
					<span>创建时间</span>
					<span>提现帐号</span>
					<span>提现金额</span>
					<span>状态</span>
				</div>
				<div class="c_table_row" v-for="item in earningList" v-if="item.payment > 0">
					<span>
						<div>[[item.created]]</div>
						<!--<div>16:32</div>-->
					</span>
					<span>
						<div>[[item.item]]</div>
						<!--<div>(庞世祥)</div>-->
					</span>
					<span>[[item.payment]]</span>
					<span>[[item.textStatus]]</span>

				</div>
			</div>
		</section>
	</div>
	<div id="wdManage" v-cloak>

		<section v-cloak class="c_input c_margin">
			<h3 style="color:green;"><span v-if="tab==1">预存款提现</span><span v-else>收益提现</span></h3>
			<div>
				<label style="position:relative;vertical-align: top;top:3px;">提现类型</label>
				<div class="c_alipay" style="display: inline-block;">
					<div class="payCorner">
						<img src="../../img/alipay.png" />
					</div>

				</div>
			</div>

			<label>提现帐号</label><input type="text" class="c_gray_text" style="" disabled readonly :value="aliaccount" />
			<label>提现金额</label><input type="number" v-model="amount" @input="checkNum" style="padding: 7px 3px;" />
			<label></label><span class="c_green_tx c_small" style="margin-top:3px;">*<span v-if="tab==1">可提现预存款[[remainDep]]元</span><span v-else>可提现收益[[remainEarn]]元</span></span>
			<div class="c_block_margin">
				<button type="button" class="c_bt c_line_bt" @click.stop.prevent="wd(tab,$event)">申请提现</button>
			</div>
			<div class="c_block_margin c_border c_green_border c_bigRadius c_aliAccount c_alipay" style="margin-top:30px;width:100%;">
				<div class="payCorner">
					<div style="display: table-row;">
						<div style="display:table-cell;width:100px;">
							<img src="../../img/alipay.png" style="width:100%;" />
						</div>
						<span style="display: table-cell;padding-left:10px;vertical-align:middle;">提现时我们将把你提现的金额打入此绑定帐号</span>
					</div>
					<hr class="c_border" style="border-style:dashed;" />
					<div class="c_small">
						<span style="margin-right:10px;">支付宝</span><span style="margin:0 5px;">帐号： [[aliaccount]]</span><span>姓名： [[aliname]]</span>
						<span style="float: right;font-size:1.4em;" class="c_link_color"><a href="#setAccount">设置</a></span>
					</div>
				</div>

			</div>
			<div style="margin-top:60px;">
				<button type="button" class="bt c_line_bt c_bigRadius c_gray_text" @click="seeProgress">查看提现进度 &gt; </button>
			</div>
		</section>
		<pay-win @pay="payForUser" v-show="showPay" @closewin="closeWin"></pay-win>
	</div>
</div>

<script>
	require(['../btHeader/btHeader', 'fnDetail'], function(btHeader, fnDetail) {
		var path = location.toJsonMap().path

		var ptab = 1
		try {
			ptab = location.toJsonMap().tab * 1
			if(isNaN(ptab)) ptab = 1
		} catch(e) {
			ptab = 1
			console.log(e)
		}

		if(path == 'fnDetail') {
			var vm = fnDetail.initFnDetail();
			btHeader.init(['预存款明细', '收益明细'], function(tab) {
				vm.setTab(tab)
			});

			//			btHeader.init(['预存款提现', '收益提现'], function(tab) {
			//				vm.setTab(tab)
			//			});
		} else if(path == 'wdRecord') {
			var vm = fnDetail.initWdRecords();
			vm.setTab(ptab)
			btHeader.init(['预存款提现', '收益提现'], function(tab) {
				vm.setTab(tab)
			}, ptab);
		} else if(path == 'wdManage') {
			var vm = fnDetail.initWdManage();

			vm.setTab(ptab)
			btHeader.init(['预存款提现', '收益提现'], function(tab) {
				vm.setTab(tab)
			}, ptab);
		}

	})
</script>