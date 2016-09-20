<link rel="stylesheet" href="rcRecord.css?__inline">

<link rel="import" href="../btHeader/btHeader.tpl?__inline" />
<div id="">
	<div id="rcRecord" v-cloak>
		<section v-cloak class="c_input c_margin">
			<div class="c_table c_border">
				<div class="c_table_header">
					<span>创建时间</span>
					<span>交易单号</span>
					<span>充值金额</span>
					<span>状态</span>
				</div>
				<div class="c_table_row" v-for="item in rcList">
					<span>[[item.created]]</span>
					<span>[[item.deposit_order_number]]</span>
					<span>[[item.revenue]]</span>
					<span>[[item.statusText]]</span>
				</div>
				<!--<div class="c_table_row">
					<span>2016.06.07 16:32</span>
					<span>20161623563748589699937654567893454</span>
					<span>1000</span>
					<span>等待审核</span>
				</div>-->
			</div>
		</section>

	</div>

</div>

<script>
	require(['rcRecord'], function(rcRecord) {

		var vm = rcRecord.init();
		//			btHeader.init(['预存款提现', '收益提现'], function(tab) {
		//				vm.setTab(tab)
		//			});

	})
</script>