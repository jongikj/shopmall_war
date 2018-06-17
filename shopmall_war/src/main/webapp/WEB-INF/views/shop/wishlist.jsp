<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<section>
	<div class="container">
		<div class="row">
			<div id="wishlist_div">
				<h2 class="title text-center">위시리스트</h2>
				<table id="wishlist_table"style="width: 90%; margin-left: auto; margin-right: auto; table-layout: fixed;">
					<thead>
						<tr style="border-bottom: 1px solid #F0F0E9; height: 30px">
							<th colspan="2" style="text-align: center">타이틀</th>
							<th style="text-align: center;">가격</th>
							<th style="width: 20px;"></th>
						</tr>
					</thead>
					<tbody id="wishlist_buy_tbody">
						<!-- 위시리스트 목록 -->
					</tbody>
					<tfoot>
						<tr style="height: 50px; border-top: 1px solid #F0F0E9;">
							<td colspan="4"></td>
						</tr>
					</tfoot>
				</table>
			</div>
			<div id="wishlist_info" style="text-align: center; padding-top: 30px;">
				<span>* 위시리스트는 계정별로 서버에 저장됩니다.</span>
			</div>
			<div style="text-align: center; padding: 40px">
 				<input id="wishlist_buy_button" class="btn btn-default" style="width: 120px; height: 50px; font-size: 17px;" type="button" value="구매하기"/>
			</div>
		</div>
	</div>
</section>
<script src="/web/resources/js/main.js"></script>
<script>
$(function() {
	var wish_list = '';
	var seq_arr = new Array();
	
	$.ajax({
		url : '/web/member/session',
		async : false,
		success : function(session) {
			$.getJSON('/web/shop/selectWishAll/' + session.id, function(wish) {
				if(wish.size == 0) {
					wish_list +=
						'<tr style="text-align: center">'
					+		'<td colspan="4" style="padding: 50px;"><span style="font-size: 25px; color: gray; font-family: Roboto, sans-serif; font-weight: 700">위시리스트 목록이 없습니다.</span></td>'
					+	'</tr>';
					
					$('#wishlist_buy_button').css('display', 'none');
				} else {
					$.each(wish.list, function(i, item) {
						wish_list += 
							'<tr style="text-align: center">'
						+		'<td><img style="height: 100px;" src="/web/resources/img/title/'+item.image+'" alt="'+item.title+'"></td>'
						+		'<td id="title'+i+'" style="text-align: left;">'+item.title+'<input type="hidden" id="seq'+item.seq+'" value="'+item.seq+'"></td>'
						+		'<td><span id="price'+i+'">'+priceComma(item.price)+'</span></td>'
						+		'<td><i class="count glyphicon glyphicon-remove" onclick="removeWish(\''+ session.id +'\', '+item.seq+')"></i></td>'
						+	'</tr>';
						
						seq_arr[i] = item.seq;
					});
				}
				$('#wishlist_buy_tbody').html(wish_list);
			});
		},
		error : function() {
			alert('위시리스트 세션 읽는 중 오류 발생');
		}
	});
	
	$('#wishlist_buy_button').click(function() {
		for(i=0; i<=seq_arr.length-1; i++) {
			addBuy(seq_arr[i], 1);
		}
		location.href = '/web/shop/buy';
	});
});
</script>