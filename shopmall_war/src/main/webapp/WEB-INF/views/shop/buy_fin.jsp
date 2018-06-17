<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<section>
	<div class="container">
		<div class="row">
			<div id="shop_buy_list">
				<h2 class="title text-center">구매 완료</h2>
				<table id="buy_table"style="width: 90%; margin-left: auto; margin-right: auto; table-layout: fixed;">
					<thead>
						<tr style="border-bottom: 1px solid #F0F0E9; height: 30px">
							<th colspan="2" style="text-align: center">타이틀</th>
							<th style="text-align: center;">수량</th>
							<th style="text-align: center;">가격</th>
						</tr>
					</thead>
					<tbody id="shop_buy_tbody">
						<c:forEach var="item" items="${result}" varStatus="status" begin="0" end="${fn:length(result)-2}">
							<tr style="text-align: center">
								<td><img id="img${status.index}" style="height: 100px;"></td>
								<td id="title${status.index}" style="text-align: left;"></td>
								<td id="count${status.index}"></td>
								<td><span id="price${status.index}"></span></td>
							</tr>
						</c:forEach>
					</tbody>
					<tfoot>
						<tr style="height: 50px; border-top: 1px solid #F0F0E9;">
							<td colspan="3" style="text-align: right;"><span style="font-size: 25px; color: #FE980F; font-family: 'Roboto', sans-serif; font-weight: 700">합계 금액 : </span></td>
							<td style="text-align: center;"><span id="shop_buy_price" style="font-size: 25px; font-family: 'Roboto', sans-serif; font-weight: 700"><c:out value="${result.total_price}"/>원</span></td>
						</tr>
					</tfoot>
				</table>
			</div>
			<div id="buy_info" style="text-align: center; padding: 60px;">
				<span style="font-size: 28px">이용해주셔서 감사합니다!</span><br>
				<span>* 구매내역은 서버에 저장됩니다.</span><br>				
				<input style="margin: 20px;" class="btn btn-default" type="button" value="홈으로" onclick="location.href='/web'">
			</div>
		</div>
	</div>
</section>
<script src="/web/resources/js/main.js"></script>
<script type="text/javascript">
$(function() {
	var arr = new Array();
	var split_arr = new Array();
	var temp_str = "";
	var swap_arr = new Array();
	var swap = "";
	var flag = 0;
	
	<c:forEach var="list" items="${result}">
		arr.push("${list}");
	</c:forEach>
	
	for(i=0; i<=arr.length-1; i++) {
		swap_arr = arr[i].split('=');
		
		if(swap_arr[0] === 'total_price') {
			swap = arr[arr.length-1];
			arr[arr.length-1] = arr[i];
			arr[i] = swap;
		}
	}
	
	var temp = new Array(arr.length-1);
	
	for(i=0; i<=arr.length-2; i++) { 
		split_arr = arr[i].split('|');
		flag = split_arr[4];
			
		if(i != flag) {	
			temp[flag] = arr[i];
			swap = arr[i];
			
		} else {
			temp[i] = arr[i];
		}
	}
	
	for(i=0; i<=temp.length-1; i++) {
		arr[i] = temp[i];
	}
	
	for(i=0; i<=arr.length-2; i++) {
		arr[i] = arr[i].replace(/item(?:[0-9]+)=/g, '');
		split_arr = arr[i].split('|');
		
		$('#title' + i).text(split_arr[0]);
		$('#count' + i).text(split_arr[1]);
		$('#price' + i).text(priceComma(split_arr[2]));
		$('#img' + i).attr('src', "/web/resources/img/title/" + split_arr[3]);
	}
});
</script>