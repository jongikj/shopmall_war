<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<section id="slider">
	<div class="container" style="width: 100%;">
		<div class="row">
			<div class="col-sm-12">
				<div id="slider-carousel" class="carousel slide"
					data-ride="carousel">
					<ol class="carousel-indicators">
						<li data-target="#slider-carousel" data-slide-to="0"
							class="active"></li>
						<li data-target="#slider-carousel" data-slide-to="1"></li>
						<li data-target="#slider-carousel" data-slide-to="2"></li>
					</ol>
					<div class="carousel-inner">
						<div class="item active">
							<div class="col-sm-6">
								<img src="/web/resources/img/home/banner1.jpg">
							</div>
						</div>
						<div class="item">
							<div class="col-sm-6">
								<img src="/web/resources/img/home/banner2.jpg">
							</div>
						</div>
						<div class="item">
							<div class="col-sm-6">
								<img src="/web/resources/img/home/banner3.jpg">
							</div>
						</div>
					</div>
					<a href="#slider-carousel" class="left control-carousel hidden-xs"
						data-slide="prev"> <i class="fa fa-angle-left"></i>
					</a> <a href="#slider-carousel"
						class="right control-carousel hidden-xs" data-slide="next"> <i
						class="fa fa-angle-right"></i>
					</a>
				</div>
			</div>
		</div>
	</div>
</section>
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
			<div class="col-sm-9 padding-right">
				<div class="features_items">
					<h2 class="title text-center">최신 상품</h2>
					<!--최신 게임  목록-->
					<div id='home_new_title'>
					</div>
				<div class="category-tab">
					<!--category-tab-->
					<div id="home_category" class="col-sm-12">
					<!-- 카테고리 장르 -->
					</div>
					<div id="home_category_title" class="tab-content">
					<!-- 카테고리 장르별 타이틀 -->
					</div>
				</div>
				<!--/category-tab-->
				</div>
			</div>
		</div>
	</div>
</section>
<script src="/web/resources/js/main.js"></script>
<script type="text/javascript">
$(function(){
	var sell_list = '';
	
	$('#header').css('position', 'relative');
	$('#pub_article').css('top', '-166px');
	$('#header').css('z-index', '1');
	$('#pub_article').css('position', 'relative');
	
	$.getJSON('/web/shop/selectDesc', function(data){
	 	$.each(data.list, function(i, selectDesc){
	 		if(selectDesc.count == 0) {
		 		sell_list +=
					'<div class="col-sm-4">'
			+			'<div class="product-image-wrapper">'
			+				'<div>'
			+					'<div class="productinfo text-center">'
			+						'<a href="/web/shop/selectOneSeq/' + selectDesc.seq + '"><img src="resources/img/title/' + selectDesc.image + '" alt="" /></a>'
			+						'<h2>￦' + priceComma(selectDesc.price) + '</h2>'
			+						'<p><a href="/web/shop/selectOneSeq/' + selectDesc.seq + '" style="color: #696763;">' + selectDesc.title + '</a></p>'
			+						'<a style="cursor: default;" class="btn btn-default add-to-cart"><i class="glyphicon glyphicon-remove"></i>품절</a>'
			+					'</div>'
			+				'</div>'
			+				'<div class="choose">'
			+					'<ul class="nav nav-pills nav-justified">'
			+						'<li><a onclick="addWishlist('+selectDesc.seq+')"><i class="fa fa-plus-square"></i>위시리스트에 담기</a></li>'
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
			+						'<a href="/web/shop/selectOneSeq/' + selectDesc.seq + '"><img src="resources/img/title/' + selectDesc.image + '" alt="" /></a>'
			+						'<h2>￦' + priceComma(selectDesc.price) + '</h2>'
			+						'<p><a href="/web/shop/selectOneSeq/' + selectDesc.seq + '" style="color: #696763;">' + selectDesc.title + '</a></p>'
			+						'<a onclick="addBuy('+ selectDesc.seq +', 1)" href="/web/shop/buy" class="btn btn-default add-to-cart"><i class="fa fa-shopping-cart"></i>구매하기</a>'
			+					'</div>'
			+				'</div>'
			+				'<div class="choose">'
			+					'<ul class="nav nav-pills nav-justified">'
			+						'<li><a onclick="addWishlist('+selectDesc.seq+')"><i class="fa fa-plus-square"></i>위시리스트에 담기</a></li>'
			+					'</ul>'
			+				'</div>'
			+			'</div>'
			+		'</div>'; 
	 		}
		});
		$('#home_new_title').html(sell_list); 
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

$(function(){
	var category_list = '';
	var category_title_list = '';
	
	$.getJSON('/web/shop/selectGenre', function(data){
		category_list += '<ul id="home_category_ul" class="nav nav-tabs">';
		
		$.each(data.list, function(i, selectGenre){
			category_list += '<li><a href="#'+selectGenre.genre_eng+'" data-toggle="tab">'+ selectGenre.genre +'</a></li>';
			category_title_list += '<div class="tab-pane fade" id="'+selectGenre.genre_eng+'">';
			
			$.ajax({
				url : '/web/shop/selectSearchAll/genre_eng/' + selectGenre.genre_eng,
				type : 'GET',
				async : false,
				success : function(data2){
					$.each(data2.list, function(i, titleList){
						category_title_list +=
							'<div class="col-sm-3">'
			+					'<div class="product-image-wrapper">'
			+						'<div class="single-products">'
			+							'<div class="productinfo text-center">'
			+								'<a href="/web/shop/selectOneSeq/'+titleList.seq+'"><img src="resources/img/title/'+titleList.image+'" alt="" /></a>'
			+								'<h2>￦'+priceComma(titleList.price)+'</h2>'
			+								'<p>'+titleList.title+'</p>'
			+								'<a onclick="addBuy('+ titleList.seq +', 1)" href="/web/shop/buy" class="btn btn-default add-to-cart"><i class="fa fa-shopping-cart"></i>구매하기</a>'
			+							'</div>'
			+						'</div>'
			+					'</div>'
			+				'</div>';
					});
					category_title_list += '</div>'; //장르 넘김
				},
				error : function(x, s, m){
					alert("실패");
				}
			});
		});
		category_list += '</ul>';
		$('#home_category').html(category_list);
		$('#home_category_ul > li:nth-child(1)').addClass('active');
		$('#home_category_title').html(category_title_list);
		$('#home_category_title > div:nth-child(1)').addClass('active in');
	});
});
</script>