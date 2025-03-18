<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
	    <!-- CSS 파일 링크 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
<style>
/* 기본 Reset & 글꼴 */
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

body {
	background-color: #ffffff;
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

/* 드롭다운 버튼과 메뉴의 배경을 흰색으로 설정 */
.option-dropdown-toggle {
	background-color: white; /* 버튼 배경을 흰색으로 설정 */
	color: #333; /* 텍스트 색을 어두운 색으로 설정 */
	border: 1px solid #ddd; /* 테두리 색을 연한 회색으로 설정 */
}

.option-dropdown-menu {
	background-color: white; /* 메뉴 배경을 흰색으로 설정 */
	border: 1px solid #ddd; /* 메뉴 테두리를 연한 회색으로 설정 */
	box-shadow: 0px 8px 16px rgba(0, 0, 0, 0.2); /* 그림자 추가 */
}

.option-dropdown-item {
	color: #333; /* 메뉴 항목의 텍스트 색을 어두운 색으로 설정 */
}

.option-dropdown-item:hover {
	background-color: #f0f0f0; /* 메뉴 항목에 마우스를 올렸을 때 배경을 연한 회색으로 설정 */
	color: #333; /* 텍스트 색을 어두운 색으로 설정 */
}
/* 카테고리 링크 스타일 */
a.text-decoration-none {
	color: #000000; /* 글씨 색을 검정색으로 설정 */
}

a.text-decoration-none:hover {
	color: #007bff; /* 마우스 오버 시 색상 변경 */
}

a.text-decoration-none i {
	font-size: 1.2rem; /* 아이콘 크기 */
}

a.text-decoration-none:hover i {
	color: #007bff; /* 아이콘 색상 마우스 오버 시 변경 */
}

.btn-toggle {
	width: 50px;
	height: 50px;
	display: flex;
	align-items: center;
	justify-content: center;
	border: 2px solid transparent;
	background-color: white;
}

/* 기존 스타일 유지 */
.btn-toggle.active {
	border-color: transparent; /* 활성화된 버튼의 파란색 테두리 제거 */
}

.icon-grid, .icon-list {
	width: 24px;
	height: 24px;
	background-size: contain;
	background-repeat: no-repeat;
}
.list-item {
    background-color: #fff;  /* 순백색 */
    padding: 15px;
    margin-bottom: 10px;
    border: 1px solid #ddd;  /* 테두리 추가 */
}

.icon-grid {
	background-image: url('https://img.icons8.com/ios/50/000000/grid.png');
}

.icon-list {
	background-image: url('https://img.icons8.com/ios/50/000000/list.png');
}
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/jsp/navbar.jsp" />
	<div class="row">

		<div class="p-4 border rounded shadow-sm">
			<h3 class="section-header text-center">모든 모임 한눈에 보기 👁️</h3>
			<div class="container mt-4">
				<div class="d-flex justify-content-end align-items-center">
					<div class="d-flex ms-auto gap-2">
						<a class="btn-toggle" id="gridView"
							href="/category/meetGrid?design=gridView">
							<div class="icon-grid"></div>
						</a> <a class="btn-toggle active" id="listView"
							href="/category/meetList?design=listView">
							<div class="icon-list"></div>
						</a>
					</div>
				</div>
				<div class="d-flex justify-content-end align-items-center">
					<div class="d-flex ms-auto">
						<a href="/category/moveSport" class="me-3 text-decoration-none">
							<i class="fas fa-basketball-ball me-2"></i> 스포츠
						</a> <a href="/category/moveMusic" class="me-3 text-decoration-none">
							<i class="fas fa-music me-2"></i> 음악
						</a> <a href="/category/moveStudy" class="me-3 text-decoration-none">
							<i class="fas fa-book me-2"></i> 스터디
						</a> <a href="/category/moveGame" class="me-3 text-decoration-none">
							<i class="fas fa-gamepad me-2"></i> 게임
						</a> <a href="/category/moveTravel" class="me-3 text-decoration-none">
							<i class="fas fa-plane-departure me-2"></i> 여행
						</a> <a href="/category/moveEtc" class="me-3 text-decoration-none">
							<i class="fas fa-ellipsis-h me-2"></i> 기타
						</a>
					</div>
					<!-- 정렬 기준 선택 -->
					<div class="dropdown">
						<button class="btn btn-light dropdown-toggle" type="button"
							id="dropdownMenuButton" data-bs-toggle="dropdown"
							aria-expanded="false">
							<c:choose>
								<c:when
									test="${param.option == 'korean' || param.option == null}">가나다 순</c:when>
								<c:when test="${param.option == 'popular'}">인기 순</c:when>
								<c:when test="${param.option == 'recent'}">최근 순</c:when>
								<c:otherwise>가나다 순</c:otherwise>
							</c:choose>
						</button>
						<ul class="dropdown-menu option-dropdown-menu"
							aria-labelledby="dropdownMenuButton">
							<li><a class="dropdown-item option-dropdown-item"
								href="/category/meetList?option=korean">가나다 순</a></li>
							<li><a class="dropdown-item option-dropdown-item"
								href="/category/meetList?option=popular">인기 순</a></li>
							<li><a class="dropdown-item option-dropdown-item"
								href="/category/meetList?option=recent">최신 순</a></li>
						</ul>
					</div>
				</div>
				<div class="row">
					<c:forEach var="meet" items="${meetListOption }">
						<div class="col-md-12 mb-4">
							<div class="meeting-card d-flex align-items-center p-3 rounded">
								<!-- 텍스트 내용 -->
								<div class="flex-grow-1">
									<h5 class="card-title">${meet.title}</h5>
									<p class="card-text">일정: ${meet.m_date}</p>
									<p class="card-text">위치: ${meet.address}</p>
									<p class="card-text">❤️${meet.recommend }</p>
									<a href="/meetup/detailCategory.html?id=${meet.m_id}"
										class="btn btn-primary btn-sm">자세히보기</a>
								</div>
								<!-- 이미지 -->
								<div style="width: 120px; height: 120px; margin-left: 15px;">
									<img
										src="${pageContext.request.contextPath}/upload/${meet.imagename}"
										class="image rounded" />
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
		</div>

	</div>
	<div align="center">
		<c:set var="pageCount" value="${pageCount}" />
		<c:set var="currentPage" value="${currentPage}" />

		<c:set var="startPage"
			value="${currentPage - (currentPage % 10 == 0 ? 10 : (currentPage % 10)) + 1}" />
		<c:set var="endPage" value="${startPage + 9}" />
		<c:if test="${endPage > pageCount}">
			<c:set var="endPage" value="${pageCount}" />
		</c:if>

		<c:if test="${startPage > 1}">
			<a
				href="/category/meetList?pageNo=${startPage - 1}&option=${param.option}">[이전]</a>
		</c:if>

		<c:forEach begin="${startPage }" end="${endPage}" var="i">
			<c:if test="${currentPage == i}">
				<font size="6">
			</c:if>
			<a href="/category/meetList?pageNo=${i}&option=${param.option}">${i}</a>
			<c:if test="${currentPage == i}">
				</font>
			</c:if>
		</c:forEach>

		<c:if test="${endPage < pageCount}">
			<a href="/category/meetList?pageNo=${endPage + 1}&option=${param.option}">[다음]</a>
		</c:if>
	</div>
	    	<!-- 푸터 -->
   	<footer>
	<jsp:include page="/WEB-INF/jsp/footer.jsp" />
	</footer>
</body>
</html>