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

.participant p {
	margin-bottom: -1px;
}

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
	width: 100%;
	height: 250px;
	margin-top: 10px;
}

.text-end {
	margin-right: 15px;
}

.meeting-detail-card .content img {
	width: 15px;
	height: 15px;
	margin-right: 2px;
	margin-left: 1px;
	margin-top: -5px;
}

.meeting-detail-card img {
	width: 450px;
	height: 500px;
	margin-left: 8px;
}
</style>
</head>
<body>

	<jsp:include page="/WEB-INF/jsp/navbar.jsp" />

	<div class="container mt-4">
		<div class="row">
			<div class="col-md-10 mx-auto">
				<div align="center">
					<h1>
						<strong>${meetup.title}</strong>
					</h1>
				</div>
				<div class="meeting-detail-card">
					<img
						src="${pageContext.request.contextPath}/upload/${meetup.imagename}"
						alt="">
					<div class="content">
						<h5>
							<strong>카테고리</strong>
						</h5>
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
						<h6>
							<strong>주최자</strong>
						</h6>
						<p>${meetup.w_id}</p>
						<h6>
							<strong>모임 내용</strong>
						</h6>
						<p>${meetup.info}</p>
						<h6>
							<strong>모임 일정</strong>
						</h6>
						<p>📅 ${meetup.m_date}</p>
						<h6>
							<strong>참가비</strong>
						</h6>
						<p>💰 ${meetup.price}원</p>
						<h6>
							<strong>모임 장소</strong>
						</h6>
						<p>
							<img alt="" src="../img/location.png"><strong>${meetup.address}</strong>
						</p>
						<div id="map"></div>
						<input type="hidden" id="latitude" value="${meetup.latitude}" />
						<input type="hidden" id="longitude" value="${meetup.longitude}" />
						<div class="text-end">
							<small class="text-muted">작성일: ${meetup.formattedW_date}
								| 조회수: ${views} | 추천: ${meetup.recommend}</small>
						</div>
					</div>
				</div>

				<c:choose>
					<c:when
						test="${user != null && user.email == meetup.email || user.role == 'ROLE_ADMIN'}">
						<div class="participants-list">
							<c:forEach var="wId" items="${wId}">
								<div class="participant">
									<img src="/upload/king2.png" class="image" alt="">
									<div>
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
							</c:forEach>
							<br>
							<h5>참가자 목록</h5>
							<c:forEach var="apply" items="${meetingApplies}">
								<div
									class="participant d-flex justify-content-between align-items-center">
									<div class="participant-info d-flex align-items-center">
										<img src="/upload/basic2.png" alt="">
										<div>
											<p>신청자: ${apply.id }</p>
											<p>닉네임: ${apply.name}</p>
											<p>신청 날짜: ${apply.apply_date}</p>
										</div>
									</div>

									<!-- 강퇴 버튼을 오른쪽 끝으로 배치 -->
									<form action="/outMeeting" method="POST">
										<div class="kick-button-container">
											<input type="hidden" name="m_id" value="${meetup.m_id  }">
											<input type="hidden" name="id" value="${apply.id }">
											<input type="hidden" name="apply_id" value="${apply.apply_id }">
											<input type="submit" value="강퇴" class="btn btn-outline-danger">
										</div>
									</form>
								</div>
							</c:forEach>
						</div>
						<div class="d-flex justify-content-center gap-3 mt-3">
							<form action="/meetup/modify.html">
								<input type="hidden" name="m_id" value="${meetup.m_id}">
								<input type="submit" value="수정" name="BTN"
									class="btn btn-outline-secondary">
							</form>
							<form action="/meetup/modify.html" onsubmit="return check();">
								<input type="hidden" name="m_id" value="${meetup.m_id}">
								<input type="submit" value="삭제" name="BTN"
									class="btn btn-outline-danger">
							</form>
							<a href="/home" class="btn btn-outline-secondary">이전으로</a>
						</div>
						<script>
							function check() {
								return confirm("정말로 삭제하시겠습니까?");
							}
						</script>
					</c:when>
					<c:otherwise>
						<div class="d-flex justify-content-center gap-2 mt-3">
							<form action="/applyMeeting" method="POST">
								<input type="hidden" name="m_id" value="${meetup.m_id}">
								<input type="submit" value="참가신청" class="btn btn-gradient"2>
							</form>
							<form action="/meetup/report.html">
								<input type="hidden" name="m_id" value="${meetup.m_id}">
								<button type="submit" class="btn btn-outline-danger">🚨신고</button>
							</form>
							<a href="/home" class="btn btn-outline-secondary">이전으로</a>
						</div>
						<c:if test="${not empty alertCancel}">
							<script>
								alert("${alertCancel}");
							</script>
						</c:if>
					</c:otherwise>
				</c:choose>
				<br />
			</div>
		</div>
	</div>

	<script
		src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=5552d703b7f4511bcd45a4d521dda281"></script>
	<script>
		kakao.maps
				.load(function() {
					var latitude = parseFloat(document
							.getElementById('latitude').value);
					var longitude = parseFloat(document
							.getElementById('longitude').value);

					var container = document.getElementById('map');
					var options = {
						center : new kakao.maps.LatLng(latitude, longitude),
						level : 3
					};

					var map = new kakao.maps.Map(container, options);
					var marker = new kakao.maps.Marker({
						map : map,
						position : new kakao.maps.LatLng(latitude, longitude)
					});
				});
	</script>
</body>
</html>
