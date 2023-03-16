<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.security.SecureRandom" %>
<%@ page import="java.math.BigInteger" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.6.3.js"></script>

</head>
<%
//세션값 얻기

	String saveok=(String)session.getAttribute("saveok");

	String myid="";
	if(saveok!=null){
		myid=(String)session.getAttribute("myid");
	}
%>
<body>
	<div style="margin-left:130px;">
		<form action="login/loginaction.jsp" method="post">
			<table style="width:300px;">
				<tr>
					<td colspan="2" align="center">
						<input type="checkbox" name="cbsave"<%=saveok==null?"":"checked" %>>아이디저장
					</td>
				</tr>
				
				<tr>
					<th width="100">아이디</th>
					<td>
						<input type="text" name="id" required="required" style="width:120px;"
						value="<%=myid%>">
					</td>
				</tr>
				
				<tr>
					<th width="100">비밀번호</th>
					<td>
						<input type="password" name="password" required="required" style="width:120px;">
					</td>
				</tr>
				
				<tr>
					<td colspan="2" align="center">
						<button type="submit" style="width:100px;" >로그인</button>
					</td>
				</tr>
			</table>
			
		</form>
	</div>
</body>
</html>