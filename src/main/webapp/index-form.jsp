<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<script src="https://code.jquery.com/jquery-3.6.3.js"></script>

<script src="https://code.jquery.com/jquery-3.6.3.js"></script>
<title>Insert title here</title>
<title>Index</title>

<style type="text/css">

	@font-face {
    font-family: 'Dovemayo_gothic';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2302@1.1/Dovemayo_gothic.woff2') format('woff2');
    font-weight: normal;
    font-style: normal;
	font-size: 20px;
	}
	
	*{
	  font-family: Dovemayo_gothic;
	}


</style>


<!-- Latest compiled and minified CSS -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

<!-- jQuery library -->
<script
	src="https://cdn.jsdelivr.net/npm/jquery@3.6.3/dist/jquery.slim.min.js"></script>

<!-- Popper JS -->
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>

<!-- Latest compiled JavaScript -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

<div class="layout menu">
	<jsp:include page="layout/menu.jsp" />
</div>

<style type="text/css">
.main {
	height: 500px;
}

div.main {
	height: auto;
	min-height: 100%;
}

</style>

</head>

<%
String mainPage = "layout/main.jsp";
if (request.getParameter("main") != null) {
	mainPage = request.getParameter("main");
}
String root = request.getContextPath();
%>

<body>
	<!-- 페이지 전환시 navbar 위 공간 오류 원인 -->
	<div class="layout main">
		<jsp:include page="<%=mainPage%>" />
		
	</div>
</body>
</html>