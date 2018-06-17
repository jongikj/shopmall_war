<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<section>
	<div class="container">
		<div class="row">
			<div class="col-sm-3">
				<div class="left-sidebar">
					<h2>FAQ</h2>
					<div class="panel-group category-products" id="accordian">		
						<div class="panel panel-default">
							<div class="panel-heading">
								<h4 class="panel-title"><a onclick="go_faq(1)">문의 목록</a></h4>
							</div>
						</div>
						<div class="panel panel-default">
							<div class="panel-heading">
								<h4 class="panel-title"><a onclick="go_faq_one()">문의 글 작성</a></h4>
							</div>
						</div>
						<div class="panel panel-default">
							<div class="panel-heading">
								<h4 class="panel-title"><a onclick="go_my_faq(1)">내 문의 보기</a></h4>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="col-sm-9 padding-right" style="text-align: center;"> <!-- 오른쪽 -->
				<!-- FAQ div -->
				<h2 class="title text-center">문의 목록</h2>
				<form id="faq_search_form" style="text-align: right; padding-bottom: 10px" onsubmit="return false;">
					<span id="faq_serach_span" style="float: left"></span>
					<select id="faq_keyfield" style="width: 75px">
						<option value="title" selected="selected">제목</option>
						<option value="id">작성자</option>
					</select>
					<input id="faq_search" type="text" placeholder="검색하기" >
					<input id="faq_search_button" class="btn btn-default" value="검색" type="button" onclick="findFaq(1)">
				</form>
				<table class="faq_table table table-hover">
					<thead>
						<tr>
							<th style="text-align: center; width: 10%">번호</th>
							<th style="text-align: center; width: 55%">제목</th>
							<th style="text-align: center; width: 20%">작성자</th>	
							<th style="text-align: center; width: 15%">날짜</th>
						</tr>
					</thead>
					<tbody id="faq_tbody">
						<!-- 테이블 리스트 -->
					</tbody>
				</table>
				<ul id="pagination" class="pagination">
					<!-- 페이지네이션 -->
				</ul>
			</div>
		</div>
	</div>
</section>
<script type="text/javascript">
$(function(){
	var url = document.URL;
	var url_split = url.split('/');
	var page = url_split[6];
	var table_list = "";
	var date = "";
	var date_split = "";
	var front = 0;
	var back = 0;
	var pagination = "";
	
	switch(url_split[5]) {
		case 'goFaq' : 
			$.getJSON('/web/faq/selectAll/' + page, function(data){
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
					+	'<td colspan="4" style="font-size: 15px">등록된 문의가 없습니다.</td>'
					+	'</tr>';							
				} else {
					$.each(data.list, function(i, item) {
						date = item.date;
						date_split = date.split(' ');
						
						table_list += 
								'<tr>'
							+	'<td>'+ item.seq +'</td>'
							+	'<td><a onclick="goFaqArticle('+pg_num+', '+item.seq+')">'+ item.title +'</a></td>'
							+	'<td>'+ item.id +'</td>'
							+	'<td>'+ date_split[0] +'</td>'
							+	'</tr>';
					});
				}
					
				if(pg_num % page_size == 0) {
					front = pg_num - page_size;
				} else {
					front = Math.floor((pg_num / page_size)) * page_size;
				}
				
		//		if(pg_num - page_size > 0){
				if(start_page != 1){
					pagination += '<li><a onClick="go_faq(1)">《</a></li>'	//맨 앞으로
							    + '<li><a onClick="go_faq('+ front +')">〈</a></li>';	//한 사이즈 앞으로
				}
				for(var i=start_page; i<=end_page; i++){
					pagination += '<li class="page'+ i +'"><a onClick="go_faq('+ i +')">'+ i +'</a></li>';
				}
				
				if(pg_num == end_page) {
					back = pg_num + 1;
				} else {
					back = (((Math.floor(pg_num / page_size)) + 1) * page_size) + 1;
				}
				
				if(tot_page != end_page) {
				pagination += '<li><a onClick="go_faq('+ back +')">〉</a></li>'	//한 사이즈 뒤로
						+	  '<li><a onClick="go_faq('+ tot_page +')">》</a></li>';	//맨 뒤로
				}	
				
				$('#faq_tbody').html(table_list);
				$('#pagination').html(pagination);
				$('#pagination > .page'+ pg_num +'').addClass('active');
			});
			break;
			
		case 'goMyFaq' : 
			$('#faq_search_form').css('display', 'none');
			$.getJSON('/web/member/session', function(session){
				$.getJSON('/web/faq/selectAllId/' + session.id + '/' + page, function(data){
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
						+	'<td colspan="4" style="font-size: 15px">등록한 문의 내역이 없습니다.</td>'
						+	'</tr>';					
					} else {
						$.each(data.list, function(i, item) {
							date = item.date;
							date_split = date.split(' ');
							
							table_list += 
									'<tr>'
								+	'<td>'+ item.seq +'</td>'
								+	'<td><a onclick="goMyFaqArticle('+pg_num+', '+item.seq+')">'+ item.title +'</a></td>'
								+	'<td>'+ item.id +'</td>'
								+	'<td>'+ date_split[0] +'</td>'
								+	'</tr>';
						});
					}
						
					if(pg_num % page_size == 0) {
						front = pg_num - page_size;
					} else {
						front = Math.floor((pg_num / page_size)) * page_size;
					}
					
			//		if(pg_num - page_size > 0){
					if(start_page != 1){
						pagination += '<li><a onClick="go_my_faq(1)">《</a></li>'	//맨 앞으로
								    + '<li><a onClick="go_my_faq('+ front +')">〈</a></li>';	//한 사이즈 앞으로
					}
					for(var i=start_page; i<=end_page; i++){
						pagination += '<li class="page'+ i +'"><a onClick="go_my_faq('+ i +')">'+ i +'</a></li>';
					}
					
					if(pg_num == end_page) {
						back = pg_num + 1;
					} else {
						back = (((Math.floor(pg_num / page_size)) + 1) * page_size) + 1;
					}
					
					if(tot_page != end_page) {
						
					pagination += '<li><a onClick="go_my_faq('+ back +')">〉</a></li>'	//한 사이즈 뒤로
							+	  '<li><a onClick="go_my_faq('+ tot_page +')">》</a></li>';	//맨 뒤로
					}	
					
					$('#faq_tbody').html(table_list);
					$('#pagination').html(pagination);
					$('#pagination > .page'+ pg_num +'').addClass('active');
				});
			});
			break;
			
		case 'find' : 
			var find_page = url_split[8];
			if(url_split[6]  === 'title') {
				$.getJSON('/web/faq/findTitle/' + url_split[7] + '/' + find_page, function(data) {
					var page_size = data.pageSize;
					var group_size = data.groupSize;
					var tot_count = data.totCount;
					var tot_page = data.totPage;
					var pg_num = data.pgNum;
					var start_page = data.startPage;
					var end_page = data.endPage;
					var keyword = data.keyword;
					
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
						+	'<td colspan="4" style="font-size: 15px">등록한 문의 내역이 없습니다.</td>'
						+	'</tr>';					
					} else {
						$.each(data.list, function(i, item) {
							date = item.date;
							date_split = date.split(' ');
							
							table_list += 
									'<tr>'
								+	'<td>'+ item.seq +'</td>'
								+	'<td><a onclick="goFaqArticle('+pg_num+', '+item.seq+')">'+ item.title +'</a></td>'
								+	'<td>'+ item.id +'</td>'
								+	'<td>'+ date_split[0] +'</td>'
								+	'</tr>';
						});
					}
						
					if(pg_num % page_size == 0) {
						front = pg_num - page_size;
					} else {
						front = Math.floor((pg_num / page_size)) * page_size;
					}
					
			//		if(pg_num - page_size > 0){
					if(start_page != 1){
						pagination += '<li><a onClick="pageFindFaq(\''+ url_split[6] +'\', \''+ keyword +'\', 1)">《</a></li>'	//맨 앞으로
								    + '<li><a onClick="pageFindFaq(\''+ url_split[6] +'\', \''+ keyword +'\', '+ front +')">〈</a></li>';	//한 사이즈 앞으로
					}
					for(var i=start_page; i<=end_page; i++){
						pagination += '<li class="page'+ i +'"><a onClick="pageFindFaq(\''+ url_split[6] +'\', \''+ keyword +'\', '+ i +')">'+ i +'</a></li>';
					}
					
					if(pg_num == end_page) {
						back = pg_num + 1;
					} else {
						back = (((Math.floor(pg_num / page_size)) + 1) * page_size) + 1;
					}
					
					if(tot_page != end_page) {
						
					pagination += '<li><a onClick="pageFindFaq(\''+ url_split[6] +'\', \''+ keyword +'\','+ back +')">〉</a></li>'	//한 사이즈 뒤로
							+	  '<li><a onClick="pageFindFaq(\''+ url_split[6] +'\', \''+ keyword +'\','+ tot_page +')">》</a></li>';	//맨 뒤로
					}	
					
					$('#faq_tbody').html(table_list);
					$('#pagination').html(pagination);
					$('#pagination > .page'+ pg_num +'').addClass('active');	
					$('#faq_serach_span').text('\'' + keyword + '\' 제목 검색 결과 : 총 ' + tot_count + '건');	
				});
			} else {
				$.getJSON('/web/faq/selectAllId/' + url_split[7] + '/' + find_page, function(data) {
					var page_size = data.pageSize;
					var group_size = data.groupSize;
					var tot_count = data.totCount;
					var tot_page = data.totPage;
					var pg_num = data.pgNum;
					var start_page = data.startPage;
					var end_page = data.endPage;
					var keyword = data.keyword;
					
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
						+	'<td colspan="4" style="font-size: 15px">등록한 문의 내역이 없습니다.</td>'
						+	'</tr>';					
					} else {
						$.each(data.list, function(i, item) {
							date = item.date;
							date_split = date.split(' ');
							
							table_list += 
									'<tr>'
								+	'<td>'+ item.seq +'</td>'
								+	'<td><a onclick="goFaqArticle('+pg_num+', '+item.seq+')">'+ item.title +'</a></td>'
								+	'<td>'+ item.id +'</td>'
								+	'<td>'+ date_split[0] +'</td>'
								+	'</tr>';
						});
					}
						
					if(pg_num % page_size == 0) {
						front = pg_num - page_size;
					} else {
						front = Math.floor((pg_num / page_size)) * page_size;
					}
					
			//		if(pg_num - page_size > 0){
					if(start_page != 1){
						pagination += '<li><a onClick="pageFindFaq(\''+ url_split[6] +'\', \''+ keyword +'\', 1)">《</a></li>'	//맨 앞으로
								    + '<li><a onClick="pageFindFaq(\''+ url_split[6] +'\', \''+ keyword +'\', '+ front +')">〈</a></li>';	//한 사이즈 앞으로
					}
					for(var i=start_page; i<=end_page; i++){
						pagination += '<li class="page'+ i +'"><a onClick="pageFindFaq(\''+ url_split[6] +'\', \''+ keyword +'\', '+ i +')">'+ i +'</a></li>';
					}
					
					if(pg_num == end_page) {
						back = pg_num + 1;
					} else {
						back = (((Math.floor(pg_num / page_size)) + 1) * page_size) + 1;
					}
					
					if(tot_page != end_page) {
						
					pagination += '<li><a onClick="pageFindFaq(\''+ url_split[6] +'\', \''+ keyword +'\','+ back +')">〉</a></li>'	//한 사이즈 뒤로
							+	  '<li><a onClick="pageFindFaq(\''+ url_split[6] +'\', \''+ keyword +'\','+ tot_page +')">》</a></li>';	//맨 뒤로
					}	
					
					$('#faq_tbody').html(table_list);
					$('#pagination').html(pagination);
					$('#pagination > .page'+ pg_num +'').addClass('active');
					$('#faq_serach_span').text('\'' + keyword + '\' 작성자 검색 결과 : 총 ' + tot_count + '건');	
				});
			}
			break;
	}
}); 
</script>