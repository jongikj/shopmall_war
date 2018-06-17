<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<section>
	<div class="container">
		<div style="height: 250px; margin-top: 175px; border: 1px #d9d9d9 solid; padding-top: 35px;">
			<form action="#" method="post" id="login-form" style="width: 300px; margin: auto; text-align: center;">
		         <div>
		         	<span class="glyphicon glyphicon-log-in" style="font-size: 20px"></span>
	             	<input id="login_id" type="text" class="form-control" name="id" placeholder="아이디" autofocus>
		         </div>
		         <div>
		             <input id="login_pw" type="password" class="form-control" name="pw" placeholder="비밀번호">
		         </div>
		         <div>
		             <button type="button" class="form-control btn btn-primary" style="margin-bottom: 10px" onClick="login()">로그인</button>
		             <span>계정이 없으신가요? <a href="/web/member/goSignUp"><i class="fa fa-user"></i>회원가입</a></span>
		         </div>
	         </form>
         </div>
	</div>
</section>
