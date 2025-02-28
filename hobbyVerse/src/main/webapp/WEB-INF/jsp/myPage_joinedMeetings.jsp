<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>참여 신청한 모임</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<style>
/* 전체 배경 */
body {
	background: #f4f4f4;
	color: #333;
	min-height: 100vh;
}

/* 마이페이지 크기 키우기 */
.container-lg {
	max-width: 900px; /* container-lg의 최대 너비를 더 넓게 설정 */
	margin-top: 50px;
}

/* 카드 마진 */
.card {
	margin-bottom: 20px;
}

/* 네비게이션 바 */
.gradient-bg {
	background: linear-gradient(135deg, #6a11cb, #2575fc);
}
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/jsp/navbar.jsp" />

	<div class="container mt-5">
		<h2 class="text-center mb-4">참여 신청한 모임</h2>

		<c:forEach var="meetingList" items="${meetingList }">
			<table>
				<tr>
					<th>모임 아이디:</th>
					<td>${meetingList.m_id}</td>
				</tr>
				<tr>
					<th>모임 이름:</th>
					<td>${meetingList.title }</td>
				</tr>
				<tr>
					<th>신청 날짜:</th>
					<td>${meetingList.apply_date}</td>
				</tr>
				<tr>
					<th><a href="/myPage">마이 페이지 이동하기</a></th>
				</tr>
			</table>
	</div>
	</c:forEach>

	</div>

</body>
</html>
