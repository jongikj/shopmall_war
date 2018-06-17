<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<section>
	<div class="container">
		<div class="row">
			<div class="col-sm-3">
				<div class="left-sidebar">
					<h2>장르</h2>
					<div class="panel-group category-products" id="accordian">
					<!-- 장르 목록 -->
					</div>
				</div>
			</div>
			<div class="col-sm-9 padding-right">
				<div class="product-details"><!--product-details-->
					<div class="col-sm-5">
						<div id="detail_image" class="view-product" style="text-align: center;">
							<img src="/web/resources/img/title/${image}" alt="" />
						</div>
					</div>
					<div class="col-sm-7">
						<div id="detail" class="product-information"><!--/product-information-->
							<h3>${title}</h3>
							<span>
								<span id="shop_detail_price"></span>
								<c:set var="count" value="${count}"/>
								<c:choose>
								<c:when test="${count eq 0}">
									<h2 style="margin-top: 50px;"><i class="glyphicon glyphicon-remove"></i><b> 품절되었습니다!</b></h2>
								</c:when>
								<c:otherwise>
									<input id="detail_count" type="text" value="1" />
									<button id="detail_buy" type="button" class="btn btn-fefault cart">
										<i class="fa fa-shopping-cart"></i>
										구매하기
									</button>
								</c:otherwise>
								</c:choose>
							</span>
							<p><b>장르:</b> ${genre}</p>
							<p><b>남은 수량:</b> ${count}</p>
							<button id="add_wishlist" style="background: #FE980F; color: white; border-radius: 0;" class="btn">
								<i class="glyphicon glyphicon-star"></i> 위시리스트에 담기
							</button>
						</div><!--/product-information-->
					</div>
				</div><!--/product-details-->
				
				<div class="category-tab shop-details-tab"><!--category-tab-->
					<div class="col-sm-12">
						<ul class="nav nav-tabs">
							<li class="active"><a href="#details" data-toggle="tab">설명</a></li>
						</ul>
						<div class="tab-pane fade active in" id="reviews" > <!-- 여기 -->
							<!-- Slideshow container -->
 							<div id="myCarousel" class="carousel slide" data-ride="carousel" style="margin-bottom: 30px">
								<!-- 이미지 슬라이드 -->
							</div>							
							<div id="detail_detail" class="col-sm-12"><!-- 여기까지 -->
								<p style="font-size: 17px">
								${detail}
								</p>
							</div>
						</div>
					</div>
				</div>
			</div><!--/category-tab-->
		</div>
	</div>
</section>
<script>
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
	var detail_image = '';
	
	$.getJSON('/web/shop/countImage/${seq}', function(data){
		if(data.count == 0){
			$('#myCarousel').html("<span><b>본 상품은 이미지가 없습니다.</b></span><br><br>");
		} else {
			$.getJSON('/web/shop/selectDetailImage/${seq}', function(data2){
				detail_image += '<div class="carousel-inner">';
				
				$.each(data2.list, function(j,  selectDetailImage){
					if(selectDetailImage.image_url.split(':')[0] === 'http' || selectDetailImage.image_url.split(':')[0] === 'https') {
						detail_image += 
						    '<div class="item slide_image' + j + '">'
	+					      '<img src="' + selectDetailImage.image_url + '">'
	+						'</div>';
					} else {
						detail_image += 
						    '<div class="item slide_image' + j + '">'
	+					      '<img src="/web/resources/img/detail/' + selectDetailImage.image_url + '">'
	+						'</div>';	
					}
				});
				
				detail_image +=
			 	'</div>'
+				  '<a class="left carousel-control" href="#myCarousel" data-slide="prev">'
+				    '<span class="glyphicon glyphicon-chevron-left"></span>'
+			   		'<span class="sr-only">Previous</span>'
+				  '</a>'
+				  '<a class="right carousel-control" href="#myCarousel" data-slide="next">'
+				    '<span class="glyphicon glyphicon-chevron-right"></span>'
+				    '<span class="sr-only">Next</span>'
+			  	  '</a>';

				$('#myCarousel').html(detail_image);
				$('.slide_image0').addClass('active'); 
			});
		}
	});
	$('#shop_detail_price').text('￦' + priceComma(${price}));
});

$('#detail_buy').click(function() {
	addBuy(${seq}, $('#detail_count').val());
	location.href = '/web/shop/buy';
});

$('#add_wishlist').click(function() {
	$.ajax({
		url : '/web/member/session',
		async : false,
		success : function(session) {
			if(session.id == null) {
				alert('로그인을 해주세요.');
			} else {
				$.ajax({
					url : '/web/shop/selectWishOne',
					async : false,
					type : 'post',
					data : {
						seq : ${seq},
						id : session.id
					},
					success : function(wish) {
						if(wish.seq_sell_list === undefined) {
							$.ajax({
								url : '/web/shop/addWishlist',
								async : false,
								type : 'post',
								data : {
									seq : ${seq},
									id : session.id	
								},
								success : function() {
									alert('위시리스트에 추가되었습니다.');
								},
								error : function() {
									alert('위시리스트 추가 중 에러 발생');
								}
							});
						} else {
							alert('이미 위시리스트에 있는 상품입니다.');
						}
					},
					error : function() {
						alert('위시리스트 중복 체크중 에러 발생');
					}
				});	
			}
		},
		error : function() {
			alert('세션 읽는중 에러 발생');
		}
	});
});
</script>