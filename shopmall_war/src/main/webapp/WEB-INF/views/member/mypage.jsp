<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="phone" value="${fn:split(user.phone, '-')}"></c:set>
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
				<h2 class="title text-center">내 정보 수정</h2>
				<table id="mypage_table" style="width: 70%; margin: auto; border: 1px solid #B2B2B2;">
					<tr>
						<td class="mypage_title">아이디</td>
						<td>${user.id}</td>
					</tr>
					<tr>
						<td class="mypage_title">비밀번호</td>
						<td><input id="mypage_pw" type="password"></td>
					</tr>
					<tr>
						<td class="mypage_title">비밀번호 확인</td>
						<td><input id="mypage_pw_check" type="password"></td>
					</tr>
					<tr>
						<td class="mypage_title">이메일</td>
						<td><input id="mypage_email" type="text" value="${user.email}"></td>
					</tr>
					<tr>
						<td><p class="faq_title">전화번호</p></td>
						<td><input id="mypage_phone1" style="width: 30px" maxlength="3" type="text" value="${phone[0]}"> - <input id="mypage_phone2" style="width: 37px" maxlength="4" type="text" value="${phone[1]}"> - <input id="mypage_phone3" style="width: 37px" maxlength="4" type="text" value="${phone[2]}"></td>
					</tr>
					<tr>
						<td colspan="2" style="text-align: center; padding: 20px"><span id="mypage_check_span" style="display: block;"></span><input class="btn btn-default" type="button" value="변경하기" onclick="member.update()"></td>
					</tr>
				</table>
			</div>
		</div>
	</div>
</section>
<script>
$(function() {
	$('#mypage_pw_check').on('keyup', function() {
		if($('#mypage_pw').val() !== $('#mypage_pw_check').val()) {
			$('#mypage_check_span').css('color', 'red');
			$('#mypage_check_span').text('비밀번호가 일치하지 않습니다.');
		} else {
			$('#mypage_check_span').css('color', 'green');
			$('#mypage_check_span').text('비밀번호가 일치합니다.');
		}
	});
	
	$('#mypage_pw').on('keyup', function() {
		if($('#mypage_pw').val() !== $('#mypage_pw_check').val()) {
			$('#mypage_check_span').css('color', 'red');
			$('#mypage_check_span').text('비밀번호가 일치하지 않습니다.');
		} else {
			$('#mypage_check_span').css('color', 'green');
			$('#mypage_check_span').text('비밀번호가 일치합니다.');
		}
	});
});
</script>