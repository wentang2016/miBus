<link rel="stylesheet" href="orderManage.css?__inline">

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

<link rel="import" href="../btHeader/btHeader.tpl?__inline" />
<link rel="import" href="../infoWin/infoWin.tpl?__inline"  />
<div id="orderManage" style="line-height:1.4;">

	<section v-cloak v-show="tab==1" class="c_margin">
		<div>ID: [[id]] 姓名： [[name]] 电话: [[tel]] <br> 地址: [[address]]
		</div>

		<div>

			<!--
  userinfo
  
  member_id		会员编号 	
agent_id 		代理编号 
name 			会员姓名
phone 			会员电话
wechat 			会员微信
province 		省份
city 			城市
area 			地区
address 		地址
  -->
			<div v-show="showOrder">
				<hr class="c_border c_green_border" style="border-style:dashed;">
				<button type="button" class="c_blankBt">可选会员</button><br /><br />
				<div class="userinfo c_small c_block_margin" v-for="item in memList">

					<div class="c_border c_bd_radius content" style="display:inline-block;">
						<div><span style="width:21%">ID: [[item.member_id]]</span><span style="width:19%"><input type="text" readonly  :value="item.name"></span><span style="width:34%;"><input type="tel" readonly :value="item.phone"></span><span style="width:26%"><input type="text" readonly :value="item.wechat"></span></div>
						<div style="margin-top:4px;"><input type="text" style="width:100%;" readonly :value="item.address"></div>
					</div>

					<button class="c_bt" @tap="takeOrder" :data-id="item.member_id" :data-name="item.name" :data-tel="item.phone" :data-weiXin="item.wechat" :data-address="item.address"><label>下单</label></button>
					<!--<button  class="c_bt" style="background:rgb(220,153,102)" @tap="takeOrder"></button>
				<button v-else class="c_bt c_gray_background">已付</button>-->
				</div>
			</div>

			<!--
 end userinfo
  -->
			<button type="button" class="c_bt" v-show="!showOrder" @tap="showOD">更换会员</button>
		</div>
		<hr class="c_border c_green_border" style="border-style:dashed;">
		<div>
			<button type="button" class="c_blankBt">可选择产品</button><br /><br />
			<div v-if="unorderList[id]==null || unorderList[id].notMailed.lenght==0">无产品</div>
			<div v-for="(index,item) in unorderList[id].notMailed">
				<input type="radio" :id="item.id" :value="item.id" v-model="seleOrderId" /><label :for="item.id">[[item.name]]*1</label><br>
			</div>
			<!--<input type="radio" id="item1" value="" name="item" /><label for="item1">MEH0086 米可儿定制雨伞*1</label>
		-->
		</div>

		<hr class="c_border c_green_border" style="border-style:dashed;">
		<div>
			<button type="button" class="c_blankBt c_block_margin" style="color:orange;border-color:orange;">已下单产品</button>
			<br>

			<div v-if="unorderList[id]==null || unorderList[id].mailed.lenght==0">无产品</div>

			<div v-for="(index,item) in unorderList[id].mailed"><time style="float:right;">[[item.order_date]]</time>[[item.name]]</div>
			<button type="button" class="c_bt c_line_bt c_block_margin" @tap="order">确认下单</button><br>
			<div style="color:lightcoral;" class="c_small">
				注意: 会员订单一旦确认下单，将扣除剩余货品数量，且无法更改。确认前请核对清楚!
			</div>
		</div>
		<hr class="c_border">
		<p>*你最近确认成功的订单</p>

		<div v-for="item in undelivered | orderBy order_date -1 | limitBy limitNum " class="c_border c_bigBorder  c_table_simple">
			<div class="c_table_simple_header c_small">
				<span>[[item.order_date]]</span>
				<span>订单号: [[item.order_number]]</span>
				<span>会员ID: [[item.member_id]]</span>
			</div>
			<hr class=" c_border ">
			<div class="c_green_tx">
				<div v-for="num in item.product_number"> [[item.product_name]]*1 </div>
			</div>
			<hr class="c_border">
			<div>
				<div>[[item.name]] [[item.phone]]</div>
				<div>[[item.province]][[item.city]][[item.area]][[item.address]]</div>
			</div>
			<p style="text-align: center;"><button type="button" class="c_bt">订单处理中</button></p>

		</div>
		<div style="margin-top:40px;">
			<button class="c_line_bt c_bigRadius c_gray c_gray_text" @tap="seeMoreOrder">查看更多订单信息 &gt;</button>
		</div>
		<info-win :title="infoWinTitle"  :content="infoWinContent" :buttons="infoWinButtons"  v-show="showInfoWin" @closeWin="showInfoWin=false" ></info-win>
	</section>
	<section v-cloak v-show="tab==2" class="c_margin" style="margin-top:0;">
		<p class="c_green_tx c_small">(左边的时间要小于等于右边的时间)</p>
		<div style="margin-bottom: 8px;" class="search">
			<label style="vertical-align: top;">时段 </label>
			<span class="commonSel" style="height: 20px;">
				<input type="date"  class="input c_border dateInput" v-model="fromDateCal" :value="seleNowDate.substr(0,7)+'-01'">
			</span> <span style="vertical-align: top;">-</span>
			<span class="commonSel" style="height: 20px;">
				<input type="date"  class="input c_border dateInput"  v-model="toDateCal" :value="seleNowDate" >
			</span>
		</div>
		<div class="search">
			<label style="">搜索 </label>
			<span class="commonSel"><!--<input @tap="searchByName"  type="text"  readonly class="input c_border">-->
				<select v-model="searchTypeUnDel" class="input c_border">
					<option value="1">姓名</option>
					<option value="2">电话</option>
					<option value="3">会员ID</option>  
					
				</select><img src="../../img/seleRImg.png"></span>
			<span class="commonSel" style="margin-left:10px;">
				<input type="text" v-show="searchTypeUnDel==1"  class="input c_border" v-model="memberName">
				<input type="text" v-show="searchTypeUnDel==2"  class="input c_border" v-model="memberTel">
				<input type="text" v-show="searchTypeUnDel==3"  class="input c_border" v-model="memberId">
			</span>
		</div>

		<div class="c_margin">
			<div v-for="item in undelivered | filterBy searchFilter(searchTypeUnDel)[0] in searchFilter(searchTypeUnDel)[1] | filterBy dateRangeFilter" transition="searchItemAni" stagger="100" class="c_border c_bigBorder  c_table_simple">
				<div class="c_table_simple_header c_small">
					<span>[[item.order_date]]</span>
					<span>订单号: [[item.order_number]]</span>
					<span>会员ID: [[item.member_id]]</span>
				</div>
				<hr class=" c_border ">
				<div class="c_green_tx">
					<div v-for="num in item.product_number"> [[item.product_name]]*1 </div>
				</div>
				<hr class="c_border">
				<div>
					<div>[[item.name]] [[item.phone]]</div>
					<div>[[item.province]][[item.city]][[item.area]][[item.address]]</div>
				</div>
				<p style="text-align: center;"><button type="button" class="c_bt">订单处理中</button></p>

			</div>
		</div>
	</section>

	<section v-cloak v-show="tab==3 " class="c_input c_margin " style="margin-top:0;">
		<p class="c_green_tx c_small">(左边的时间要小于等于右边的时间)</p>
		<div style="margin-bottom: 8px;" class="search">

			<label style="vertical-align: top;">时段</label>
			<span class="commonSel" style="height: 20px;">
				<input type="date"  class="input c_border dateInput" v-model="fromDateCal" :value="seleNowDate.substr(0,7)+'-01'">
			</span> <span style="vertical-align: top;">-</span>
			<span class="commonSel" style="height: 20px;">
				<input type="date"  class="input c_border dateInput"  v-model="toDateCal" :value="seleNowDate" >
			</span>
		</div>
		<div class="search">
			<label style="">搜索 </label>
			<span class="commonSel"><!--<input @tap="searchByName"  type="text"  readonly class="input c_border">-->
				<select v-model="searchTypeDel" class="input c_border">
					<option value="1">姓名</option>
					<option value="2">电话</option>
					<option value="3">会员ID</option>
					<option value="4">物流单号</option>
				</select><img src="../../img/seleRImg.png"></span>
			<span class="commonSel" style="margin-left:10px;">
				<input type="text" v-show="searchTypeDel==1"  class="input c_border" v-model="memberName">
				<input type="text" v-show="searchTypeDel==2"  class="input c_border" v-model="memberTel">
				<input type="text" v-show="searchTypeDel==3"  class="input c_border" v-model="memberId">
				<input type="text" v-show="searchTypeDel==4"  class="input c_border" v-model="memberExpressNo">
			</span>
		</div>

		<div v-for="item in delivered | filterBy searchFilter(searchTypeDel)[0] in searchFilter(searchTypeDel)[1] | filterBy dateRangeFilter"  transition="searchItemAni" stagger="100"  class="c_border c_bigBorder  c_table_simple">
			<div class="c_table_simple_header c_small">
				<span>[[item.order_date]]</span>
				<span>订单号: [[item.order_number]]</span>
				<span>会员ID: [[item.member_id]]</span>
			</div>
			<hr class="c_border ">
			<div class="c_green_tx">
				<div v-for="num in item.product_number"> [[item.product_name]]*1 </div>
			</div>
			<hr class="c_border">
			<div>
				<div>[[item.name]] [[item.phone]]</div>
				<div>[[item.province]][[item.city]][[item.area]][[item.address]]</div>
			</div>
			<p style="text-align: center;"><button type="button" class="c_bt" style="background-color:#e28955;padding:7px 15px;">[[item.express]] | [[item.express_number]]</button></p>

		</div>

	</section>

</div>

<script>
	require(['../btHeader/btHeader', 'orderManage'], function(btHeader, orderManage) {
		var vm = orderManage.init();
		btHeader.init(['新建会员订单', '待发货订单', '已发货订单'], function(tab) {
			vm.setTab(tab)
		}, vm.tab);

	})
</script>