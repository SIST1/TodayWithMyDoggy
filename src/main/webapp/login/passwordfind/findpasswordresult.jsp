
<%@page import="member.MemberDto"%>
<%@page import="member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <script src="https://code.jquery.com/jquery-3.6.3.js"></script>
</head>
<body>
<%
 request.setCharacterEncoding("UTF-8");
String id = request.getParameter("id");
String hp = request.getParameter("hp");
     
MemberDao dao = new MemberDao();
MemberDto dto= dao.getMemeber(id);
 String pwd = dao.getPassword(id); //비밀번호를 디비에서 가져옴..실패시 널
%>

<form name="idsearch" method="post">
      <%
       if (pwd != "" && dto.getHp().equals(hp)) {
    	   
    	   //반 잘라서 뒤에 별표 붙이기
    	   int pwdsize=pwd.length()/2;
    	   String result=pwd.substring(0, pwdsize);
    	   
    	   String tmp="";
    	   if(pwdsize%2==1){//홀수면 하나 더 붙인다.
    		   for(int i=0; i<pwdsize+1; i++){
    			   tmp +="*";
    		   }
    	   }else{
    		   for(int i=0; i<pwdsize; i++){
    			   tmp +="*";
    		   }
    	   }
      %>
     
      <div class = "container">
      	<div class = "found-success">
	      <div class ="found-id">회원님의 비밀번호는 <%=result+tmp%> 입니다.</div>
	     </div>
	     <div class = "found-login">
 		    <input type="button" id="btnLogin" value="로그인" onclick="location.href='index.jsp?main=login/loginform.jsp'"/>
       	</div>
       </div>
      <%
  } else {
 %>
        <div class = "container">
      	<div class = "found-fail">
	      등록된 정보가 없습니다.
	     </div>
	     <div class = "found-login">
 		    <input type="button" id="btnback" class="btn btn-default" value="다시 찾기" onclick="history.back()"/>
 		    <input type="button" id="btnjoin" class="btn btn-default" value="회원가입" onclick="location.href='index.jsp?main=signup/terms.jsp'"/>
       	</div>
       </div>
       
       <%
  }
 %> 
      </form>
</body>
</html>