<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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

/* 모임 카드 */
.meeting-card {
	background: white;
	border-radius: 10px;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
	transition: transform 0.3s ease-in-out;
}

.meeting-card:hover {
	transform: scale(1.05);
}

.meeting-card img {
	width: 100%;
	height: 200px;
	object-fit: cover;
	border-radius: 10px 10px 0 0;
}

/* 필터 & 정렬 바 */
.filter-bar {
	background: white;
	padding: 10px;
	border-radius: 10px;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
}

/* 애니메이션 효과 */
@
keyframes fadeIn {from { opacity:0;
	transform: translateY(-20px);
}

to {
	opacity: 1;
	transform: translateY(0);
}
}
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/jsp/navbar.jsp" />

	<!-- 카테고리 헤더 -->
	<div class="category-header">
		<c:choose>
			<c:when test="${KEY == 1 }">
				<h1>🏀 스포츠 모임</h1>
				<p>다양한 스포츠를 즐기고 함께 운동할 사람들을 찾아보세요!</p>
			</c:when>
			<c:when test="${KEY == 2 }">
				<h1>🎵 음악 모임</h1>
				<p>다양한 악기를 연주하고 함께 즐길 사람들을 찾아보세요!</p>
			</c:when>
			<c:when test="${KEY == 3 }">
				<h1>📚 스터디 모임</h1>
				<p>함께 열심히 자격증이나 개인 공부합시다. 독서도 환영!</p>
			</c:when>
			<c:when test="${KEY == 4 }">
				<h1>🎮 게임 모임</h1>
				<p>다양한 게임을 즐기고 함께 놀 사람을 찾아보세요!</p>
			</c:when>
			<c:when test="${KEY == 5 }">
				<h1>✈️ 여행 모임</h1>
				<p>여럿이 여행을 떠나요!</p>
			</c:when>
			<c:when test="${KEY == 6 }">
				<h1>🍳 기타</h1>
				<p>그 외 기타 모임!</p>
			</c:when>
		</c:choose>
	</div>

	<div>
		<form action="/category/search" method="post">
			<div class="container mt-4">
				<div class="row">
					<div class="col-md-8 mx-auto">
						<div
							class="filter-bar d-flex justify-content-between align-items-center">
							모임 검색<input type="text" name="NAME" /><input type="hidden"
								name="KEY" value="${KEY }" /> <input type="submit" value="검색" />
							<select class="form-select w-auto">
								<option>최신순</option>
								<option>인기순</option>
								<option>참가비 낮은순</option>
							</select>
						</div>
					</div>
				</div>
			</div>
		</form>

		<c:if test="${not empty alertSuccess }">
			<script type="text/javascript">
				alert("${alertSuccess}");
			</script>
		</c:if>

		<div class="container mt-4">
			<div class="row">
				<c:choose>
					<c:when test="${keyList[0] == null }">
						<div align="center">
							<h2>아직 해당 모임이 만들어지지 않았어요</h2>
						</div>
					</c:when>
					<c:otherwise>
						<c:forEach var="key" items="${keyList}">
							<div class="col-md-4 mb-4">
								<table border="1">

									<div class="meeting-card">
										<div clss="p-3">
											<div class="meeting-card">
												<div class="p-3">
													<!-- <th>모임 아이디</th> -->
													${key.m_id }

													<!-- <th>모임 이름</th> -->
													<h5 class="card-title">${key.title }</h5>

													<!-- <th>작성일</th> -->
													<p class="card-text">날짜: ${key.m_date }</p>

													<a href="/meetup/detail.html?id=${key.m_id }"
														class="btn btn-primary">자세히보기</a>
												</div>
											</div>
										</div>
									</div>
								</table>
							</div>
						</c:forEach>
					</c:otherwise>
				</c:choose>
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

		<c:if test="${startPage > 10}">
			<a href="/category/search?pageNo=${startPage - 1}">[이전]</a>
		</c:if>

		<c:forEach begin="${startPage }" end="${endPage}" var="i">
			<c:if test="${currentPage == i}">
				<font size="6">
			</c:if>
			<a href="/category/search?pageNo=${i}">${i}</a>
			<c:if test="${currentPage == i}">
				</font>
			</c:if>
		</c:forEach>

		<c:if test="${endPage < pageCount}">
			<a href="/category/search?pageNo=${endPage + 1}">[다음]</a>
		</c:if>
	</div>



	<!-- Bootstrap JS -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>