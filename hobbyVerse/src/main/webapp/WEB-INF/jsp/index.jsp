<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>취미/스터디 매칭 플랫폼</title>
<!-- 부트스트랩 / 폰트어썸 -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

<style>
/* 기본 Reset & 글꼴 */
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

body {
	background-color: #f8f9fa;
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 0;
}

.full-container {
	max-width: 1200px;
	margin: 0 auto;
	padding: 0 20px;
}

.container {
	max-width: 1200px;
	margin: 0 auto;
	padding: 20px;
}
/* 왼쪽 추가 여백을 주는 커스텀 컨테이너 */
.custom-container {
	padding-left: 60px;
	padding-right: 60px;
}
/* 섹션 (Section) - 밝은 순백 배경과 고급스러운 그림자 */
.section {
	background-color: #ffffff;
	border-radius: 10px;
	box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
	margin: 40px 0;
	padding: 20px;
	width: 100%;
}
/* 섹션 헤더 - 깔끔한 다크 그레이 텍스트 */
.section-header {
	font-size: 1.5rem;
	font-weight: bold;
	margin-bottom: 20px;
	color: #333;
}
/* 광고 배너 - 부드러운 밝은 파스텔 블루 그라데이션 */
.ad-banner {
	max-width: 1200px;
	margin: 20px auto;
	border-radius: 10px;
	background: linear-gradient(135deg, #e0eafc, #cfdef3);
	text-align: center;
	padding: 20px;
	color: #333;
}
/* 카드 - 흰색 배경, 연한 테두리와 깔끔한 그림자 */
.card {
	width: 280px;
	border-radius: 10px;
	background-color: #ffffff;
	box-shadow: 0px 2px 8px rgba(0, 0, 0, 0.1);
	border: 1px solid #ddd;
	margin-bottom: 15px;
}

.card-body {
	padding: 0.8rem;
}

.card-title {
	font-size: 1rem;
	font-weight: bold;
	color: #333;
}

.card-text {
	font-size: 0.75rem;
	color: #555;
}
/* 카드 내 이미지 */
.image {
	width: 100%;
	height: 100%;
	object-fit: cover;
	border-radius: 10px 10px 0 0;
}
/* 화살표 버튼 - 밝은 배경과 연한 회색 테두리 */
.arrow-btn {
	width: 40px;
	height: 40px;
	border-radius: 50%;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 20px;
	background-color: #ffffff;
	color: #333;
	border: 1px solid #ddd;
	cursor: pointer;
	margin-right: 15px;
	transition: background-color 0.2s;
}

.arrow-btn:hover {
	background-color: #f0f0f0;
}

.arrow-btn:disabled {
	opacity: 0.5;
	cursor: default;
}
/* 박스 내부 스타일 (최신 모임, 공지사항, 인기 게시글) */
.border {
	border: 1px solid #ddd;
	border-radius: 10px;
	background-color: #ffffff;
}

.shadow-sm {
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

.p-4 {
	padding: 20px;
}
/* 리스트 그룹 아이템 - 밝은 배경과 깔끔한 테두리 */
.list-group-item {
	background-color: #ffffff;
	color: #333;
	border: 1px solid #eee;
	margin-bottom: 5px;
}

.list-group-item a {
	color: #007bff;
	text-decoration: none;
}

.list-group-item a:hover {
	text-decoration: underline;
}
/* “최신 모임” 섹션 내 카드 */
.meeting-card {
	background-color: #ffffff;
	border: 1px solid #ddd;
}

.meeting-card .card-title {
	color: #333;
}

.meeting-card .card-text {
	color: #555;
	font-size: 0.85rem;
}
/* 버튼 (자세히 보기 등) - 고급스러운 파스텔 블루 */
.btn-primary {
	background-color: #4a90e2;
	border: none;
	color: #fff;
}

.btn-primary:hover {
	background-color: #357ABD;
}
/* 카드에 마우스 올렸을 때 반응 (그림자 변화 및 배경색 변경) */
.card:hover, .list-group-item:hover {
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
	background-color: #f8f9fa;
	transition: all 0.3s ease;
}
/* 인기 모임 카드에 마우스 올렸을 때 반응 (그림자 변화 및 배경색 변경) */
.card:hover {
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
	background-color: #f8f9fa;
	transition: all 0.3s ease;
}
</style>
</head>
<body>
	<!-- 헤더 -->
	<jsp:include page="/WEB-INF/jsp/navbar.jsp" />

	<!-- 메인 컨테이너 시작 -->
	<div class="container-fluid custom-container">
		<!-- 광고 배너 -->
		<section class="ad-banner">
			<div class="ad-slider">
				<!-- 광고 내용 -->
				<div class="ad" id="ad1">광고 배너 (슬라이드 추가 예정)</div>

			</div>
		</section>

		<!-- 인기 있는 모임 섹션 -->
		<section class="section">
			<h3 class="section-header text-center">지금 가장 인기있는 모임 TOP8</h3>
			<div class="d-flex align-items-center justify-content-between">
				<!-- 왼쪽 버튼 -->
				<button class="arrow-btn ms-4"
					<c:if test="${currentPage <= 1}">disabled</c:if>
					onclick="location.href='../home?PAGE_NUM=${currentPage - 1}'">
					<i class="fas fa-chevron-left"></i>
				</button>

				<!-- 가운데 카드 리스트 (가로 스크롤) -->
				<div class="d-flex flex-nowrap overflow-auto" style="gap: 20px;">
					<c:forEach var="meet" items="${meetList}">
						<a href="/meetup/detail.html?id=${meet.m_id}"
							class="card shadow-sm text-decoration-none" style="width: 280px;">
							<img
							src="${pageContext.request.contextPath}/upload/${meet.imagename}"
							alt="" class="image">
							<div class="card-body text-center">
								<h5 class="card-title">${meet.title}</h5>
								<p class="card-text">일정: ${meet.m_date}</p>
								<p class="card-text">위치: ${meet.address}</p>
								<div class="d-flex justify-content-between">
									<p class="card-text">❤️ ${meet.recommend}</p>
									<p class="card-text">
										<i class="fas fa-eye"></i> ${meet.views}
									</p>
								</div>
							</div>
						</a>
					</c:forEach>
				</div>

				<!-- 오른쪽 버튼 -->
				<button class="arrow-btn"
					<c:if test="${currentPage == 2}">disabled</c:if>
					onclick="location.href='../home?PAGE_NUM=2'">
					<i class="fas fa-chevron-right"></i>
				</button>
			</div>
		</section>


		<!-- 최신 모임, 공지사항 및 인기 게시글 섹션 -->
		<section class="section">
			<div class="row">
				<!-- 최신 모임 -->
				<div class="col-md-6">
					<div class="p-4 border rounded shadow-sm">
						<h3 class="section-header text-center">따끈따끈한 최신 모임</h3>
						<div class="container mt-4">
							<div class="row">
								<c:forEach var="newMeet" items="${latestMeetList}">
									<div class="col-md-12 mb-4">
										<div
											class="meeting-card d-flex align-items-center p-3 rounded">
											<!-- 텍스트 내용 -->
											<div class="flex-grow-1">
												<h5 class="card-title">${newMeet.title}</h5>
												<p class="card-text">일정: ${newMeet.m_date}</p>
												<p class="card-text">위치: ${newMeet.address}</p>
												<a href="/meetup/detail.html?id=${newMeet.m_id}"
													class="btn btn-primary btn-sm">자세히보기</a>
											</div>
											<!-- 이미지 -->
											<div style="width: 120px; height: 120px; margin-left: 15px;">
												<img
													src="${pageContext.request.contextPath}/upload/${newMeet.imagename}"
													class="image rounded" />
											</div>
										</div>
									</div>
								</c:forEach>
							</div>
						</div>
					</div>
				</div>

				<!-- 공지사항 & 인기 게시글 -->
				<div class="col-md-6">
					<div class="p-4 border rounded shadow-sm mb-4">
						<h3 class="section-header text-center">공지사항</h3>
						<div class="container mt-4">
							<div class="list-group">
								<c:forEach var="notice" items="${noticeList}">
									<div
										class="list-group-item d-flex justify-content-between align-items-center p-3">
										<div>
											<strong> <a href="/notices/${notice.id}"
												class="text-decoration-none"> ${notice.title} </a>
											</strong> <small class="text-muted d-block">${notice.regDateString}</small>
										</div>
										<div class="text-end">
											<span class="text-muted ms-2"> <i class="fas fa-eye"></i>
												${notice.view}
											</span>
										</div>
									</div>
								</c:forEach>
							</div>
						</div>
					</div>

                    <!-- 인기 게시글 -->
                    <div class="p-4 border rounded shadow-sm">
                        <h3 class="section-header text-center">인기 게시글</h3>
                        <div class="container mt-4">
                            <div class="list-group">
                                <c:forEach var="post" items="${boardList}">
                                    <div class="list-group-item d-flex justify-content-between align-items-center p-3">
                                        <div>
                                            <strong>
                                                <a href="/boards/${post.seq}" class="text-decoration-none">
                                                    ${post.subject}
                                                </a>
                                            </strong>
                                            <small class="text-muted d-block">${post.regDateString}</small>
                                        </div>
                                        <div class="text-end">
                                            <span class="text-muted ms-2">
                                                <i class="fas fa-eye"></i> ${post.readCount}
                                            </span>
                                            <span class="badge bg-primary">❤️${post.likes}</span>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div> <!-- // .container-fluid 끝 -->
<!-- 부트스트랩 JS 추가 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

	<!-- 푸터 -->
	<jsp:include page="/WEB-INF/jsp/footer.jsp" />
</body>
</html>
