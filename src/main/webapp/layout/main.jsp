<%@page import="member.MemberDao"%>
<%@page import="profile.dogProfile.DogProfileDto"%>
<%@page import="profile.dogProfile.DogProfileDao"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<script src="https://code.jquery.com/jquery-3.6.3.js"></script>
<title>Insert title here</title>

<style type="text/css">

/* 말풍선 */
.box {
	width: 360px;
	margin-left: 20px;
	margin-right: 10px;
	top: 20px;
	border-radius: 25px;
	text-align: center;
	font-weight: 700;
	/*color: #fdde6b;*/
	color: #000;
	position: relative;
	height: 120px;
	font-size: 20px;
	background-color: white;
	box-shadow: 3px 3px 3px 3px #eeeeee;
}

.w-mydog {
	margin-bottom: 10px;
	width: 20%;
	height: 40%;
	border-radius: 50px;
	top: 600px;
	right: 800px;
}

#banner {
	transform: scale(1);
	cursor: default;
}
</style>

</head>

<%
String id = (String) session.getAttribute("myid");
MemberDao mdao = new MemberDao();
String num = mdao.getNum(id);

DogProfileDao dao = new DogProfileDao();
DogProfileDto dto = dao.getMyMainDog(num);

String proPhoto = dto.getPhoto();
%>
<body>
	<!-- 맨 위 배너 및 이미지 -->
	<div style="width: 1000px;; overflow: hidden;">
		<img
			src="/TodayWithMyDoggy/place-share/place-photo/banner_waifu2x_photo_noise1.png"
			style="width: 1000px; opacity: 0.9" id="banner">
	</div>
	<div style="margin: 50px 0;"></div>


	<!-- 날씨 정보나 강아지 등록 하기 등.. -->
	<div style="margin-bottom: 30px; margin-top: 30px;">
		<!-- 
		<div id="title"
			style="width: 45%; height: 300px; background: #eee; text-align: center; 
			font-size: 20px; top: 50px; border-radius: 15px;">
		</div>
		 -->
		<div id="wbox"
			style="width: 400px; height: 400px; margin-left: 10px; border-radius: 15px; overflow: hidden;">
			<img
				src="/TodayWithMyDoggy/place-share/place-photo/pexels-photo-8257788.jpeg"
				style="width: 400px; height: 800px; opacity: 0.2"> <span>
				<div class="box sb" style="position: absolute; margin-top:500px;">
					<br> <span id="w-city">지역</span> <span id="w-temp">온도</span> <span
						id="w-desc">날씨</span> <br> <span id="w-comment">문장</span>
				</div> <%
 if (dto.getIdx() != null) {
 %> <img class="w-mydog"
				src="/TodayWithMyDoggy/mypage/dogImg/<%=proPhoto%>"
				style=" margin-top: 60px; position: absolute;"> <%
 } else {
 %>
			</span><span class="w-mydog" style="position: absolute;"><i class="fa-solid fa-dog fa-xl"></i></span>
			<%
			}
			%>
			<span
				style="padding-left: 50px; position: absolute; padding-bottom: 200px; top: 500px; margin-bottom: 300px;">
				<jsp:include page="/dog-friend/latestBoardList.jsp" />
			</span>
		</div>
	</div>
	<!-- 날씨 박스-->

	<!-- 커뮤니티 정보(산책) -->
	<div style="margin: 100px 0;"></div>
	<i class="fa-solid fa-quote-left" style="color: #dbe8ff; margin-left: 500px; font-size: 60px; margin-top: 50px; margin-bottom: 10px; "></i>
	<div style="font-size: 17px; text-align: center; color: gray; margin-bottom: 50px;">
	 <b>이곳에서는 반려견과 관련된 정보와 경험을 공유하며,
	 같은 취미와 관심사를 가진 사람들끼리 소통할 수 있습니다.<br>
	  또한, 다양한 이벤트와 모임을 통해 반려견과 함께 즐길 수 있는 기회도 제공합니다.<br>
	   함께하는 반려견 커뮤니티에서 소중한 반려견과의 삶을 더욱 풍요롭게 만들어보세요.
	</b></div>
			<br><br>
	
	<!-- 커뮤니티 정보(자랑) -->
	<jsp:include page="/dog-talking/board-rank.jsp" />

	<div style="margin: 50px 0;"></div>
	<!-- 커뮤니티 정보(장소) -->
	<jsp:include page="/place-share/latestBoardList.jsp" />
</body>

<script type="text/javascript" src="js/weather.js"></script>
<script src="https://kit.fontawesome.com/2663817d27.js"
	crossorigin="anonymous"></script>
</html>