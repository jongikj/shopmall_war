<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="context" value="<%=request.getContextPath()%>" />
<c:set var="img" value="${context}/resources/img" />
<c:set var="css" value="${context}/resources/css" />
<c:set var="js" value="${context}/resources/js"/>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>ShopMall public 테스트</title>
    <link href="${css}/bootstrap.min.css" rel="stylesheet">
    <link href="${css}/font-awesome.min.css" rel="stylesheet">
    <link href="${css}/prettyPhoto.css" rel="stylesheet">
    <link href="${css}/price-range.css" rel="stylesheet">
    <link href="${css}/animate.css" rel="stylesheet">
	<link href="${css}/main.css" rel="stylesheet">
	<link href="${css}/responsive.css" rel="stylesheet">
    <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
    <script src="js/respond.min.js"></script>
    <![endif]-->       
    <link rel="shortcut icon" href="${img}/ico/favicon.ico">
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="${img}/ico/apple-touch-icon-144-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="${img}/ico/apple-touch-icon-114-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="${img}/ico/apple-touch-icon-72-precomposed.png">
    <link rel="apple-touch-icon-precomposed" href="${img}/ico/apple-touch-icon-57-precomposed.png">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
</head><!--/head-->
<body>

	<header>
		<div id="admin_header">
			<tiles:insertAttribute name="header" /> 	
		</div>
	</header>
	<section style="min-height: 79%">
		<article id="admin_article">
			<tiles:insertAttribute name="body" /> 
		</article>
	</section>
	<footer>
		 <div id="admin_footer">
		 	<tiles:insertAttribute name="footer" /> 
		 </div>
	</footer>
</body>
<script src="${js}/jquery.js"></script>
<script src="${js}/jquery.cookie.js"></script>
<script src="${js}/price-range.js"></script>
<script src="${js}/jquery.scrollUp.min.js"></script>
<script src="${js}/bootstrap.min.js"></script>
<script src="${js}/jquery.prettyPhoto.js"></script>
<script src="${js}/main.js"></script>
<script>
app.init('${pageContext.request.contextPath}');
</script>
</html>
