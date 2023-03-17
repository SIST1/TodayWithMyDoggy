<%@page import="member.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.6.3.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0168677f39871625290af327bd783770&libraries=services"></script>
<script type="text/javascript">
	$(function() {
		$("#cardImg").hide();
		$("#card1").attr('src', 'place-share/place-photo/no_img.jpg');

		$("#albtn").click(function () {
			$("#cardImg").toggle();
		});
		
		if ($('input[name="photo1"]').is(":checked") == true) {
			var fileValue = $("#photo1").val().split("\\");
			var fileName = fileValue[fileValue.length - 1];
			$("#titlePhoto").val(fileName);
		}
		$("#keyword").on("keydown", () => {
		    if (event.keyCode === 13) {
		        event.preventDefault();
		    }
		})
	});
	function readURL1(input) {
		if (input.files && input.files[0]) {
			var reader = new FileReader();
			reader.onload = function(e) {
				$('#card1').attr('src', e.target.result);
				$('#card1').css('opacity', 1);
			}
			reader.readAsDataURL(input.files[0]);
		}
	}
	
</script>
<style>
body {
	padding-top: 70px;
	padding-bottom: 30px;
}

input {
	font-size: 20p
}

.content>input {
	height: 700px;
}

img {
	width: 100%;
	height: 100%;
	opacity: 0.3;
}

.card {
	border-radius: 10%;
}

.map_wrap, .map_wrap * {
	margin: 0;
	padding: 0;
	font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;
	font-size: 12px;
}

.map_wrap a, .map_wrap a:hover, .map_wrap a:active {
	color: #000;
	text-decoration: none;
}

.map_wrap {
	position: relative;
	width: 100%;
	height: 500px;
}

#menu_wrap {
	position: absolute;
	top: 0;
	left: 0;
	bottom: 0;
	width: 250px;
	margin: 10px 0 30px 10px;
	padding: 5px;
	overflow-y: auto;
	background: rgba(255, 255, 255, 0.7);
	z-index: 1;
	font-size: 12px;
	border-radius: 10px;
}

.bg_white {
	background: #fff;
}

#menu_wrap hr {
	display: block;
	height: 1px;
	border: 0;
	border-top: 2px solid #5F5F5F;
	margin: 3px 0;
}

#menu_wrap .option {
	text-align: center;
}

#menu_wrap .option p {
	margin: 10px 0;
}

#menu_wrap .option button {
	margin-left: 5px;
}

#placesList li {
	list-style: none;
}

#placesList .item {
	position: relative;
	border-bottom: 1px solid #888;
	overflow: hidden;
	cursor: pointer;
	min-height: 65px;
}

#placesList .item span {
	display: block;
	margin-top: 4px;
}

#placesList .item h5, #placesList .item .info {
	text-overflow: ellipsis;
	overflow: hidden;
	white-space: nowrap;
}

#placesList .item .info {
	padding: 10px 0 10px 55px;
}

#placesList .info .gray {
	color: #8a8a8a;
}

#placesList .info .jibun {
	padding-left: 26px;
	background:
		url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_jibun.png)
		no-repeat;
}

#placesList .info .tel {
	color: #009900;
}

#placesList .item .markerbg {
	float: left;
	position: absolute;
	width: 36px;
	height: 37px;
	margin: 10px 0 0 10px;
	background:
		url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png)
		no-repeat;
}

#placesList .item .marker_1 {
	background-position: 0 -10px;
}

#placesList .item .marker_2 {
	background-position: 0 -56px;
}

#placesList .item .marker_3 {
	background-position: 0 -102px
}

#placesList .item .marker_4 {
	background-position: 0 -148px;
}

#placesList .item .marker_5 {
	background-position: 0 -194px;
}

#placesList .item .marker_6 {
	background-position: 0 -240px;
}

#placesList .item .marker_7 {
	background-position: 0 -286px;
}

#placesList .item .marker_8 {
	background-position: 0 -332px;
}

#placesList .item .marker_9 {
	background-position: 0 -378px;
}

#placesList .item .marker_10 {
	background-position: 0 -423px;
}

#placesList .item .marker_11 {
	background-position: 0 -470px;
}

#placesList .item .marker_12 {
	background-position: 0 -516px;
}

#placesList .item .marker_13 {
	background-position: 0 -562px;
}

#placesList .item .marker_14 {
	background-position: 0 -608px;
}

#placesList .item .marker_15 {
	background-position: 0 -654px;
}

#pagination {
	margin: 10px auto;
	text-align: center;
}

#pagination a {
	display: inline-block;
	margin-right: 10px;
}

#pagination .on {
	font-weight: bold;
	cursor: default;
	color: #777;
}

article {
	margin-left: 150px;;
	margin-right: 150px;
	font-size: 15px;
}
</style>
</head>

<body>
	<article>
		<div class="container" role="main">
			<br>
			<form method="post" action="place-share/addAction.jsp"
				enctype="multipart/form-data">
				<input type="hidden" name="titlePhoto" id="titlePhoto" value="">
				<div class="subject">
					<input type="text" class="form-control mr-5" name="subject"
						id="subject" placeholder="제목을 입력해 주세요" required="required">
				</div>
				<br>
				<div class="card-deck mr-5">
					<div class="input-group mb-5 mr-5 ml-4">
						<input type="file" class="form-control" id="inputGroupFile02"
							name="photo1" onchange="readURL1(this)">
						<button type="button" class="input-group-text btn btn-warning"
							for="inputGroupFile02" id="albtn">미리보기</button>
					</div>

					<div class="card" id="cardImg"
						style="margin-right: 50%; margin-bottom: 50px; border-radius: 13%">
						<img src="" class="card-img-top" id="card1"
							style="border-radius: 13%; filter: drop-shadow(2px 2px 2px #dcdcdc);">
					</div>					
				</div>

				<div class="content">
					<textarea type="text" class="form-control" rows="15" name="content"
						id="content" placeholder="내용을 입력해주세요" required="required"></textarea>
				</div>
				
				<input type="text" id="sample5_address" placeholder="주소" style="margin-top: 100px;"> <input
					type="button" onclick="sample5_execDaumPostcode()" value="주소 검색"><br>
				<div id="map"
					style="width: 350px; height: 350px; margin-top: 10px; display: none"></div>

				<script
					src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
				<script
					src="//dapi.kakao.com/v2/maps/sdk.js?appkey=발급받은 API KEY를 사용하세요&libraries=services"></script>
				<script>
				    var mapContainer = document.getElementById('map'), // 지도를 표시할 div
				        mapOption = {
				            center: new daum.maps.LatLng(37.537187, 127.005476), // 지도의 중심좌표
				            level: 5 // 지도의 확대 레벨
				        };
				
				    //지도를 미리 생성
				    var map = new daum.maps.Map(mapContainer, mapOption);
				    //주소-좌표 변환 객체를 생성
				    var geocoder = new daum.maps.services.Geocoder();
				    //마커를 미리 생성
				    var marker = new daum.maps.Marker({
				        position: new daum.maps.LatLng(37.537187, 127.005476),
				        map: map
				    });
				
				
				    function sample5_execDaumPostcode() {
				        new daum.Postcode({
				            oncomplete: function(data) {
				                var addr = data.address; // 최종 주소 변수
				
				                // 주소 정보를 해당 필드에 넣는다.
				                document.getElementById("sample5_address").value = addr;
				                // 주소로 상세 정보를 검색
				                geocoder.addressSearch(data.address, function(results, status) {
				                    // 정상적으로 검색이 완료됐으면
				                    if (status === daum.maps.services.Status.OK) {
				
				                        var result = results[0]; //첫번째 결과의 값을 활용
				
				                        // 해당 주소에 대한 좌표를 받아서
				                        var coords = new daum.maps.LatLng(result.y, result.x);
				                        // 지도를 보여준다.
				                        mapContainer.style.display = "block";
				                        map.relayout();
				                        // 지도 중심을 변경한다.
				                        map.setCenter(coords);
				                        // 마커를 결과값으로 받은 위치로 옮긴다.
				                        marker.setPosition(coords)
				                    }
				                });
				            }
				        }).open();
				    }
				</script>
				<div style="margin-bottom: 100px;">
					<br>
					<button type="submit" class="btn btn-sm btn-warning" id="btnSave" style="width: 45%; height: 30px;">저장</button>
					<button type="button" class="btn btn-sm btn-warning" id="btnList" style="width: 45%;  height: 30px;">목록</button>
				</div>
			</form>
		</div>
	</article>
</body>
</html>