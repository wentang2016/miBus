<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">

<link rel="stylesheet" href="../css/common.css">

<script src="../js/require.js"></script>
<script src="../js/zepto.js"></script>
<script src="../js/vue.js"></script>

<script src="../js/common.js"></script>

<!--
below is customized alert
-->
<style>
	.app-alert {
		text-align: center;
		position: fixed;
		top: 30%;
		left: 0;
		right: 0;
		width: 230px;
		margin: auto;
		border: 1px solid lightgray;
		border-radius: 5px;
		/*background: #f7f7f7;*/
		background: rgba(220, 220, 220, 0.8);
		color: #6b6a6a;
		z-index: 9999;
	}
	
	.app-alert>h3 {
		border-bottom: 1px solid darkgray;
		margin: 0;
		padding: 10px 0;
	}
	
	.app-button {
		width: 100%;
		padding: 0 0.25rem;
		height: 2.2rem;
		font-size: 0.85rem;
		line-height: 2.2rem;
		text-align: center;
		color: #0894ec;
		display: block;
		position: relative;
		white-space: nowrap;
		text-overflow: ellipsis;
		overflow: hidden;
		cursor: pointer;
		box-sizing: border-box;
	}
	
	.app-button:active {
		/*background: #d4d4d4;*/
	}
</style>

<script type="text/javascript">
	//Vue.config.debug=true

	window.alertN = function(msg, callBack) {
		if(callBack == null) callBack = function() {}
			//mui.toast(msg)
		var child = document.querySelector('.app-alert')
		if(child) document.body.removeChild(child)
		var $obj = $('<div class="app-alert"><h3>' + msg + '</h3><div><span class="app-button">确定</span></div></div>')
		$obj.appendTo('body')

		$obj[0].querySelector('.app-button').onclick = function(e) {
			document.body.removeChild($obj[0])
			if(typeof callBack == 'function') {
				callBack(e)
			}

		}

	}

	//	window.confirmN = function(msg, successCB, cancelCB) {
	//		if(successCB == null) successCB = function() {}
	//			//mui.toast(msg)
	//		var child = document.querySelector('.app-alert')
	//		if(child) document.body.removeChild(child)
	//		var $obj = $('<div class="app-alert"><h3>' + msg + '</h3><div><span class="app-button">确定</span></div></div>')
	//		$obj.appendTo('body')
	//
	//		$obj[0].querySelector('.app-button').onclick = function(e) {
	//			document.body.removeChild($obj[0])
	//			if(typeof callBack == 'function') {
	//				callBack(e)
	//			}
	//
	//		}
	//
	//	}

	//	window.alert = function(msg, callBack) {
	//		old]]'callBack: ' + callBack)
	//		if(callBack == null) callBack = function() {}
	//			//mui.toast(msg)
	//		var child = document.querySelector('.app-alert')
	//		if(child) document.body.removeChild(child)
	//		var $obj = $('<div class="app-alert"><h3>' + msg + '</h3><div><span class="app-button">确定</span></div></div>')
	//		$obj.appendTo('body')
	//
	//		$obj[0].querySelector('.app-button').onclick = function(e) {
	//			document.body.removeChild($obj[0])
	//			try {
	//				oldAlert('will call back 1')
	//				callBack(e)
	//				oldAlert('call back finished ' + callBack)
	//			} catch(e) {
	//				oldAlert('error in call back 1')
	//				console.log(e)
	//			}
	//
	//		}
	//
	//	}
</script>