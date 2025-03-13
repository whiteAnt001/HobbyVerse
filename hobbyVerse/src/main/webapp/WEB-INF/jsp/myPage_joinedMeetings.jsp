<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>참여 신청한 모임</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <style>
/* 전체 배경 */
body {
	background: #f4f4f4;
	color: #333;
	min-height: 100vh;
	font-family: 'Arial', sans-serif;
}

/* 컨테이너 크기 */
.container {
	max-width: 900px;
	margin-top: 50px;
}

/* 타이틀 */
h3 {
	font-size: 2rem;
	color: #2575fc;
	text-align: center;
	font-weight: bold;
	margin-bottom: 30px;
}

/* 카드 디자인 */
.card {
	margin-bottom: 20px;
	border-radius: 8px;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
	transition: transform 0.2s;
}

.card:hover {
	transform: translateY(-5px);
}

.card-body {
	padding: 1.5rem;
}

.card-title {
	font-weight: bold;
	font-size: 1.1rem;
	color: #333;
}

.card-subtitle {
	font-size: 0.9rem;
	color: #777;
}

.card-text {
	font-size: 0.95rem;
}

/* 신청한 모임 없을 경우 메시지 */
.alert {
	font-size: 1.1rem;
	font-weight: bold;
	color: #fff;
}

/* 그라데이션 버튼 */
.gradient-btn {
	background: linear-gradient(135deg, #6a11cb, #2575fc);
	border: none;
	color: white;
	border-radius: 8px;
	padding: 10px 20px;
}

.gradient-btn:hover {
	background: linear-gradient(135deg, #2575fc, #6a11cb);
}
/* 네비게이션 바 */
.gradient-bg {
	background: linear-gradient(135deg, #6a11cb, #2575fc);
}
</style>
</head>
<body>

    <!-- 네비게이션 바 -->
    <jsp:include page="/WEB-INF/jsp/navbar.jsp" />

    <!-- 모임 신청 리스트 -->
    <div class="container">
        <h3>참여 신청한 모임</h3>

        <!-- 신청한 모임이 없을 경우 처리 -->
        <c:if test="${empty meetingApply}">
            <div class="alert alert-warning text-center" role="alert">신청한 모임이 없습니다.</div>
        </c:if>

        <!-- 신청한 모임 목록 -->
        <c:forEach var="meeting" items="${meetingApply}">
            <a href="/applyDetail?m_id=${meeting.mid}" style="text-decoration: none;">
                <div class="card mb-4">
                    <div class="card-body">
                        <h4 class="card-subtitle mb-2 text-muted"><Strong>모임 이름: ${meeting.title}</Strong></h4>
                        <p class="card-text">신청 날짜: <fmt:formatDate value="${meeting.apply_date}" pattern="yyyy-MM-dd" /></p>
                    </div>
                </div>
            </a>
        </c:forEach>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
