<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>모임 상세 | HobbyMatch</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<style>
body {
	background: #f4f4f4;
	color: #333;
	min-height: 100vh;
}

.gradient-bg {
	background: linear-gradient(135deg, #6a11cb, #2575fc);
}

.meeting-detail-card {
    background: white;
    border-radius: 8px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
    margin-top: 20px;
    display: flex; /* 가로 정렬 */
    align-items: center;
    padding: 20px;
}

.meeting-detail-card img {
    width: 40%;
    height: 400px;
    object-fit: cover;
    border-radius: 8px;
    margin-right: 20px;
}

.meeting-detail-card .content {
    flex-grow: 1;
}

.meeting-detail-card h3 {
	font-size: 1.4rem;
}

.meeting-detail-card p {
	font-size: 0.9rem;
	color: #555;
}

.participants-list {
	background: #fff;
	padding: 10px;
	margin-top: 15px;
	border-radius: 8px;
	box-shadow: 0 1px 5px rgba(0, 0, 0, 0.1);
}

.participants-list h5 {
	font-size: 1rem;
	margin-bottom: 8px;
}

.participant {
	display: flex;
    align-items: center;
    margin-bottom: 8px;
}
.participant p {margin-bottom: -1px;}
.participant img {
	width: 30px;
	height: 30px;
	border-radius: 50%;
	margin-right: 15px;
}

.btn-gradient {
	background: linear-gradient(135deg, #6a11cb, #2575fc);
	color: white;
	padding: 8px 12px;
	font-size: 0.9rem;
}

#map {
    width: 550px;
    height: 250px;
    margin-top: 10px;
}
.text-end{margin-right: 15px;}
.meeting-detail-card .content img{width: 15px; height: 15px; margin-right: 2px; margin-left:1px; margin-top: -5px;}
.meeting-detail-card img{width:450px; height: 500px; margin-left: 8px;}
</style>
</head>
<body>

    <jsp:include page="/WEB-INF/jsp/navbar.jsp" />

    <div class="container mt-4">
        <div class="row">
            <div class="col-md-10 mx-auto">
            <div align="center"><h1><strong>${meetup.title}</strong></h1></div>
                <div class="meeting-detail-card">
                    <img src="${pageContext.request.contextPath}/upload/${meetup.imagename}" alt="">
                    <div class="content">
                        <h5><strong>카테고리</strong></h5>
                        <p>
                            <c:choose>
                                <c:when test="${meetup.c_key == '1'}">운동</c:when>
                                <c:when test="${meetup.c_key == '2'}">음악</c:when>
                                <c:when test="${meetup.c_key == '3'}">스터디</c:when>
                                <c:when test="${meetup.c_key == '4'}">게임</c:when>
                                <c:when test="${meetup.c_key == '5'}">여행</c:when>
                                <c:otherwise>기타</c:otherwise>
                            </c:choose>
                        </p>
                        <h6><strong>주최자</strong></h6>
                        <p>${meetup.w_id}</p>
                        <h6><strong>모임 내용</strong></h6>
                        <p>${meetup.info}</p>
                        <h6><strong>모임 일정</strong></h6>
                        <p>📅 ${meetup.m_date}</p>
                        <h6><strong>참가비</strong></h6>
                        <p>💰 ${meetup.price}원</p>
                        <h6><strong>모임 장소</strong></h6>
                        <p><img alt="" src="../img/location.png"><strong>${meetup.address}</strong></p>
                        <div id="map"></div>
                        <input type="hidden" id="latitude" value="${meetup.latitude}" />
                        <input type="hidden" id="longitude" value="${meetup.longitude}" />

					</div>
				</div>
				<c:if test="${not empty alertSuccess }">
					<script type="text/javascript">
						alert("${alertSuccess}");
					</script>
				</c:if>

				<c:if test="${not empty alertError }">
					<script type="text/javascript">
						alert("${alertError}");
					</script>
				</c:if>

				<div class="participants-list">
					<c:forEach var="wId" items="${wId }">
						<div class="participant">
							<div class="d-flex align-items-center">
								<img src="/upload/king2.png" class="image" alt="">
								<div align="center">
									<table>
										<tr>
											<th>방장:</th>
										</tr>
										<tr>
											<td>${wId }</td>
										</tr>
									</table>
								</div>
							</div>
						</div>
					</c:forEach>
					</br>

					<h5>참가자 목록</h5>
					<c:forEach var="apply" items="${meetingApplies }">
						<div class="participant">
							<div class="d-flex align-items-center">
								<img src="/upload/basic2.png" class="image" alt="">
								<div align="center">
									<table>
										<tr>
											<th>신청자:</th>
											<td>${apply.id}</td>
										</tr>
										<tr>
											<th>닉네임:</th>
											<td>${apply.name }</td>
										</tr>
										<tr>
											<th>신청 날짜:</th>
											<td>${apply.apply_date}</td>
										</tr>
									</table>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
				<div class="d-flex gap-2 align-items-stretch btn-sm">
					<!-- 참가 취소 버튼 -->
					<form:form action="/cancelMeeting" method="POST"
						class="flex-grow-1">
						<input type="hidden" name="m_id" value="${meetup.m_id }">
						<input type="submit" value="참가 취소"
							class="btn btn-gradient w-100 h-100">
					</form:form>
					<!-- 추천(좋아요) 버튼 -->
					<form:form action="/meetup/recommend.html" method="GET"
						modelAttribute="meetup" class="d-flex">
						<form:input type="hidden" path="m_id" value="${meetup.m_id}" />
						<button type="submit"
							class="btn btn-outline-primary btn-sm px-3 h-100">👍추천</button>
					</form:form>
					<button onclick="window.location.href='/home';"
						class="btn btn-secondary btn-sm">이전으로</button>
				</div>
			</div>
		</div>
	</div>
	<br />
	<script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=5552d703b7f4511bcd45a4d521dda281"></script>
	<script type="text/javascript">
		// 카카오 지도 API가 로딩된 후에 실행되는 함수
		kakao.maps.load(function() {
			// 서버에서 받은 위도, 경도 값 (여기서는 예시 값 사용)
			var latitude = parseFloat(document.getElementById('latitude').value);
			var longitude = parseFloat(document.getElementById('longitude').value);


			console.log("Latitude: ", latitude);
			console.log("Longitude: ", longitude);

			// 지도 초기화
			var container = document.getElementById('map');
			var options = {
				center : new kakao.maps.LatLng(latitude, longitude), // 서버에서 받은 위도, 경도로 설정
				level : 3
			};

			var map = new kakao.maps.Map(container, options);

			// 마커 객체 생성
			var marker = new kakao.maps.Marker({
				map : map,
				position : new kakao.maps.LatLng(latitude, longitude)
			// 서버에서 받은 위도, 경도로 설정
			});

			// 마커 클릭 시 인포윈도우(주소 표시) 추가
			var infowindow = new kakao.maps.InfoWindow({
				content : document.getElementById('address').value
			});
			infowindow.open(map, marker); // 지도와 마커에 인포윈도우 표시
		});
	</script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
