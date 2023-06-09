<%@page import="board.notification.NotificationDao"%>
<%@page import="board.notification.NotificationDto"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>Insert title here</title>
	<script src="https://code.jquery.com/jquery-3.6.3.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
	<style>
		.container {
			width: 100%;
		}
		
		.content {
			margin:0 auto;
			margin-bottom: 50px;
		}
		
		.subject {
			width:700px;
			margin:0 auto;
		}
		
		#btn-save{
			margin-top: 20px;
			float: right;			
		}
		
		
	</style>
	<%
		String num = request.getParameter("num");
		NotificationDao dao = new NotificationDao();
		NotificationDto dto = dao.getData(num);
	%>
</head>
<body>
   <article>
      <div class="container">
         <h2>공지사항 수정</h2>
         <br>
         <form method="post" action="notification/updateaction.jsp">
         	<!-- num을 hidden으로 updateaction.jsp로 넘겨준다 -->
         	<input type="hidden" name="num" value="<%=dto.getNum()%>">
         	
            <div class="subject">
               <div>제목</div>
               <input type="text" class="form-control" name="title" id="title" placeholder="제목을 입력해 주세요" value="<%=dto.getTitle()%>">
            </div>
            <br>
            <div class="content">
               <div>내용</div>
               <textarea class="form-control" rows="5" name="content" id="content" placeholder="내용을 입력해 주세요"><%=dto.getContent()%></textarea>
            <button type="submit" class="btn btn-sm btn-default border border-secondary" id="btn-save">수정</button>
            </div>
         </form>
      </div>
   </article>
</body>
</html>