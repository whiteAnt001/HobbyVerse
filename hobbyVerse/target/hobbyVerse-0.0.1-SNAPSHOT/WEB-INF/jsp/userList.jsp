<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<style>
.gradient-bg {
	background: linear-gradient(135deg, #6a11cb, #2575fc);
}

.table-hover tbody tr:hover {
	background-color: #f1f1f1;
}
</style>
</head>
<body>
	<!-- 관리자 네비게이션 바 포함 -->
	<jsp:include page="/WEB-INF/jsp/adminNavber.jsp" />

	<div class="container mt-5">
		<h2 class="text-center">📅 신청자 목록</h2>

		<table class="table table-hover mt-4">
			<thead class="table-dark">
				<tr>
					<th>ID</th>
					<th>이름</th>
					<th>이메일</th>
					<th>가입일</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="showUser" items="${showUser }">
					<tr>
						<td>${showUser.id }</td>
						<td>${showUser.name }</td>
						<td>${showUser.email }</td>
						<td>${showUser.apply_date }</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>

</body>
</html>