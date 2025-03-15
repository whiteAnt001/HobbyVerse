<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>모임 상세 | HobbyMatch</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<style>
body {
	background: #f4f4f4;
	color: #333;
	min-height: 100vh;
}

.gradient-bg {
	background: linear-gradient(135deg, #6a11cb, #2575fc);
}

.meeting-header {
	background: linear-gradient(135deg, #6a11cb, #2575fc);
	color: white;
	padding: 20px 10px;
	text-align: center;
	border-radius: 0 0 15px 15px;
}

.meeting-header h1 {
	font-size: 1.5rem;
}

.meeting-header h4 {
	font-size: 1rem;
}

.meeting-detail-card {
	background: white;
	border-radius: 8px;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
	margin-top: 20px;
}

.meeting-detail-card img {
	width: 100%;
	height: 300px;
	object-fit: cover;
	border-radius: 8px 8px 0 0;
}

.meeting-detail-card .content {
	padding: 20px;
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
	justify-content: space-between;
	align-items: center;
	margin-bottom: 8px;
}

.participant img {
	width: 30px;
	height: 30px;
	border-radius: 50%;
	margin-right: 8px;
}

.btn-gradient {
	background: linear-gradient(135deg, #6a11cb, #2575fc);
	color: white;
	padding: 8px 12px;
	font-size: 0.9rem;
}

.btn-sm {
	padding: 5px 8px;
	font-size: 0.8rem;
}
</style>
</head>
<body>

	<jsp:include page="/WEB-INF/jsp/navbar.jsp" />

	<div class="meeting-header">
		<h1>${meetup.title }</h1>
	</div>

	<div class="container mt-4">
		<div class="row">
			<div class="col-md-8 mx-auto">
				<div class="meeting-detail-card">
					<img
						src="${pageContext.request.contextPath}/upload/${meetup.imagename }"
						alt="">
					<div class="content">
						<h5>카테고리</h5>
						<p>
							<c:choose>
								<c:when test="${meetup.c_key == '1' }">
									<font size="3">운동</font>
								</c:when>
								<c:when test="${meetup.c_key == '2' }">
									<font size="3">음악</font>
								</c:when>
								<c:when test="${meetup.c_key == '3' }">
									<font size="3">스터디</font>
								</c:when>
								<c:when test="${meetup.c_key == '4' }">
									<font size="3">게임</font>
								</c:when>
								<c:when test="${meetup.c_key == '5' }">
									<font size="3">여행</font>
								</c:when>
								<c:otherwise>
									<font size="3">기타</font>
								</c:otherwise>
							</c:choose>
						</p>
						<!-- <p>${meetup.category_name}</p> -->
						<h5>작성자</h5>
						<p>${meetup.w_id }</p>
						<h5>모임 설명</h5>
						<p>${meetup.info }</p>
						<h5>모임 일정</h5>
						<p>📅 ${meetup.m_date }</p>
						<h5>참가비</h5>
						<p>💰 ${meetup.price }원</p>
						<h5>모임 위치</h5>
						<p>
							<strong>${ meetup.address }</strong>
						</p>
						<div id="map" style="width: 500px; height: 400px;"></div>
						<input type="hidden" id="latitude" value="${ meetup.latitude }" />
						<input type="hidden" id="longitude" value="${ meetup.longitude }" />
						<div
							class="d-flex justify-content-between align-items-center mt-3">
							<div></div>
							<!-- 빈 공간으로 좌측 정렬 방지 -->
							<div class="text-end">
								<small class="text-muted">작성일: ${meetup.formattedW_date} | 조회수: ${views} | 추천: ${meetup.recommend }</small>
							</div>
						</div>
					</div>
				</div>
				
				


				<c:choose>
					<c:when
						test="${user != null && user.email == meetup.email || user.role == 'ROLE_ADMIN'}">
						<div class="participants-list">
							<c:forEach var="wId" items="${wId}">
								<div class="participant">
									<div class="d-flex align-items-center">
										<img src="/upload/king2.png" class="image" alt="">
										<div align="center">
											<table>
												<tr>
													<th>방장:</th>
												</tr>
												<tr>
													<td>${wId}</td>
												</tr>
											</table>
										</div>
									</div>
								</div>
							</c:forEach>
							<br>

							<h5>참가자 목록</h5>
							<c:forEach var="apply" items="${meetingApplies}">
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
													<td>${apply.name}</td>
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

						<!-- 수정, 삭제, 이전으로 버튼을 가운데 정렬하고 나란히 배치 -->
						<div class="d-flex justify-content-center gap-3 mt-3">
							<!-- 수정 버튼 -->
							<form action="/meetup/modify.html" class="d-flex">
								<input type="hidden" name="m_id" value="${meetup.m_id}">
								<input type="submit" value="수정" name="BTN"
									class="btn btn-sm btn-outline-secondary">
							</form>

							<!-- 삭제 버튼 -->
							<form action="/meetup/modify.html" onsubmit="return check()">
								<input type="hidden" name="m_id" value="${meetup.m_id}">
								<input type="submit" value="삭제" name="BTN"
									class="btn btn-sm btn-outline-danger">
							</form>

							<!-- 이전으로 버튼 -->
							<c:choose>
								<c:when test="${c_key == 1}">
									<a href="/category/moveSport"
										class="btn btn-sm btn-outline-secondary">이전으로</a>
								</c:when>
								<c:when test="${c_key == 2}">
									<a href="/category/moveMusic"
										class="btn btn-sm btn-outline-secondary">이전으로</a>
								</c:when>
								<c:when test="${c_key == 3}">
									<a href="/category/moveStudy"
										class="btn btn-sm btn-outline-secondary">이전으로</a>
								</c:when>
								<c:when test="${c_key == 4}">
									<a href="/category/moveGame"
										class="btn btn-sm btn-outline-secondary">이전으로</a>
								</c:when>
								<c:when test="${c_key == 5}">
									<a href="/category/moveTravel"
										class="btn btn-sm btn-outline-secondary">이전으로</a>
								</c:when>
								<c:when test="${c_key == 6}">
									<a href="/category/moveEtc"
										class="btn btn-sm btn-outline-secondary">이전으로</a>
								</c:when>
							</c:choose>
						</div>

						<script type="text/javascript">
							function check(frm) {
								if (!confirm("정말로 삭제하시겠습니까?"))
									return false;
							}
						</script>
					</c:when>
					<c:otherwise>
						<div align="center"
							class="d-flex justify-content-center gap-2 align-items-stretch">
							<!-- 참가신청 버튼 (길게) -->
							<form:form action="/applyMeeting" method="POST">
								<input type="hidden" name="m_id" value="${meetup.m_id}">
								<input type="submit" value="참가신청" class="btn btn-gradient w-100"
									onsubmit="return check()">
							</form:form>

							<!-- 추천(좋아요) 버튼 (작게) -->
							<form action="/meetup/recommend.html"
								class="d-flex align-items-stretch">
								<input type="hidden" name="m_id" value="${meetup.m_id}">
								<button type="submit"
									class="btn btn-outline-primary btn-sm h-100">👍추천</button>
							</form>
						</div>
					</c:otherwise>
				</c:choose>


			</div>
		</div>
	</div>
	<div>
		<br />
		<script type="text/javascript"
			src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=5552d703b7f4511bcd45a4d521dda281"></script>

		<script type="text/javascript">
			// 카카오 지도 API가 로딩된 후에 실행되는 함수
			kakao.maps
					.load(function() {
						// 서버에서 받은 위도, 경도 값 (여기서는 예시 값 사용)
						var latitude = parseFloat(document
								.getElementById('latitude').value);
						var longitude = parseFloat(document
								.getElementById('longitude').value);

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
							position : new kakao.maps.LatLng(latitude,
									longitude)
						// 서버에서 받은 위도, 경도로 설정
						});

						// 마커 클릭 시 인포윈도우(주소 표시) 추가
						var infowindow = new kakao.maps.InfoWindow({
							content : document.getElementById('address').value
						});
						infowindow.open(map, marker); // 지도와 마커에 인포윈도우 표시
					});
		</script>
		<script
			src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	</div>
</body>
</html>
