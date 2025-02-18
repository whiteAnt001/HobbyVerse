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

	<!-- 네비게이션 바 포함 -->
	<jsp:include page="/WEB-INF/jsp/navbar.jsp" />

	<!-- 카테고리 헤더 -->
	<div class="category-header">
		<h1>✈️ 여행 모임</h1>
		<p>여럿이 여행을 떠나요!</p>
	</div>

	<!-- 필터 & 정렬 -->
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

	<!-- 모임 목록 -->
	<div class="container mt-4">
		<div class="row">

			<c:forEach var="key" items="${keyCategory }">
				<div class="col-md-4 mb-4">
					<table border="1">

						<div class="meeting-card">
							<div clss="p-3">
								<tr>
									<th>모임 아이디</th>
									<td>${key.m_id }</td>
								</tr>
								<tr>
									<th>모임 이름</th>
									<td>${key.title }</td>
								</tr>
								<tr>
									<th>작성자</th>
									<td>${key.w_id }</td>
								</tr>
								<tr>
									<th>카테고리</th>
									<td>${key.c_key }</td>
								</tr>
								<tr>
									<th>작성일</th>
									<td>${key.w_date }</td>
								</tr>
								<tr>
									<th>금액</th>
									<td>${key.price }</td>
								</tr>
								<tr>
									<th><a href="/meetup/detail.html">자세히보기</a></th>
								</tr>

							</div>
						</div>

					</table>
				</div>
			</c:forEach>

		</div>
	</div>
	
	<jsp:include page="page.jsp"/>


	<!-- Bootstrap JS -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>