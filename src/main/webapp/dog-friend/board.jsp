<%@page import="board.dogFriend.DogFriendBoardDao"%>
<%@page import="board.dogFriend.DogFriendBoardDto"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board.dogTalking.DogTalkingBoardDto"%>
<%@page import="java.util.List"%>
<%@page import="board.dogTalking.DogTalkingBoardDao"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.6.3.js"></script>
<title>Insert title here</title>
    <script type="text/javascript">
    
    $(function(){
    	  
    	//전체체크클릭시 체크값 얻어서 모든 체크값에 전달
    	$(".alldelcheck").click(function(){
    		var chk=$(this).is(":checked");
    		//console.log(chk);
    		//전체 체크값을 글 앞의 체크에 일괄 전달
    		$(".alldel").prop("checked",chk);
    	})
    	
    	//삭제버튼 클릭시 삭제
    	$("#btndel").click(function(){
    		//체크된 길이
    		var len=$(".alldel:checked").length;
    		//alert(len);
    		if(len==0){
    			alert("최소 한 개 이상의 글을 선택해주세요.");
    		}else{
    			var a=confirm(len+"개의 글을 삭제하려면 [확인]을 눌러주세요.");
    			
    			//체크된 곳의 value값..아까 넣어둔 num 얻기
    			var n="";
    			$(".alldel:checked").each(function(idx){
    				n+=$(this).val()+",";
    			})
    			
    			//마지막 컴마 값 삭제
    			n=n.substring(0,n.length-1);
    			//alert(n);
    			
    			//삭제파일로 전송
    			location.href="dog-friend/alldelete.jsp?nums="+n;
    		}
    		
    	})
    	
    })
    </script>
</head>
<body>

   <%
    DogFriendBoardDao dao=new DogFriendBoardDao();
   
   int totalCount;
   int totalPage;//총페이지수
   int startPage;//각블럭의 시작페이지
   int endPage;//각블럭의 끝페이지
   int start; //각페이지의 시작번호
   int perPage=5; //한페이지에 보여질 글의 갯수
   int perBlock=5; //한블럭당 보여지는 페이지개수
   int currentPage; //현재페이지
   int no;
   
   //총개수
   totalCount=dao.getTotalCount();
   //현재페이지번호 읽기(단 null 일때는 1페이지로 설정)
   if(request.getParameter("currentPage")==null)
      currentPage=1;
   else
   currentPage=Integer.parseInt(request.getParameter("currentPage"));
   
   //총 페이지 갯수
   totalPage=totalCount/perPage+(totalCount%perPage==0?0:1);
   
   //각블럭의 시작페이지..현재페이지가 3(s:1,e:5) 6(s:6 e:10)
   startPage=(currentPage-1)/perBlock*perBlock+1;
   endPage=startPage+perBlock-1;
   
   //총페이지가 8. (6~10...endpage를 8로 수정해주어야 한다)
   if(endPage>totalPage)
      endPage=totalPage;
   
   //각페이지에서 불러올 시작번호
   start=(currentPage-1)*perPage;
   //각페이지에서 필요한 게시글 가져오기
   List<DogFriendBoardDto> list=dao.getList(start, perPage);
   
   SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm");
   
   no=totalCount-(currentPage-1)*perPage;
   %>
   
   <div style=" margin: 20px 300px;">
   
     <b>총 <%=totalCount %>개의 글이 있습니다</b>

     
     <br><br>
   
   <table class="table table-bordered" style="width: 600px;">
     <tr>
       <td>번호</td>
       <td>제목</td>
       <td>작성자</td>
       <td>작성일</td>
       <td>조회수</td>
       <td>좋아요</td>
     </tr>
		
		<%
		if(totalCount==0){
			%>
			<tr>
				<td colspan="5" align="center">
					<h3>등록된 게시글이 없습니다.</h3>
				</td>
			</tr>
			<%
		}else{
			for(DogFriendBoardDto dto:list){
				
				%>
				<tr>
					<td align="center">
						<input type="checkbox" class="alldel" value="<%=dto.getNum()%>">
						&nbsp;&nbsp;
						<%=no-- %>
					</td>
					
					<td>
						<a href="index.jsp?main=dog-friend/detail.jsp?num=<%=dto.getNum() %>&currentPage=<%=currentPage%>">
						<%=dto.getSubject() %></a>

					</td>
					
					<td><%=dto.getNickname()%></td>
					<td><%=sdf.format(dto.getWriteday()) %></td>
					<td><%=dto.getReadCount() %></td>
					<td><%=dto.getLikes() %></td>
				</tr>
				<%
			}
		}
		%>
		
     <%
     
     //로그인 한 유저만 글쓰기 버튼     
     String loginok=(String)session.getAttribute("loginok");
     
     
     if (loginok!=null){%>
     	<tr>
			<td colspan="6">
				<input type="checkbox" class="alldelcheck">전체선택
					<button type="button" class="btn btn-success btn-sm" style="float:right"
					onclick="location.href='index.jsp?main=dog-friend/write.jsp'"><span class="glyphicon glyphicon-pencil" ></span>글쓰기</button>
					
<!-- 				auth가 1일 때만 보이게 하기
					<span style="float:right">
					<button type="button" class="btn btn-danger btn-sm"
					id="btndel"><span class="glyphicon glyphicon-trash"></span>삭제</button>
					
					&nbsp;
					
				</span> -->
			</td>
		</tr>
     <%}else{%>
  			<tr>
  				<td colspan="6">
    	 		<input type="checkbox" class="alldelcheck">전체선택
					<button type="button" class="btn btn-success btn-sm" style="float:right"
					onclick="alert('로그인 후 이용해주세요')"><span class="glyphicon glyphicon-pencil" ></span>글쓰기</button>
				</td>
			</tr>
     <%}
     %>
   </table>
   
   <!-- 페이징 출력 -->
   <div style="width: 500px; text-align: center;">
      <ul class="pagination">
         <%
         //이전
         if (startPage > 1) {
         %>
         <li><a href="index.jsp?main=dog-friend/board.jsp?currentPage=<%=startPage - 1%>">이전</a>
         </li>
         <%
         }
         for (int pp = startPage; pp <= endPage; pp++) {
         if (pp == currentPage) {
         %>
         <li class="active"><a href="index.jsp?main=dog-friend/board.jsp?currentPage=<%=pp%>"><%=pp%></a>
         </li>
         <%
         } else {
         %>

         <li><a href="index.jsp?main=dog-friend/board.jsp?currentPage=<%=pp%>"><%=pp%></a></li>
         <%
         }
         }
         //다음
         if (endPage < totalPage) {
         %>
         <li><a href="index.jsp?main=dog-friend/board.jsp?currentPage=<%=endPage + 1%>">다음</a></li>
         <%
         }
         %>
      </ul>
   </div>
</body>
</html>