<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<section>
	<div class="container">
		<div class="row" style="text-align: center;">
			<h2 class="title text-center">관리자 모드</h2>
			<div id="admin_div">						
				<table class="admin_table" style="width: 80%; margin-left: auto; margin-right: auto; table-layout: fixed;">
					<tr>
						<td class="admin_table_desc"><span style="color: red;">*</span>타이틀 명</td>
						<td class="admin_table_input"><input id="admin_title" class="form-control" style="width: 80%;" type="text" maxlength="40" placeholder="타이틀명 (40자 이내)"></td>
					</tr>
					<tr>
						<td class="admin_table_desc"><span style="color: red;">*</span>수량</td>
						<td class="admin_table_input"><input id="admin_count" class="form-control" style="width: 25%;" type="text"></td>
					</tr>
					<tr>
						<td class="admin_table_desc"><span style="color: red;">*</span>가격</td>
						<td class="admin_table_input"><input id="admin_price" class="form-control" style="width: 40%;" type="text"></td>
					</tr>
					<tr>
						<td class="admin_table_desc"><span style="color: red;">*</span>장르</td>
						<td class="admin_table_input"><input id="admin_genre_kor" class="form-control" style="width: 55%;" type="text" placeholder="장르 (10자 이내)"></td>
					</tr>
					<tr>
						<td class="admin_table_desc"><span style="color: red;">*</span>장르(영문)</td>
						<td class="admin_table_input"><input id="admin_genre_eng" class="form-control" style="width: 55%;" type="text" placeholder="장르 영문 (20자 이내)"></td>
					</tr>
					<tr>
						<td class="admin_table_desc"><span style="color: red;">*</span>타이틀 이미지</td>
						<td class="admin_table_input"><input id="admin_title_img" class="form-control" class="btn btn-default" type="file"></td>
						<td class="admin_table_input" style="text-align: left;"><input id="admin_title_radio_file" name="title" style="float: none;" type="radio" value="file" checked="checked">파일<input name="title" style="float: none; margin-left: 10px;" type="radio" value="url">url</td>
					</tr>
					<tr id="image_tr1">
						<td class="admin_table_desc"><input id="add_image" class="btn btn-default" style="margin-right: 5px;" type="button" value="+">상세 이미지</td>
						<td class="admin_table_input"><input id="admin_image1" class="form-control" class="btn btn-default" type="file"></td>
						<td class="admin_table_input" style="text-align: left;"><input name="img1" style="float: none;" type="radio" value="file" onclick="change_file(1)" checked="checked">파일<input name="img1" style="float: none; margin-left: 10px;" type="radio" value="url" onclick="change_url(1)">url</td>
					</tr>
					<tr>
						<td class="admin_table_desc"><span style="color: red;">*</span>상세 설명</td>
						<td class="admin_table_input"><textarea id="admin_detail" class="form-control" rows="4" cols="10" style="resize: auto;"></textarea></td>
					</tr>
				</table>
				<span style="color: red;">*</span> 표시는 필수입력 사항입니다.<br>
				<input id="admin_title_regist" class="btn btn-default" style="width: 100px; height: 50px; margin-top: 50px; margin-bottom: 50px;" type="button" value="등록하기">
			</div>
		</div>
	</div>
</section>
<script>
$(function() {
	var regNumber = /^[0-9]*$/;
	var regEng = /[a-zA-Z]/;
	var temp = 2;
	var seq;
	var title_image_flag = 'file';
	var title_image;
	
/* 	$.getJSON('/web/admin/ipCheck', function(data) {
		if(data.flag === 0) {
			alert('권한이 없습니다.');
			location.href="/web/"
		}
	}); */
	
	$('input:radio[name=title]:radio[value=file]').click(function() {
		$('#admin_title_img').attr('type', 'file');
		title_image_flag = 'file';
	});
	
	$('input:radio[name=title]:radio[value=url]').click(function() {
		$('#admin_title_img').attr('type', 'text');
		$('#admin_title_img').attr('placeholder', '예) http://www.naver.com/image1');
		title_image_flag = 'url';
	});
	
	$('#add_image').click(function() {
		$('#image_tr1').after(
				'<tr id="image_tr'+temp+'">'
				+	'<td><input id="remove_image" type="button" class="btn btn-default remove_image'+temp+'" style="float: right;" value="-" onclick="remove_image('+temp+')"></td>'
				+	'<td class="admin_table_input"><input id="admin_image'+temp+'" class="form-control" class="btn btn-default" type="file"></td>'
				+	'<td class="admin_table_input" style="text-align: left;"><input name="img'+temp+'" style="float: none;" type="radio" value="file" onclick="change_file('+temp+')" checked="checked">파일<input name="img'+temp+'" style="float: none; margin-left: 10px;" type="radio" value="url" onclick="change_url('+temp+')">url</td>'
				+'</tr>');
		temp++
	});

	$('#admin_title_regist').click(function() {
		if($('#admin_title').val() == "" || $('#admin_count').val() == "" || $('#admin_price').val() == "" || $('#admin_genre_kor').val() == "" || 
				$('#admin_genre_eng').val() == "" || $('#admin_title_img').val() == "" || $('#admin_detail').val() == "") {
			alert('필수사항을 전부 입력해주세요.');
		} else {
			if(!regNumber.test($('#admin_count').val())) {
				alert('수량은 숫자만 입력해주세요.');
			} else if(!regNumber.test($('#admin_price').val())) {
				alert('가격은 숫자만 입력해주세요.');
			} else if(!regEng.test($('#admin_genre_eng').val())) {
				alert('장르(영문)은 영어로만 입력해주세요.');
			} else {
				if(title_image_flag === 'file') {
					var split_arr = new Array();
					split_arr = $('#admin_title_img').val().split("\\");
					title_image = split_arr[split_arr.length-1];
				} else {
					title_image = $('#admin_title_img').val();
				}
				
				var insert_info = {
						title : $('#admin_title').val(),
						count : $('#admin_count').val(),
						price : $('#admin_price').val(),
						genre : $('#admin_genre_kor').val(),
						genre_eng : $('#admin_genre_eng').val(),
						image : title_image,
						detail : $('#admin_detail').val().replace(/\n/g, '<br>')
				};
				
				$.ajax({
					url : '/web/admin/insertSellList',
					async : false,
					contentType : "application/json",
					data : JSON.stringify(insert_info),
					type : 'post',
					success : function() {
						$.ajax({
							url : '/web/admin/sellListMaxSeq',
							async : false,
							success : function(max) {
								seq = max.count;
							}
						});
						
						for(i=1; i<=temp-1; i++) {
							var detail_image;
							
							if($('input:radio[name=img'+i+']:checked').val() === 'file') {
								var split_arr = new Array();
								split_arr = $('#admin_image'+i+'').val().split('\\');
								detail_image = split_arr[split_arr.length-1];
							} else {
								detail_image = $('#admin_image'+i+'').val();
							}
							
							if($('#admin_image'+i+'').val() !== undefined && $('#admin_image'+i+'').val() !== '') {
								$.ajax({
									url : '/web/admin/insertDetailImage',
									async : false,
									data : {
										image_url : detail_image,
										seq_sell_list : seq
									},
									type : 'post',
									error : function() {
										alert('상세 이미지 등록중 에러 발생');
									}
								});
							}
						}
						alert('상품이 등록되었습니다');
						location.reload(); 
					},
					error : function() {
						alert('판매상품 등록중 에러 발생');
					}
				});
			}
		}
	});
});
</script>