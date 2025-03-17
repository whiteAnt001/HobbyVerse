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

<style type="text/css">
/* 기본 Reset & 글꼴 */
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

body {
    background-color: #ffffff; /* 기본 배경을 흰색으로 설정 */
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

/* 모임 목록 카드 스타일 */
.meeting-card {
	background-color: #ffffff;
	border: 1px solid #ddd;
	border-radius: 10px;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
	margin-bottom: 20px;
	padding: 20px;
	width: 100%;
	height: 450px; /* 일정한 카드 높이 설정 */
	display: flex;
	flex-direction: column;
	justify-content: space-between; /* 내용 간 간격 균등 배치 */
}

/* 카드 4개씩 배치 */
.card-item {
	width: calc(25% - 20px); /* 한 줄에 4개 카드 배치 */
	box-sizing: border-box;
}

@media ( max-width : 1200px) {
	.card-item {
		width: calc(33.33% - 20px); /* 화면이 작아지면 3개 */
	}
}

@media ( max-width : 992px) {
	.card-item {
		width: calc(50% - 20px); /* 태블릿에서는 2개 */
	}
}

@media ( max-width : 768px) {
	.card-item {
		width: calc(100% - 20px); /* 작은 화면에서는 1개 */
	}
}

/* 폰트 크기 줄이기 */
.meeting-card h5 {
	font-size: 1.2rem; /* 카드 제목 폰트 크기 줄이기 */
}

.meeting-card p {
	font-size: 0.9rem; /* 카드 텍스트 폰트 크기 줄이기 */
}

/* 카드 내 이미지 */
.meeting-card img {
	width: 100%;
	height: 250px; /* 일정한 이미지 높이 */
	object-fit: cover;
	border-radius: 10px;
}

/* 카드 하단 버튼 */
.meeting-card .btn-primary {
	margin-top: auto; /* 버튼이 하단에 배치되도록 설정 */
}

/* 카드 간 간격 및 스타일 */
.card-list {
	display: flex;
	flex-wrap: wrap;
	gap: 20px;
	justify-content: space-between;
}

/* 반응형 - 작은 화면에서는 3개, 2개, 1개 */
@media ( max-width : 1200px) {
	.card-item {
		width: calc(33.33% - 20px); /* 화면이 작아지면 3개 */
	}
}

@media ( max-width : 992px) {
	.card-item {
		width: calc(50% - 20px); /* 태블릿에서는 2개 */
	}
}

@media ( max-width : 768px) {
	.card-item {
		width: calc(100% - 20px); /* 작은 화면에서는 1개 */
	}
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

.icon-grid {
	background-image: url('https://img.icons8.com/ios/50/000000/grid.png');
}
/* 섹션 헤더 - 깔끔한 다크 그레이 텍스트 */
.section-header {
	font-size: 1.5rem;
	font-weight: bold;
	margin-bottom: 20px;
	color: #333;
}
.list-item {
    background-color: #fff;  /* 순백색 */
    padding: 15px;
    margin-bottom: 10px;
    border: 1px solid #ddd;  /* 테두리 추가 */
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
								<c:when test="${param.option == 'recent'}">최신 순</c:when>
								<c:otherwise>가나다 순</c:otherwise>
							</c:choose>
						</button>
						<ul class="dropdown-menu option-dropdown-menu"
							aria-labelledby="dropdownMenuButton">
							<li><a class="dropdown-item option-dropdown-item"
								href="/category/meetGrid?option=korean">가나다 순</a></li>
							<li><a class="dropdown-item option-dropdown-item"
								href="/category/meetGrid?option=popular">인기 순</a></li>
							<li><a class="dropdown-item option-dropdown-item"
								href="/category/meetGrid?option=recent">최근 순</a></li>
						</ul>
					</div>
				</div>

				<div class="d-flex align-items-center justify-content-between">


					<!-- 가운데 카드 리스트 (가로 스크롤) -->
					<div class="card-list">
						<c:forEach var="meet" items="${meetListOption}">
							<div class="card-item">
								<div class="meeting-card">
									<img
										src="${pageContext.request.contextPath}/upload/${meet.imagename}"
										alt="${meet.title}" />
									<h5 class="card-title">${meet.title}</h5>
									<p class="card-text">일정: ${meet.m_date}</p>
									<p class="card-text">위치: ${meet.address}</p>
									<p class="card-text">❤️${meet.recommend}</p>
									<a href="/meetup/detailCategory.html?id=${meet.m_id}"
										class="btn btn-primary btn-sm">자세히보기</a>
								</div>
							</div>
						</c:forEach>
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
						href="/category/meetGrid?pageNo=${startPage - 1}&option=${param.option}">[이전]</a>
				</c:if>

				<c:forEach begin="${startPage }" end="${endPage}" var="i">
					<c:if test="${currentPage == i}">
						<font size="6">
					</c:if>
					<a href="/category/meetGrid?pageNo=${i}&option=${param.option}">${i}</a>
					<c:if test="${currentPage == i}">
						</font>
					</c:if>
				</c:forEach>

				<c:if test="${endPage < pageCount}">
					<a
						href="/category/meetGrid?pageNo=${endPage + 1}&option=${param.option}">[다음]</a>
				</c:if>
			</div>
</body>
</html>