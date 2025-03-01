<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="UTF-8">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>마이페이지</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
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

    <!-- 네비게이션 바 포함 (container-fluid 사용) -->
    <jsp:include page="/WEB-INF/jsp/navbar.jsp" />

    <div class="container-lg">
        <h2 class="text-center mb-4">마이페이지</h2>

        <!-- 내 정보 -->
        <div class="card">
            <div class="card-header">내 정보</div>
            <div class="card-body">
                <p><strong>고유번호:</strong> ${user.userId}</p>
                <p><strong>이름:</strong> ${user.name}</p>
                <p><strong>이메일:</strong> ${user.email}</p>
            </div>
        </div>

        <!-- 기능 목록 -->
        <div class="list-group">
            <a href="/myPage/form/changePassword" class="list-group-item list-group-item-action">비밀번호 변경</a>
            <a href="/myPage/myMeetings" class="list-group-item list-group-item-action">내가 만든 모임</a>
            <a href="/myPage/joinedMeetings" class="list-group-item list-group-item-action">참여 신청한 모임</a>
            <a href="/myPage/myPosts" class="list-group-item list-group-item-action">내가 쓴 게시글</a>
            <a href="/myPage/form/deleteAccount" class="list-group-item list-group-item-action text-danger">회원 탈퇴</a>
        </div>
    </div>

</body>
</html>
