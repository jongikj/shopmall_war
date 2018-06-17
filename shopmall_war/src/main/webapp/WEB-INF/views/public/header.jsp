<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<header id="header" style="background: white;">
	<!--header-->
	<div class="header-middle">
		<!--header-middle-->
		<div class="container">
			<div class="row">
				<div class="col-sm-4">
					<div class="logo pull-left">
						<a href="/web/"><img src="/web/resources/img/logo.jpg" alt="" /></a>
					</div>
				</div>
				<div class="col-sm-8">
					<c:if test='${sessionScope.user.id eq null}'>
						<div class="shop-menu pull-right">
							<ul class="nav navbar-nav">
								<li><a href="/web/member/goSignUp"><i class="fa fa-user"></i>회원가입</a></li>
								<li><a href="/web/shop/buy"><i class="fa fa-shopping-cart"></i>구매하기</a></li>
								<li><a href="/web/member/goLogin"><i class="fa fa-lock"></i>로그인</a></li>
							</ul>
						</div>
					</c:if>
					<c:if test='${sessionScope.user.id ne null}'>
						<div class="shop-menu pull-right">
							<ul class="nav navbar-nav">
								<li><a><i class="glyphicon glyphicon-music"></i>${user.id} 님 환영합니다.</a></li>
								<li><a href="/web/member/mypage"><i class="fa fa-user"></i>마이페이지</a></li>
								<li><a href="/web/shop/wishlist"><i class="fa fa-star"></i>내 위시리스트</a></li>
								<li><a href="/web/shop/buy"><i class="fa fa-shopping-cart"></i>구매하기</a></li>
								<li><a href="/web/member/logout"><i class="fa fa-lock"></i>로그아웃</a></li>
							</ul>
						</div>
					</c:if>
				</div>
			</div>
		</div>
	</div>
	<!--/header-middle-->

	<div class="header-bottom">
		<!--header-bottom-->
		<div class="container">
			<div class="row">
				<div class="col-sm-9">
					<div class="navbar-header">
						<button type="button" class="navbar-toggle" data-toggle="collapse"
							data-target=".navbar-collapse">
							<span class="sr-only">Toggle navigation</span> <span
								class="icon-bar"></span> <span class="icon-bar"></span> <span
								class="icon-bar"></span>
						</button>
					</div>
					<div class="mainmenu pull-left">
						<ul class="nav navbar-nav collapse navbar-collapse">
							<li><a href="/web/">홈</a></li>
							<li class="dropdown"><a href="#">게임구매<i
									class="fa fa-angle-down"></i></a>
								<ul role="menu" class="sub-menu">
									<li><a href="/web/shop/wishlist">위시리스트</a></li>
									<li><a href="/web/shop/buy">구매하기</a></li>
								</ul></li>
							<li><a id="header_faq" onclick="go_faq(1)">FAQ</a></li>
						</ul>
					</div>
				</div>
				<div class="col-sm-3">
					<div class="search_box pull-right">
						<input id="whatsthis" type="text" maxlength="8"/>
					</div>
				</div>
			</div>
		</div>
	</div>
</header>
<script>
$(function() {
	var url = document.URL;
	var url_split = url.split('/');
	
	if(url_split[4] === 'faq') {
		$('#header_faq').addClass('active');
	}
	
	$('#whatsthis').keyup(function() {
		checkAdmin();
	});
});
</script>