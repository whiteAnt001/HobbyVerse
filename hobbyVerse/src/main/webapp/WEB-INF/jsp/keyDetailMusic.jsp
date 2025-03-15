<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>카테고리 상세 | HobbyMatch</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<style>
/* 전체 배경 */
body {
	background: #f4f4f4;
	color: #333;
	min-height: 100vh;
}

/* 네비게이션 바 */
.gradient-bg {
	background: linear-gradient(135deg, #6a11cb, #2575fc);
}

/* 헤더 영역 */
.category-header {
	background: linear-gradient(135deg, #6a11cb, #2575fc);
	color: white;
	padding: 40px 20px;
	text-align: center;
	border-radius: 0 0 20px 20px;
	animation: fadeIn 1s ease-in-out;
}

.meeting-card {
	background: white;
	border-radius: 10px;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
	transition: transform 0.3s ease-in-out;
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 10px;
	height: 200px; /* 고정된 높이 */
}

.meeting-card:hover {
	transform: scale(1.05);
}

.gradient-bg {
	background: linear-gradient(135deg, #6a11cb, #2575fc);
}

.gradient-btn {
	background: linear-gradient(135deg, #6a11cb, #2575fc);
	border: none;
	color: white;
}

.gradient-btn:hover {
	background: linear-gradient(135deg, #2575fc, #6a11cb);
}

/* 이미지 스타일 */
.meeting-card img {
	object-fit: contain; /* 이미지가 부모 div에 맞게 크기 조정, 잘리지 않음 */
	width: 100%; /* 부모 div 너비에 맞게 확장 */
	height: 100%; /* 부모 div 높이에 맞게 확장 */
	border-radius: 10px; /* 카드의 모서리에 맞게 이미지 둥글게 처리 */
}

.filter-bar {
	background: white;
	padding: 10px;
	border-radius: 10px;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
}

.image {
	margin-left: -10px;
}

/* 애니메이션 효과 */
keyframes fadeIn {from { opacity:0;
	transform: translateY(-20px);
}

to {
	opacity: 1;
	transform: translateY(0);
}
</style>
</head>
<body>

	<!-- 네비게이션 바 포함 -->
	<jsp:include page="/WEB-INF/jsp/navbar.jsp" />

	<!-- 카테고리 헤더 -->
	<div class="category-header">
		<h1>🎵 음악 모임</h1>
		<p>다양한 악기를 연주하고 함께 즐길 사람들을 찾아보세요!</p>
	</div>

	<!-- 필터 & 정렬 -->
	<div class="container mt-4">
		<div class="row">
			<div class="col-md-8 mx-auto">
				<form action="/category/search" method="post" class="input-group">
					<input type="text" class="form-control" name="NAME"
						placeholder="검색어를 입력하세요..." /> <input type="hidden" name="KEY"
						value="${KEY }" />
					<button type="submit" class="btn gradient-btn">검색</button>
				</form>
			</div>
		</div>
	</div>

	<!-- 모임 목록 -->
	<div class="container mt-4">
		<div class="row">
			<c:forEach var="key" items="${keyCategory }">
				<div class="col-md-4 mb-4">
					<div class="meeting-card"
						style="display: flex; justify-content: space-between; align-items: center;">
						<div class="p-3" style="flex: 1; padding-right: 10px;">
							<!-- 모임 이름 -->
							<h5 class="card-title">${key.title}</h5>

							<!-- 작성일 -->
							<p class="card-text">일정: ${key.m_date}</p>

							<!-- 자세히보기 버튼 -->
							<a href="/meetup/detailCategory.html?id=${key.m_id}"
								class="btn btn-primary">자세히보기</a>
						</div>

						<!-- 이미지 오른쪽 정렬 -->
						<div style="width: 150px; height: 150px; position: relative;">
							<img
								src="${pageContext.request.contextPath}/upload/${key.imagename}"
								alt="" class="image" />
						</div>
					</div>
				</div>
			</c:forEach>
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
			<a href="/category/moveSport?pageNo=${startPage - 1}">[이전]</a>
		</c:if>

		<c:forEach begin="${startPage }" end="${endPage}" var="i">
			<c:if test="${currentPage == i}">
				<font size="6">
			</c:if>
			<a href="/category/moveSport?pageNo=${i}">${i}</a>
			<c:if test="${currentPage == i}">
				</font>
			</c:if>
		</c:forEach>

		<c:if test="${endPage < pageCount}">
			<a href="/category/moveSport?pageNo=${endPage + 1}">[다음]</a>
		</c:if>
	</div>

	<!-- Bootstrap JS -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>