<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="UTF-8">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>취미/스터디 매칭 플랫폼</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<!-- FontAwesome CDN 추가 -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

<style>
/* 그라데이션 스타일 */
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

.image {
	width: 225px;
	height: 200px;
	margin-bottom: 10px;
}
</style>
</head>
<body>
	<!-- 네비게이션 바 포함 -->
	<jsp:include page="/WEB-INF/jsp/navbar.jsp" />
	<!-- 검색 및 필터 -->
	<div class="container mt-4">
		<div class="row">
			<div class="col-md-8 mx-auto">
				<form action="/meetup/search.html" method="post">
					<div class="input-group">
						<input type="text" name="title" class="form-control"
							placeholder="관심 있는 모임을 검색하세요...">
						<button class="btn gradient-btn">검색</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<!-- 인기 모임 목록 -->
	<div class="container mt-5">
		<h3 class="text-center mb-4">🔥 인기 모임</h3>

		<div class="row d-flex align-items-center justify-content-between">
			<!-- 왼쪽 화살표 -->
			<div class="col-auto">
				<a href="../home?PAGE_NUM=${currentPage - 1}" class="btn btn-light"
					<c:if test="${currentPage <= 1}"> style="pointer-events: none; opacity: 0.5;" </c:if>>
					◀ </a>
			</div>

			<!-- 모임 목록 -->
			<div
				class="col d-flex justify-content-start flex-nowrap over-flow">
				<c:forEach var="meet" items="${meetList}">
					<form method="post" action="/home" class="col-md-3 mb-3 me-2">
						<div class="card shadow-sm">
							<div class="card-body d-flex align-items-center">
								<div class="me-3">
									<img
										src="${pageContext.request.contextPath}/upload/${meet.imagename}"
										alt="" class="image">
									<h5 class="card-title">${meet.title}</h5>
									<p class="card-text">날짜: ${meet.m_date}</p>
									<p class="card-text" style="font-size: 13px;">👍${meet.recommend}</p>
									<a href="/meetup/detail.html?id=${meet.m_id}"
										class="btn btn-primary">자세히 보기</a>
								</div>
							</div>
						</div>
					</form>
				</c:forEach>
			</div>

			<!-- 오른쪽 화살표 -->
			<div class="col-auto">
				<a href="../home?PAGE_NUM=${currentPage + 1}" class="btn btn-light"
					<c:if test="${currentPage >= pageCount}"> style="pointer-events: none; opacity: 0.5;" </c:if>>
					▶ </a>
			</div>
		</div>
	</div>
	<!-- Bootstrap JS -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
