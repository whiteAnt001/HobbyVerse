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
    width: 1080px; /* 원하는 비율로 width 조정 */
    margin-left: auto; /* 중앙 정렬 */
    margin-right: auto; /* 중앙 정렬 */
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
.btn-outline-secondary {
    padding: 5px 12px;  /* 세로 크기를 줄이기 위해 패딩을 조정 */
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
				<img src="${pageContext.request.contextPath}/upload/${meetup.imagename }" alt="">
					<div class="content">
					<h6><strong>카테고리</strong></h6>
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
						<h6><strong>주최자</strong></h6>
						<p>${meetup.w_id }</p>
						<h6><strong>모임내용</strong></h6>
						<p>${meetup.info }</p>
						<h6><strong>모임 일정</strong></h6>
						<p>📅 ${meetup.m_date }</p>
						<h6><strong>참가비</strong></h6>
						<p>💰 ${meetup.price }원</p>
						<h6><strong>모임 장소</strong></h6>
						<p><img alt="" src="../img/location.png"><strong>${meetup.address}</strong></p>
						<div id="map"></div>
						<input type="hidden" id="latitude" value="${ meetup.latitude }" />
						<input type="hidden" id="longitude" value="${ meetup.longitude }" />
                        <div class="text-end">
                            <small class="text-muted">작성일: ${meetup.formattedW_date} | 조회수: ${views} | 추천: ${meetup.recommend}</small>
                        </div>
						</div>
					</div>
				</div>
				<c:choose>
                    <c:when test="${user != null && user.email == meetup.email || user.role == 'ROLE_ADMIN'}">
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
                            <div class="participant">                         
                                    <img src="/upload/basic2.png" alt="">
                                    <div>
										<p>신청자: ${apply.id }</p>
                                        <p>닉네임: ${apply.name}</p>
                                        <p>신청 날짜: ${apply.apply_date}</p>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
						<!-- 수정, 삭제, 이전으로 버튼 -->
						<div class="d-flex justify-content-center gap-3 mt-3">
							<!-- 수정 버튼 -->
							<form action="/meetup/modify.html">
								<input type="hidden" name="m_id" value="${meetup.m_id}">
								<input type="submit" value="수정" class="btn btn-outline-secondary">
							</form>
							<!-- 삭제 버튼 -->
							<form action="/meetup/modify.html" onsubmit="return check()">
								<input type="hidden" name="m_id" value="${meetup.m_id}">
								<input type="submit" value="삭제" class="btn btn-outline-danger">
							</form>
							<!-- 이전으로 버튼 -->
							<c:if test="${c_key == 1}">
							    <a href="/category/moveSport" class="btn btn-outline-secondary">이전으로</a>
							</c:if>
							<c:if test="${c_key == 2}">
							    <a href="/category/moveMusic" class="btn btn-outline-secondary">이전으로</a>
							</c:if>
							<c:if test="${c_key == 3}">
							    <a href="/category/moveStudy" class="btn btn-outline-secondary">이전으로</a>
							</c:if>
							<c:if test="${c_key == 4}">
							    <a href="/category/moveGame" class="btn btn-outline-secondary">이전으로</a>
							</c:if>
							<c:if test="${c_key == 5}">
							    <a href="/category/moveTravel" class="btn btn-outline-secondary">이전으로</a>
							</c:if>
							<c:if test="${c_key == 6}">
							    <a href="/category/moveEtc" class="btn btn-outline-secondary">이전으로</a>
							</c:if>
						</div>
						<script type="text/javascript">
							function check(frm) {
								if (!confirm("정말로 삭제하시겠습니까?"))
									return false;
							}
						</script>
					</c:when>
					<c:otherwise>
						<div class="d-flex justify-content-center gap-2 mt-3">
							<!-- 참가신청 버튼 -->
							<form action="/applyMeeting" method="POST">
								<input type="hidden" name="m_id" value="${meetup.m_id}">
								<input type="submit" value="참가신청" class="btn btn-gradient" onsubmit="return check()">
							</form>

							<!-- 신고 버튼 -->
							<form action="/meetup/report.html" class="d-flex">
								<input type="hidden" name="m_id" value="${meetup.m_id}" />
								<button type="submit" class="btn btn-outline-danger">🚨신고</button>
							</form>
							<!-- 이전으로 버튼 -->
								<c:if test="${c_key == 1}">
								    <a href="/category/moveSport" class="btn btn-outline-secondary">이전으로</a>
								</c:if>
								<c:if test="${c_key == 2}">
								    <a href="/category/moveMusic" class="btn btn-outline-secondary">이전으로</a>
								</c:if>
								<c:if test="${c_key == 3}">
								    <a href="/category/moveStudy" class="btn btn-outline-secondary">이전으로</a>
								</c:if>
								<c:if test="${c_key == 4}">
								    <a href="/category/moveGame" class="btn btn-outline-secondary">이전으로</a>
								</c:if>
								<c:if test="${c_key == 5}">
								    <a href="/category/moveTravel" class="btn btn-outline-secondary">이전으로</a>
								</c:if>
								<c:if test="${c_key == 6}">
								    <a href="/category/moveEtc" class="btn btn-outline-secondary">이전으로</a>
								</c:if>
							</div>
						</div>
					</c:otherwise>
				</c:choose>
				</div>			
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
