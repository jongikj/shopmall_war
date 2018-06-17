<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<section>
	<div class="container">
		<div class="row">
			<div class="col-sm-3">
				<div class="left-sidebar">
					<h2>장르</h2>
					<div class="panel-group category-products" id="accordian">
						<!--장르 목록-->
					</div>
				</div>
			</div>

			<div class="col-sm-9 padding-right" style="text-align: center;">
				<div class="features_items">
					<h2 id="shop_genre" class="title text-center">${genre}</h2>
					<!--상품  목록-->
					<div id='shop_sell_list'>
					</div>
				</div>
				<div id="pagination">
<!-- 				<ul class="pagination">
						<li class="active"><a href="">1</a></li>
						<li><a href="">2</a></li>
						<li><a href="">3</a></li>
						<li><a href="">»</a></li>
					</ul> -->
				</div>
			</div>
		</div>
	</div>
</section>
<script type="text/javascript">
 $(function(){
	var url = document.URL;
	var url_split = url.split('/');
	var sell_list = "";
	var pagination = "";
	var genre = url_split[6];
	var page = url_split[7];
	var front = 0;
	var back = 0;
	
	$.getJSON('/web/shop/genre/'+ genre +'/' + page, function(data){
		var startPage = data.startPage;
		var endPage = data.endPage;
		var pageSize = data.pageSize;
		var groupSize = data.groupSize;
		var totPage =  data.totPage;
		var pgNum = data.pgNum;
		
		console.log('총 리스트 수 : ' + data.totCount);
		console.log('스타트 페이지  : ' + startPage);
		console.log('엔드 페이지  : ' + endPage);
		console.log('페이지 사이즈 : ' + pageSize);
		console.log('그륩 사이즈 : ' + groupSize);
		console.log('총 페이지 수  : ' + totPage);
		console.log('현재 페이지  : ' + pgNum);
		$.each(data.list, function(i, item){
			if(item.count == 0) {
		 		sell_list +=
					'<div class="col-sm-4">'
			+			'<div class="product-image-wrapper">'
			+				'<div>'
			+					'<div class="productinfo text-center">'
			+						'<a href="/web/shop/selectOneSeq/' + item.seq + '"><img src="/web/resources/img/title/' + item.image + '" alt="'+item.image+'" /></a>'
			+						'<h2>￦' + priceComma(item.price) + '</h2>'
			+						'<p><a href="/web/shop/selectOneSeq/' + item.seq + '" style="color: #696763;">' + item.title + '</a></p>'
			+						'<a style="cursor: default;" class="btn btn-default add-to-cart"><i class="glyphicon glyphicon-remove"></i>품절</a>'
			+					'</div>'
			+				'</div>'
			+				'<div class="choose">'
			+					'<ul class="nav nav-pills nav-justified">'
			+						'<li><a onclick="addWishlist('+item.seq+')"><i class="fa fa-plus-square"></i>위시리스트에 담기</a></li>'
			+					'</ul>'
			+				'</div>'
			+			'</div>'
			+		'</div>'; 
			} else {
		 		sell_list +=
					'<div class="col-sm-4">'
			+			'<div class="product-image-wrapper">'
			+				'<div>'
			+					'<div class="productinfo text-center">'
			+						'<a href="/web/shop/selectOneSeq/' + item.seq + '"><img src="/web/resources/img/title/' + item.image + '" alt="'+item.image+'" /></a>'
			+						'<h2>￦' + priceComma(item.price) + '</h2>'
			+						'<p><a href="/web/shop/selectOneSeq/' + item.seq + '" style="color: #696763;">' + item.title + '</a></p>'
			+						'<a onclick="addBuy('+ item.seq +', 1)" href="/web/shop/buy"' + item.seq + '" class="btn btn-default add-to-cart"><i class="fa fa-shopping-cart"></i>구매하기</a>'
			+					'</div>'
			+				'</div>'
			+				'<div class="choose">'
			+					'<ul class="nav nav-pills nav-justified">'
			+						'<li><a onclick="addWishlist('+item.seq+')"><i class="fa fa-plus-square"></i>위시리스트에 담기</a></li>'
			+					'</ul>'
			+				'</div>'
			+			'</div>'
			+		'</div>'; 	
			}
		});
		
		pagination += '<ul class="pagination">';
		
		if(pgNum % pageSize == 0) {
			front = pgNum - pageSize;
		} else {
			front = Math.floor((pgNum / pageSize)) * pageSize;
		}
		
		if(startPage != 1){
			pagination += '<li><a onClick="go_genre(\'' + genre + '\', 1)">《</a></li>'	//맨 앞으로
					    + '<li><a onClick="go_genre(\'' + genre + '\', '+ front +')">〈</a></li>';	//한 사이즈 앞으로
		}
					
		for(var i=startPage; i<=endPage; i++){
			pagination += '<li class="page'+ i +'"><a onClick="go_genre(\'' + genre + '\', '+ i +')">'+ i +'</a></li>';
		}
		
		if(pgNum == endPage) {
			back = pgNum + 1;
		} else {
			back = (((Math.floor(pgNum / pageSize)) + 1) * pageSize) + 1;
		}
		
		if(totPage != endPage) {
		pagination += '<li><a onClick="go_genre(\'' + genre + '\', '+ back +')">〉</a></li>'	//한 사이즈 뒤로
				+	  '<li><a onClick="go_genre(\'' + genre + '\', '+ totPage +')">》</a></li>';	//맨 뒤로
		}
		
		pagination += '</ul>';
		
		$('#shop_sell_list').html(sell_list); 	
		$('#pagination').html(pagination);
		$('#pagination > ul > .page'+ pgNum +'').addClass('active');
	});
}); 

 $(function(){
		var genre_list = '';
		
		$.getJSON('/web/shop/selectGenre', function(data){
			$.each(data.list, function(i, selectGenre){
				genre_list +=
					'<div class="panel panel-default">'
		+			'<div class="panel-heading">'
		+				'<h4 class="panel-title">'
		+					'<a onClick="go_genre(\'' + selectGenre.genre_eng + '\', 1)">' + selectGenre.genre + '</a>'
		+				'</h4>'
		+			'</div>'
		+			'</div>';
			});
			$('#accordian').html(genre_list);

		});
	});
</script>