<%@page import="answer.dogTalking.DogTalkingAnswerDao"%>
<%@page import="answer.dogTalking.DogTalkingAnswerDto"%>
<%@page import="board.dogTalking.DogTalkingBoardDto"%>
<%@page import="profile.dogProfile.DogProfileDto"%>
<%@page import="profile.dogProfile.DogProfileDao"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="member.MemberDao"%>
<%@page import="board.dogFriend.DogFriendBoardDto"%>
<%@page import="board.dogFriend.DogFriendBoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <script src="https://code.jquery.com/jquery-3.6.3.js"></script>
    

<style type="text/css">
	.contentphoto>img{
		width:300px;
		height: 300px;
	}
    #a-tag{
      color: black;
    }
    
    #a-tag:hover{
      color: black;
      text-decoration: none;
    }

	.wrapper{
  	  width: 800px auto;
  	  margin: 50px 160px;
  	  border: 1px lightgray solid;
  	  border-radius: 30px;
  	  padding: 40px 90px;
	}
	
	.wrapper-subject{
	  margin-bottom: 50px;	
	}
	
	.gray-font{
 	  color: gray;	
	}
	
	.wrapper-comment{
	  margin-bottom: 20px;
	  width: 80% auto;
	}
	
	.line{
	  width: 90% auto;
	  margin: 50px 0px;
	}
	
	#photo{
	  width: 200px;
	  height: 200px;
	}
	
	
	.writer{
	  font-weight: 600;
	  font-size: 14px;
	  position: absolute;
	}
	
	.writeday {
	  float: right;
	}
	
	.content{
	  margin-left: 5px;
	}
	
	#btn-box{
	  float: right;
	}
	
	#btn-comment-del{
	  padding-right: 10px;
	}
	
	#btn-comment-mod, #btn-comment-del{
	  cursor: pointer;
	}
	
	#my-comment{
	  color: gray;
	  font-size: 10px;
	  border-radius: 5px;
	  border: 1px solid gray;

	}
	
	#comment-info{
	  font-size: 10px;
	  font-weight: 300;
	}
	
	#commenter-div{
	  float: left;
	}
	
	
</style>

</head>

<body>

<%
	
	DogFriendBoardDao dao=new DogFriendBoardDao();
	MemberDao mdao=new MemberDao();
	String num=request.getParameter("num");
	String currentPage=request.getParameter("currentPage");
	DogFriendBoardDto dto=dao.getData(num);
	
    //writer_num
    String writerNum=mdao.getNum(dto.getId());
    DogProfileDao pdao=new DogProfileDao();
    DogProfileDto pdto=pdao.getMainDogInfo(writerNum);

    String isAdmin = (String) session.getAttribute("isAdmin");
	String id=(String)session.getAttribute("myid"); //sessionid
	String sessionNickname=mdao.getNickname(id); //sessionnickname
	String nickname=mdao.getNickname(dto.getId()); //writernickname
	
	//조회수 1 증가
	dao.updateReadCount(num);
	
	//dto 가져오기
	
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm");
	
%>

	<div class="wrapper">
	<input type="hidden" id="num" name="num" value="<%=dto.getNum()%>">
	<table class="table table-borderless" style="width: 100%;">
	<tr>
	<td>
	<h3><%=dto.getSubject() %></h3>
	
	<!-- 쪽지 Modal -->
	<div class="modal fade" id="exampleModal">
  		<div class="modal-dialog">
   		 <div class="modal-content">
   		 
    		 <div class="modal-header">
    		    <h5 class="modal-title" id="exampleModalLabel">쪽지 보내기</h5>
     		   <button type="button" class="close" data-dismiss="modal">
    		      <span aria-hidden="true">&times;</span>
    		    </button>
    		 </div>
    		  
	   <div class="modal-body">
	   <form action="message/writeaction.jsp" method="post">
	   <input type="hidden" name="num" value="<%=dto.getNum()%>">
	   <input type="hidden" name="receiver" value="<%=dto.getId()%>">
	   
	   	<span>[받는 사람] <%=nickname %></span>
	   	
	   	<br><br>
	    <textarea rows="10" style="width:100%;" name="content" placeholder="같이 산책하고 싶은 상대에게 쪽지를 보내보세요!"

	    required="required"></textarea>
    	  
      	<div class="modal-footer">
        	<button type="button" class="btn btn-default border border-secondary" data-dismiss="modal">취소</button>
        	<button type="submit" class="btn btn-default border border-secondary" >보내기</button>
    	</div>
    	
	   </form>
   	  	</div>
   		 </div>
  		</div>
	</div>
	<!-- 쪽지 Modal 끝 -->
			
	 <div class="wrapper-subject">
	 <input type="hidden" id="birthday" value="<%=pdto.getBirthday()%>">
	  
	  <!-- 프사 누르면 이동 -->
	  <a id="a-tag" data-toggle="modal" data-target="#exampleModal2">
	    <b>
	    <%
	    if(pdto.getIdx()==null){%>
		<span class="dog-photo" style="cursor: pointer;"><i class="fa-solid fa-dog fa-lg"></i></span>
		<span class="nickname" style="cursor: pointer;"><%=nickname %></span>
	    <%}else{%>
		<img class="dog-photo" style="cursor: pointer;width: 20px; height: 20px; border-radius: 20px;" src="/TodayWithMyDoggy/mypage/dogImg/<%=pdto.getPhoto()%>">
	    <span class="nickname" style="cursor: pointer;"><%=nickname %></span>
	    <%}%>
	    <br>
	    </b>
	  </a>
	  
	  <!-- 프로필 모달 -->
	  <div class="modal fade" id="exampleModal2">
  		<div class="modal-dialog">
   		 <div class="modal-content">
   		 
    		 <div class="modal-header">
    		    <h5 class="modal-title" id="exampleModalLabel2"><%=nickname %>의 멍멍이</h5>
     		   <button type="button" class="close" data-dismiss="modal">
    		      <span aria-hidden="true">&times;</span>
    		    </button>
    		 </div>
    		<%if(pdto.getName()==null){%>
    		<div class="modal-body">
    			<span >
    				강아지 프로필을 추가하지 않은 회원입니다.
    				쪽지로 인사해보세요!
    			</span>
			</div>
    		<%}else{
    			%> 
    	   		   <div class="modal-body">
   	   		   
	   	   		   <table class="table table-borderless">
	   	   		   	 <tr>
	   	   		   	 	<td rowspan="5"><img style="width:200px; height:200px; border-radius: 30px;" src="../TodayWithMyDoggy/mypage/dogImg/<%=pdto.getPhoto() %>"></td>
	   	   		   	 </tr>
	   	   		   	 <tr>
	   	   		   	 	<td> 이름 | <%=pdto.getName() %></td>
	   	   		   	 </tr>
	   	   		   	 <tr>
	   	   		   	 	<td> 성별 | <%=pdto.getGender() %></td>
	   	   		   	 </tr>
	   	   		   	 <tr>
	   	   		   	 	<td> 크기 | <%=pdto.getDogSize() %></td>
	   	   		   	 </tr>
	   	   		   	 <tr>
	   	   		   	 	<td> 생일 | <%=pdto.getBirthday() %> (<span id="age">0</span>세)</td>
	   	   		   	 </tr>
	   	   		   </table>  
	   	   		   
    	    	  </div>
    		<%}%>
    		
      	<div class="modal-footer">
        	<button type="button" class="btn btn-light" data-dismiss="modal">확인</button>
        	
			<!-- 쪽지함 만들기 -->
			<button type="button" class="btn btn-light"  data-dismiss="modal" style="float: right" data-toggle="modal" data-target="#exampleModal" class="btn btn-default btn" >
			쪽지
			</button>
	   	</div>
    	
   		 </div>
  		</div>
	</div>
	<!-- 프로필모달 끝 -->
	
		<script type="text/javascript">
    		
    		//멍멍이 나이 계산
    				
			let today=new Date();
			let year=today.getYear()+1900;
			
			let birthyear=$("#birthday").val().substr(0,4);
			
			$("#age").text(year-parseInt(birthyear));
			
    		</script>
    	  
	  <!-- 펫정보 -->
	  <%


	    String loginok=(String)session.getAttribute("loginok");
	    if(pdto.getIdx()==null){%>
	    <%}else{%>
	    <span style="font-size: 12px;"><%=pdto.getName() %> ( <%=pdto.getGender() %>|<%=pdto.getDogSize() %> )</span>
	    <%} %>
	  
	  <!-- 날짜, 조회수, 좋아요 밑 내용, 좋아요 클릭함수-->
	  <span class="gray-font"><%=sdf.format(dto.getWriteday()) %></span>
	  <span class="gray-font" style="float: right;"> 조회수 <%=dto.getReadCount() %></span>
	  <hr>
	  </div>
		<div class="contentphoto">
		<%=dto.getContent() %>
		</div>
		</td>
		</tr>
		<!-- 로그인되어있을때만 수정삭제 가능 -->
		<%if(loginok!=null &&  isAdmin.equals("1") || loginok!=null &&  nickname.equals(sessionNickname)){
			%>
			<div>
			<tr>
				<td>
					<button type="button" class="btn btn-default"
					onclick="location.href='index.jsp?main=dog-friend/write.jsp'">
					<span class="glyphicon glyphicon-pencil"></span>글쓰기</button>
					
					<button type="button" class="btn btn-default"
					onclick="location.href='index.jsp?main=dog-friend/update.jsp?num=<%=dto.getNum()%>&currentPage=<%=currentPage%>'">
					<span class="glyphicon glyphicon-edit"></span>수정</button>
					
					<button type="button" class="btn btn-default"
					onclick="funcdel(<%=num%>,<%=currentPage%>)">
					<span class="glyphicon glyphicon-remove"></span>삭제</button>
					
					<button type="button" class="btn btn-default" style="float: right;"
					onclick="location.href='index.jsp?main=dog-friend/board.jsp?currentPage=<%=currentPage%>'">
					<span></span>목록</button>
					
				</td>
			</tr>
			</div>
			
		<%}else{
		%>
			<div>
			<tr>
				<td>
					<button type="button" class="btn btn-default"
					onclick="location.href='index.jsp?main=dog-friend/board.jsp?currentPage=<%=currentPage%>'">
					<span></span>목록</button>
				</td>
			</tr>
			</div>
			<% }%>
		</table>
		
		
	</div>


	<script type="text/javascript">
		function funcdel(num,currentPage){
			//alert(num+","+currentPage);
			var a=confirm("삭제하려면 [확인]을 눌러주세요.");
			if(a){
				location.href="dog-friend/delete.jsp?num="+num+"&currentPage="+currentPage;
			}
		}
		  
	</script>
</body>
</html>