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
				<h2 class="title text-center">문의 글 작성</h2>
				<form method="post">
					<p class="faq_title" style="float: left;">제목</p><input id="faq_one_title" type="text" placeholder="제목을 입력하세요" style="width: 100%; margin-bottom: 10px">
					<br>
					<p class="faq_title" style="float: left;">내용</p><textarea id="faq_one_article" style="background: white; margin-bottom: 10px" placeholder="내용을 입력하세요" rows="20" cols="10"></textarea>
					<input id="faq_one_submit" class="btn btn-default" style="margin-bottom: 10px; width: 100px; height: 40px;" type="button" value="작성하기">
				</form>
			</div>
		</div>
	</div>
</section>
<script type="text/javascript">
var url = document.URL;
var url_split = url.split('/');

$(function() {
	if(url_split[5] === 'updateFaq') {
		$.getJSON('/web/faq/selectOneSeq/1/' + url_split[6], function(data) {
			$.each(data.obj, function(i, item) {
				var temp = item.article;
				var article = temp.replace(/<br>/g, "\n");

				$('#faq_one_title').val(item.title);
				$('#faq_one_article').val(article);
			});
		});
	}
});

$('#faq_one_submit').click(function(){
	if(url_split[5] === 'updateFaq') {
		if($('#faq_one_title').val().length < 5 || $('#faq_one_title').val().length > 40 ) {
			alert("제목은 5자에서 40자 이내로 작성해주세요.");
		} else if($('#faq_one_article').val().length < 10) {
			alert("내용은 최소 10자 이상으로 작성해주세요.");
		} else {
			var faq_info = {
					title : $('#faq_one_title').val(),
					article : $('#faq_one_article').val().replace(/\n/g, "<br>"),
					seq : url_split[6]
						};
			
			$.ajax({
				url : '/web/faq/update',
				type : 'post',
				contentType : 'application/json',
				data : JSON.stringify(faq_info),
				dataType : 'json',
				success : function(data) {
					alert("문의글을 수정했습니다.");
					go_my_faq(1);
				},
				error : function(x, s, m) {
					alert("문의 수정하기 중 오류가 발생했습니다.");
				}
			});
		}
		
	} else {
		if($('#faq_one_title').val().length < 5 || $('#faq_one_title').val().length > 40 ) {
			alert("제목은 5자에서 40자 이내로 작성해주세요.");
		} else if($('#faq_one_article').val().length < 10) {
			alert("내용은 최소 10자 이상으로 작성해주세요.");
		} else {
	 		$.getJSON('/web/member/session', function(session){
				var faq_info = {
						'title' : $('#faq_one_title').val(),
						'article' : $('#faq_one_article').val().replace(/\n/g, "<br>"),
						'id' : session.id
				};
				
				$.ajax({
					url : '/web/faq/insertFaq',
					type : 'POST',
					contentType : 'application/json',
					data : JSON.stringify(faq_info),
					dataType : 'json',
					success : function(data) {
						alert("문의글이 작성되었습니다.");
						go_faq(1);
					},
					error : function(x, s, m) {
						alert("문의하기 중 오류가 발생했습니다.");
					}
				});
			}); 
		}
	}
});
</script>