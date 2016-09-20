<link rel="stylesheet" href="btHeader.css?__inline">

<div id="btHeader" v-cloak>

	<section>
		<div v-for="name in names" v-cloak style="display:inline-block;margin-right:4px;" @tap="tabTap($index+1)" class="c_big_bt c_green" :class="[tab==$index+1?'bg_sel':'']">
			<label>[[name]]</label>
		</div>
		
	</section>
	<hr class="c_border">
</div>

<script>

</script>