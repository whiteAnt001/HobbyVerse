<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>참여 신청한 모임</title>
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
    <jsp:include page="/WEB-INF/jsp/navbar.jsp" />

    <div class="container mt-5">
        <h2 class="text-center mb-4">참여 신청한 모임</h2>

        <c:if test="${not empty joinedMeetings}">
            <ul class="list-group">
                <c:forEach var="meeting" items="${joinedMeetings}">
                    <li class="list-group-item d-flex justify-content-between align-items-center">
                        ${meeting.title} - ${meeting.date}
                        <a href="/meeting/${meeting.id}" class="btn btn-primary btn-sm">참가 정보</a>
                    </li>
                </c:forEach>
            </ul>
        </c:if>

        <c:if test="${empty joinedMeetings}">
            <h2 align="center"><font color="blue">참여신청한 모임이 없습니다.</font></h2>
        </c:if>
    </div>

</body>
</html>
