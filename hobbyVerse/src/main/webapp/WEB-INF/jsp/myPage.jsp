<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="UTF-8">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>마이페이지</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
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
</style>
</head>
<body>
	<!-- 네비게이션 바 포함 -->
	<jsp:include page="/WEB-INF/jsp/navbar.jsp" />
	<!-- 마이페이지 콘텐츠 -->
	<div class="container mt-5">
		<h2 class="text-center mb-4">마이페이지</h2>

		<!-- 사용자 정보 -->
		<div class="card mb-4">
			<div class="card-header">
				<h5 class="card-title">내 정보</h5>
			</div>
			<div class="card-body">
				<p>
					<strong>이름:</strong> ${user.name}
				</p>
				<p>
					<strong>이메일:</strong> ${user.email}
				</p>
			</div>
		</div>
		<div class="card mb-4">
			<div class="card-header">
				<h5 class="card-title">비밀번호 변경</h5>
			</div>
			<div class="card-body">
				<form action="/changePassword" method="post">
					<div class="mb-3 password-wrapper">
						<c:if test="${not empty message}">
							<div class="alert alert-info mt-3">${message}</div>
						</c:if>
						<label for="currentPassword" class="form-label">현재 비밀번호</label> <input
							type="password" class="form-control" id="currentPassword"
							name="currentPassword" required> <i
							class="fa-solid fa-eye eye-icon"
							onclick="togglePasswordVisibility('currentPassword', this)"></i>
					</div>
					<div class="mb-3 password-wrapper">
						<label for="newPassword" class="form-label">새 비밀번호</label> <input
							type="password" class="form-control" id="newPassword"
							name="newPassword" required> <i
							class="fa-solid fa-eye eye-icon"
							onclick="togglePasswordVisibility('newPassword', this)"></i>
					</div>
					<div class="mb-3 password-wrapper">
						<label for="confirmPassword" class="form-label">새 비밀번호 확인</label>
						<input type="password" class="form-control" id="confirmPassword"
							name="confirmPassword" required> <i
							class="fa-solid fa-eye eye-icon"
							onclick="togglePasswordVisibility('confirmPassword', this)"></i>
					</div>
					<button type="submit" class="btn gradient-btn">비밀번호 변경</button>
				</form>
			</div>
		</div>

		<!-- 내가 만든 모임 관리 -->
		<div class="card mb-4">
			<div class="card-header">
				<h5 class="card-title">내가 만든 모임</h5>
			</div>
			<div class="card-body">
				<c:if test="${not empty createdMeetings}">
					<ul class="list-group">
						<c:forEach var="meeting" items="${createdMeetings}">
							<li
								class="list-group-item d-flex justify-content-between align-items-center">
								${meeting.title} - ${meeting.date} <a
								href="/meeting/${meeting.id}" class="btn btn-info btn-sm">모임
									관리</a>
							</li>
						</c:forEach>
					</ul>
				</c:if>
				<c:if test="${empty createdMeetings}">
					<p>아직 만든 모임이 없습니다.</p>
				</c:if>
			</div>
		</div>

		<!-- 내가 참가 신청한 모임 -->
		<div class="card mb-4">
			<div class="card-header">
				<h5 class="card-title">참가 신청한 모임</h5>
			</div>
			<div class="card-body">
				<c:if test="${not empty joinedMeetings}">
					<ul class="list-group">
						<c:forEach var="meeting" items="${joinedMeetings}">
							<li
								class="list-group-item d-flex justify-content-between align-items-center">
								${meeting.title} - ${meeting.date} <a
								href="/meeting/${meeting.id}" class="btn btn-primary btn-sm">참가
									정보</a>
							</li>
						</c:forEach>
					</ul>
				</c:if>
				<c:if test="${empty joinedMeetings}">
					<p>참가 신청한 모임이 없습니다.</p>
				</c:if>
			</div>
		</div>

		<!-- 회원 탈퇴 -->
		<div class="card mb-4">
			<div class="card-header">
				<h5 class="card-title">회원 탈퇴</h5>
			</div>
			<div class="card-body">
				<form action="/deleteAccount" method="post">
					<button type="submit" class="btn btn-danger">회원 탈퇴</button>
				</form>
			</div>
		</div>

	</div>
	<!-- Font Awesome 라이브러리 사용 -->
	<script>
		function togglePasswordVisibility(inputId, icon) {
			const input = document.getElementById(inputId);
			if (input.type === "password") {
				input.type = "text";
				icon.classList.remove("fa-eye");
				icon.classList.add("fa-eye-slash"); // 눈 감은 아이콘으로 변경
			} else {
				input.type = "password";
				icon.classList.remove("fa-eye-slash");
				icon.classList.add("fa-eye"); // 눈 뜬 아이콘으로 변경
			}
		}
	</script>

	<!-- Bootstrap JS -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js">
		
	</script>



</body>
</html>
