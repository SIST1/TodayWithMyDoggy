<%@page import="message.MessageDao"%>
<%@page import="member.MemberDto"%>
<%@page import="profile.dogProfile.DogProfileDto"%>
<%@page import="profile.dogProfile.DogProfileDao"%>
<%@page import="member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link
	href="https://fonts.googleapis.com/css2?family=Anton&family=Edu+VIC+WA+NT+Beginner:wght@600&family=Gamja+Flower&family=Single+Day&family=Jua&family=Nanum+Pen+Script&display=swap"
	rel="stylesheet">

<script src="https://code.jquery.com/jquery-3.6.3.js"></script>
<script type="text/javascript" src="js/layout.js"></script>
<link rel="stylesheet" href="css/layout.css">

<style type="text/css">

.fa-envelope{
	position: absolute;
}

.msgCnt{
	background-color: #5496f2 ;
	color: white;
	font-weight: 600;
	font-size:10px;
	border-radius: 15px;
	width: 15px;
	height: 15px;
	line-height: 15px;
	text-align: center;
	position: relative;
	left: -10px;
	top: 10px;
}

@keyframes notificationAnimation {
  0% {
    transform: none;
  }
  50% {
    transform: translateY(-5px) rotateY(360deg);
  }
  100% {
    transform: none;
  }
}

.msgCnt:hover {
  animation: notificationAnimation 2s ease-in-out infinite;
}

.id-bar{
	 padding-top: 20px; 
	 font-size: 11px;
	 margin-left: -5px;
}

</style>

<%
//프로젝트 경로구하기
String root = request.getContextPath();
//로그인 상태인지?
String loginok = (String) session.getAttribute("loginok");
// 관리자 계정인지?
String isAdmin = (String) session.getAttribute("isAdmin");
//아이디얻기
String myid = (String) session.getAttribute("myid");
MemberDao dao = new MemberDao();
String nickname = dao.getNickname(myid);

//msg 개수
MessageDao mdao=new MessageDao();
int msgCnt=mdao.getUnreadCount(myid);
%>

</head>

<body>
	<nav class="navbar navbar-expand-custom navbar-mainbg m-0 p-0">
		<img src="/TodayWithMyDoggy/css/doglogg.png" width="50px;"
			style="margin-left: 20px; margin-right: 10px;"> <a
			class="navbar-brand navbar-logo pb-2 pt-2" href="index.jsp?main.jsp">
			<div style="font-size: 16px;">
				<b>TodayWithMyDoggy</b>
			</div>
		</a>
		<button class="navbar-toggler" type="button"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<i class="fas fa-bars text-white"></i>
		</button>
		<div class="collapse navbar-collapse p-0" id="navbarSupportedContent">
			<ul class="navbar-nav ml-0">
				<div class="hori-selector">
					<div class="left"></div>
					<div class="right"></div>
				</div>

				<li class="nav-item active"><a class="nav-link"
					href="<%=root%>/index.jsp?main=dog-friend/board.jsp"><i
						class="far"></i>같이 걸어요</a></li>
				<li class="nav-item"><a class="nav-link"
					href="<%=root%>/index.jsp?main=dog-talking/board.jsp"><i
						class=""></i>우리강아지</a></li>
				<li class="nav-item"><a class="nav-link"
					href="<%=root%>/index.jsp?main=place-share/boardList.jsp"><i
						class=""></i>같이가요</a></li>
				<li class="nav-item"><a class="nav-link"
					href="<%=root%>/index.jsp?main=qna/qnalist.jsp"><i
						class="qnaBoard"></i>Q&A 게시판</a></li>
				<li class="nav-item"><a class="nav-link"
					href="<%=root%>/index.jsp?main=notification/notificationlist.jsp"><i
						class="notificationBoard"></i>공지사항</a></li>

				<% //로그인 안한 경우
				if (loginok == null) {
				%>
				<li class="nav-item"><a class="nav-link"
					href="<%=root%>/index.jsp?main=login/loginmain.jsp"><i class=""></i>로그인</a></li>
				<li class="nav-item"><a class="nav-link"
					href="<%=root%>/index.jsp?main=signup/terms.jsp"><i class=""></i>회원가입</a>
				</li>
				<%
				} else { //로그인 한 경우
				%>
					
					<!-- 쪽지함 표시 -->
					<a href="index.jsp?main=message/list.jsp"
						style="width: 25px; padding-top: 15px; margin-left: 100px;">
						<i class="fa-solid fa-envelope"
						style="color: #5b5b5b; font-size: 25px"></i>
					</a>
						<span class="msgCnt"><%=msgCnt %></span>
					<%
					String memberNum = dao.getNum(myid);
	
					DogProfileDao proDao = new DogProfileDao();
					DogProfileDto proDto = proDao.getMyMainDog(memberNum);
	
					String proPhoto = proDto.getPhoto();
					
					if(proDto.getIdx()==null){ //로그인 + 강아지 정보 없음%>
						
						<div class="img-box" 
						style="width: 35px; height: 35px; background-color:#d9e4f4; border-radius: 70%; 
						overflow: hidden; float: left; margin-right: 2px; margin-top: 10px;
						text-align: center;line-height: 35px;">
							<%=dao.getNickname(myid) %>
						</div>
					
					<%}else{ //로그인 + 강아지 정보 있음%>
						
						<div class="img-box"
							style="width: 35px; height: 35px; border-radius: 70%; overflow: hidden; float: left; margin-right: 2px; margin-top: 10px;">
							<img src="/TodayWithMyDoggy/mypage/dogImg/<%=proPhoto%>"
								id="profile-img" style="width: 100%; height: 100%">
						</div>
					<%}
					%>
					
					<i class="fa-solid fa-caret-down fa-rotate-270"
						style="margin-left: 30px; cursor: pointer;"></i>
	
						<%
						if (loginok == null) { //로그아웃 상태
							
						%>
						<!-- 로그인 하지 않았을경우 관리자,마이페이지 안보이게 -->
						<%
						} else if (loginok != null && isAdmin.equals("0")) { //로그인 + 일반회원
						%>
						<div class="id-bar">
						<%=myid %>님 안녕하세요
						</div>
						
						<div class="profile-bar">
						<i class="fa-solid fa-user"
							style="color: #494949; cursor: pointer;"
							onclick="location.href='mypage/userMyPage.jsp'"> </i> <span
							style="font-size: 11px; cursor: pointer;"
							onclick="location.href='index.jsp?main=mypage/userMyPage.jsp'">마이페이지 </span> <i
							class="fa-solid fa-right-from-bracket"
							style="color: #cc0000; padding-top: 20px; margin-left: 15px; cursor: pointer;"
							onclick="location.href='login/logoutaction.jsp'"> </i> <span
							style="font-size: 11px; padding-bottom: 5px; cursor: pointer;"
							onclick="location.href='login/logoutaction.jsp'">로그아웃 </span>
						</div>
						<%
						} else { //로그인 + 관리자
						%>
						<div class="id-bar">
						관리자님 안녕하세요
						</div>
						
						<div class="profile-bar">
						<i class="fa-solid fa-user"
							style="color: #494949; cursor: pointer;"
							onclick="location.href='mypage/userMyPage.jsp'"> </i> <span
							style="font-size: 11px; cursor: pointer;"
							onclick="location.href='index.jsp?main=mypage/adminMyPage.jsp'">관리자페이지 </span> <i
							class="fa-solid fa-right-from-bracket"
							style="color: #cc0000; padding-top: 20px; margin-left: 15px; cursor: pointer;"
							onclick="location.href='login/logoutaction.jsp'"> </i> <span
							style="font-size: 11px; padding-bottom: 5px; cursor: pointer;"
							onclick="location.href='login/logoutaction.jsp'">로그아웃 </span>
							</div>
						<%
						}
						%>
				
				<%
				}
				%>
			</ul>
		</div>
	</nav>
</body>
<script type="text/javascript">
	$(".profile-bar").hide();
	$(".fa-caret-down").click(function() {
		$(".profile-bar").toggle()
		$(".id-bar").toggle()
		
	});
</script>
<script src="https://kit.fontawesome.com/2663817d27.js"
	crossorigin="anonymous"></script>
</html>