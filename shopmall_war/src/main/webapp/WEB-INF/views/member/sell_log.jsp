<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<section>
	<div class="container">
		<div class="row">
			<div class="col-sm-3">
				<div class="left-sidebar">
					<h2>마이페이지</h2>
					<div class="panel-group category-products" id="accordian">		
						<div class="panel panel-default">
							<div class="panel-heading">
								<h4 class="panel-title"><a href="/web/member/mypage">내 정보 수정</a></h4>
							</div>
						</div>
						<div class="panel panel-default">
							<div class="panel-heading">
								<h4 class="panel-title"><a href="/web/member/goSellLog/1">구매 내역</a></h4>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="col-sm-9 padding-right" style="text-align: center;"> <!-- 오른쪽 -->
				<h2 class="title text-center">구매 내역</h2>
				<div style="margin-bottom: 50px"><span>※구매 목록은 한페이지에 최대 10개 까지 표시됩니다.</span></div>
				<table id="sell_log_table" style="width: 95%; margin: auto;">
					<thead>
						<tr>
							<th style="text-align: center">번호</th>
							<th colspan="2" style="text-align: center;">타이틀</th>
							<th style="text-align: center;">수량</th>
							<th style="text-align: center;">가격</th>
							<th style="text-align: center;">구매일</th>
						</tr>
					</thead>
					<!-- for loop Ajax -->
					<tbody id="sell_log_tbody">
					</tbody>
				</table>
				<ul id="pagination" class="pagination">
					<!-- 페이지네이션 -->
				</ul>
			</div>
		</div>
	</div>
</section>
<script>
$(function() {
	var url = document.URL;
	var url_split = url.split('/');
	var page = url_split[6];
	var table_list = "";
	var date = "";
	var date_split = "";
	var front = 0;
	var back = 0;
	var pagination = "";
	
	$.getJSON('/web/member/sellLog/' + page, function(data) {
 		var page_size = data.pageSize;
		var group_size = data.groupSize;
		var tot_count = data.totCount;
		var tot_page = data.totPage;
		var pg_num = data.pgNum;
		var start_page = data.startPage;
		var end_page = data.endPage;
		
		console.log("페이지 사이즈 " + page_size);
		console.log("그룹 사이즈 " + group_size);
		console.log("리스트 총 개수 " + tot_count);
		console.log("총 페이지 수 " + tot_page);
		console.log("현재 페이지 " + pg_num);
		console.log("스타트 페이지 " + start_page);
		console.log("엔드 페이지 " + end_page);
		
		if(tot_count === 0) {
			table_list += 
				'<tr>'
			+	'<td colspan="5" style="font-size: 15px">구매 내역이 없습니다.</td>'
			+	'</tr>';					
		} else {
			$.each(data.list, function(i, item) {
				date = item.date;
				date_split = date.split(' ');
				
				table_list += 
					'<tr>'
				+		'<td>'+ item.seq +'</td>'
				+		'<td><img style="width: 100px; margin-right: 15px;" alt="" src="/web/resources/img/title/'+ item.image +'"/></td>'
				+		'<td>'+ item.title +'</td>'
				+		'<td>'+ item.count +'</td>'
				+		'<td>'+ priceComma(item.price * item.count) +'</td>'
				+		'<td>'+ date_split[0] +'</td>'
				+	'</tr>';
			});
		}
			
		if(pg_num % page_size == 0) {
			front = pg_num - page_size;
		} else {
			front = Math.floor((pg_num / page_size)) * page_size;
		}
		
		if(start_page != 1){
			pagination += '<li><a onClick="goSellLog(1)">《</a></li>'	//맨 앞으로
					    + '<li><a onClick="goSellLog('+ front +')">〈</a></li>';	//한 사이즈 앞으로
		}
		for(var i=start_page; i<=end_page; i++){
			pagination += '<li class="page'+ i +'"><a onClick="goSellLog('+ i +')">'+ i +'</a></li>';
		}
		
		if(pg_num == end_page) {
			back = pg_num + 1;
		} else {
			back = (((Math.floor(pg_num / page_size)) + 1) * page_size) + 1;
		}
		
		if(tot_page != end_page) {
			
		pagination += '<li><a onClick="goSellLog('+ back +')">〉</a></li>'	//한 사이즈 뒤로
				+	  '<li><a onClick="goSellLog('+ tot_page +')">》</a></li>';	//맨 뒤로
		}	
		
		$('#sell_log_tbody').html(table_list);
		$('#pagination').html(pagination);
		$('#pagination > .page'+ pg_num +'').addClass('active');	 
	});
});
</script>