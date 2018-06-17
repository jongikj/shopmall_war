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
				<table id="faq_article_table" class="table table-hover">
					<thead>
						<tr>
							<th style="text-align: center; width: 10%">번호</th>
							<th style="text-align: center; width: 55%">제목</th>
							<th style="text-align: center; width: 20%">작성자</th>	
							<th style="text-align: center; width: 15%">날짜</th>
						</tr>
						<tr style="background-color: ghostwhite;">
							<td id="faq_article_seq"></td>
							<td id="faq_article_title"></td>
							<td id="faq_article_id"></td>
							<td id="faq_article_date"></td>
						</tr>
					</thead>
				</table>
				<div id="faq_article_div">
				</div>
				<div style="border-top: solid 2px #ddd; padding: 10px 10px 10px 10px;">
					<div style="float: left;">
						<ul id="faq_article_nb" style="text-align: left;">
						</ul>
					</div>
					<div style="float: right;">
						<input id="faq_article_go_list" class="btn btn-default" type="button" value="목록">
						<input id="faq_article_update" class="btn btn-default" type="button" value="수정">
						<input id="faq_article_delete" class="btn btn-default" type="button" value="삭제">
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
<script>
$(function() {
	var url = document.URL;
	var url_split = url.split('/');
	var token = url_split[5];
	var page = url_split[6];
	var seq = url_split[7];
	var nb = "";
	
	$.getJSON('/web/faq/selectOneSeq/' + page + '/' + seq, function(data) {
		$.each(data.obj, function(i, item) {
			var date = item.date.split(' ');
			
			$('#faq_article_seq').html(item.seq);
			$('#faq_article_title').html(item.title);
			$('#faq_article_id').html(item.id);
			$('#faq_article_date').html(date[0]);
			$('#faq_article_div').html(item.article);
		});
	});
	
	if(token === 'faqArticle') {
		$.ajax({
			url : '/web/faq/nextSelectSeq/' + seq,
			success : function(next) {
				if(next.seq !== undefined) {
		 			nb += '<li><i class="glyphicon glyphicon-arrow-up"></i>다음 글 : <a onclick="goFaqArticle('+ page +', '+ next.seq +')">'+ next.title +'</a></li>';
					$('#faq_article_nb').append(nb); 
				}
				
				$.ajax({
					url : '/web/faq/beforeSelectSeq/' + seq,
					success : function(before) {
						if(before.seq !== undefined) {
				 			nb += '<li><i class="glyphicon glyphicon-arrow-down"></i>이전 글 : <a onclick="goFaqArticle('+ page +', '+ before.seq +')">'+ before.title +'</a></li>';
							$('#faq_article_nb').html(nb); 
						}
					},
					error : function(x, s, m) {
						alert('이전 글 읽어오는 중 에러 발생');
					}
				});
			},
			error : function(x, s, m) {
				alert('다음 글 읽어오는 중 에러 발생');
			}
		});
	} else {
		$.getJSON('/web/member/session', function(session) {
			$.ajax({
				url : '/web/faq/myNextSelectSeq/' + seq + '/' + session.id,
				success : function(next) {
					if(next.seq !== undefined) {
			 			nb += '<li><i class="glyphicon glyphicon-arrow-up"></i>다음 글 : <a onclick="goMyFaqArticle('+ page +', '+ next.seq +')">'+ next.title +'</a></li>';
						$('#faq_article_nb').append(nb); 
					}
					
					$.ajax({
						url : '/web/faq/myBeforeSelectSeq/' + seq + '/' + session.id,
						success : function(before) {
							if(before.seq !== undefined) {
					 			nb += '<li><i class="glyphicon glyphicon-arrow-down"></i>이전 글 : <a onclick="goMyFaqArticle('+ page +', '+ before.seq +')">'+ before.title +'</a></li>';
								$('#faq_article_nb').html(nb); 
							}
						},
						error : function(x, s, m) {
							alert('이전 글 읽어오는 중 에러 발생');
						}
					});
				},
				error : function(x, s, m) {
					alert('다음 글 읽어오는 중 에러 발생');
				}
			});
		});
	}
	
	$('#faq_article_go_list').click(function() {
		if(token === "faqArticle") {
			go_faq(page);
		} else {
			go_my_faq(page);
		}
	});
	
	$('#faq_article_update').click(function() {
		$.getJSON('/web/faq/selectOneSeq/' + page + '/' + seq, function(selectData) {
			$.each(selectData.obj, function(i, item) {
				$.ajax({
					url : '/web/member/session',
					success : function(session) {
						if(item.id == session.id) {
							goFaqUpdate(item.seq, item.title, item.article);
						} else {
							alert('수정 권한이 없습니다.');
						}
					},
					error : function(x, s, m) {
						alert("에러 발생");
					}
				});
			});
		});
	});
	
	$('#faq_article_delete').click(function() {
		$.getJSON('/web/faq/selectOneSeq/' + page + '/' + seq, function(selectData) {
			$.each(selectData.obj, function(i, item) {
				$.ajax({
					url : '/web/member/session',
					success : function(session) {
						if(item.id == session.id) {
							var delConfirm = confirm('글을 삭제하시겠습니까?');
							
							if(delConfirm) {
								$.ajax({
									url : '/web/faq/delete',
									data : {seq : item.seq},
									success : function(data) {
										alert('글을 삭제했습니다.');
										go_faq(1);
									},
									error : function(x, s, m) {
										alert('글 삭제중 에러발생');
									}
								});
							}

						} else {
							alert('삭제 권한이 없습니다.');
						}
					},
					error : function(x, s, m) {
						alert("에러 발생");
					}
				});
			});
		});
	});
	
});
</script>