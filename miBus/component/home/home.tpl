<link rel="stylesheet" href="home.css?__inline">
<div id="home" v-cloak >
	<div class="header">
		<div class="pic">
			<a href="#recruitPage-?slug=[[openid]]" style="position: absolute;right:10px;text-decoration:underline;" class="c_link_color"></a>

			<div class="img" v-bind:style="'background-image:url('+user.headimg+')'">

			</div>
			<div class="des">
				[[user.name]]
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
	<section id="selfInfo">

		<div class="c_pic" v-on:click="uploadImg" v-bind:style="'display:inline-block;background-image:url('+domain+user.qrcode+')'">
			<div class="c_small" style="position:relative;top:45px;text-align:center;color:white;" v-show="!user.qrcode">点击上传二维码</div>
		</div>

		<!--<form style="display: none;" id="imgUploader" enctype="multipart/form-data" method="post" action="http://wechat.xuweidong.com/ajax/member/updateQrcode">
			<input type="file"  name="qrcode" style="display:none;" />
			<button type="submit" id="submit" name="submit"></button>
		</form>-->

		<div class="selfIntro" style="display:inline-block;">
			<button class="c_bt c_small" style="float:right;"><a href="#recruitPage-?slug=[[openid]]">查看招募页</a></button>
			<h3>我的自述</h3>
			<textarea v-show="edit" style="max-width:100%;min-height:100px;color:rgb(100,100,100);" class="ct ct_small" v-model="user.description"></textarea>
			<div v-show="!edit" class="ct c_small">
				[[user.description]]
			</div>
		</div>
		<div class="c_bt_sec"><button class="c_bt c_small" v-on:click="editCon">[[edit?'保存':'编辑文字']]</button></div>

	</section>

	<section class="c_secTB">

		<div class="c_hd">你的收益</div>

		<div class="c_bd">
			<div class="c_bd_hd"><span>本月收益</span><span>本月奖金</span><span>本月总收益</span><span>历史总收益</span></div>
			<div class="c_bd_rw"><span>[[jData.thisMonthEarning]]</span><span>[[jData.thisMonthBonus]]</span><span>[[jData.thisMonthAllEarning]]</span><span>[[jData.totalEarning]]</span></div>
		</div>
		<div class="c_bt_sec" style="margin-right:3px;"><button class="c_bt c_small"><!--#fnDetail-?path=wdManage--><a href="#home_fn">管理我的财务</a></button></div>

	</section>

	<section class="c_secTB">
		<div class="c_hd">会员数据</div>
		<div class="c_bd">
			<div class="c_bd_hd"><span>你本月招募的会员</span><span>你累计招募的会员</span></div>
			<div class="c_bd_rw"><span>[[jData.countMonthMember]]</span><span>[[jData.countAllMember]]</span></div>
		</div>
		<div class="c_bt_sec" style="margin-right:3px;"><button class="c_bt c_small"><a href="#newVip">管理我的会员</a></button></div>
	</section>

	<!--<section class="c_secTB">
		<div class="c_hd">页面数据</div>

		<div class="c_bd">
			<div class="c_bd_hd"><span>时段</span><span>页面访客数</span><span>页面访问数</span></div>
			<div class="c_bd_rw"><span>昨天</span><span>25</span><span>25</span></div>
			<div class="c_bd_rw"><span>近7天</span><span>246</span><span>246</span></div>
			<div class="c_bd_rw"><span>本月</span><span>1314</span><span>1314</span></div>
		</div>
		<div class="c_bt_sec" style="margin-right:3px;"><button class="c_bt c_small">查看我的招募页面</button></div>

	</section>-->

</div>

<script>
	require(['home'], function(home) {
		home.init();
	})
</script>