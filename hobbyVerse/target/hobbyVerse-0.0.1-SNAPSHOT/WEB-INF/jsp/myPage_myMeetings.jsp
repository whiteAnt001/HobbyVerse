<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>내가 만든 모임</title>
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

        /* 신청한 모임 카드 스타일 */
        .meeting-card {
            background-color: #ffffff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            display: flex;
            padding: 20px;
            transition: transform 0.3s ease;
        }

        .meeting-card:hover {
            transform: translateY(-5px);
        }

        .meeting-card .flex-grow-1 {
            flex-grow: 1;
        }

        .meeting-card .card-title {
            font-size: 1.25rem;
            font-weight: bold;
            color: #333;
        }

        .meeting-card .card-text {
            font-size: 1rem;
            color: #777;
        }

        .meeting-card .btn {
            background-color: #2575fc;
            color: white;
            border: none;
            border-radius: 5px;
        }

        .meeting-card .btn:hover {
            background-color: #6a11cb;
        }

        /* 이미지 스타일 */
        .meeting-card .image {
            width: 120px;
            height: 120px;
            object-fit: cover;
            border-radius: 8px;
        }

        /* 만든 모임 없을 경우 메시지 */
        .alert {
            font-size: 1.1rem;
            font-weight: bold;
            color: #fff;
        }
    </style>
</head>
<body>

    <!-- 네비게이션 바 -->
    <jsp:include page="/WEB-INF/jsp/navbar.jsp" />

    <!-- 내가 만든 모임 리스트 -->
    <div class="container">
        <h3>내가 만든 모임</h3>

        <!-- 만든 모임이 없을 경우 처리 -->
        <c:if test="${empty createdMeetings}">
            <div class="alert alert-warning text-center" role="alert">아직 만든 모임이 없습니다.</div>
        </c:if>

        <!-- 만든 모임 목록 -->
        <div class="row">
            <c:forEach var="meeting" items="${createdMeetings}">
                <div class="col-md-12 mb-4">
                    <a href="/meetup/detail.html?id=${meeting.m_id}" style="text-decoration: none;">
                        <div class="meeting-card">
                            <!-- 텍스트 내용 -->
                            <div class="flex-grow-1">
                                <h5 class="card-title">${meeting.title}</h5><br/>
                                <p class="card-text">작성일: ${meeting.formattedW_date}</p>
                                <p class="card-text">모임 일정: ${meeting.m_date}</p>
                                <p class="card-text">모임 위치: ${meeting.address}</p>
                            </div>
                            <!-- 이미지 -->
                            <div style="width: 120px; height: 120px; margin-left: 15px;">
                                <img src="${pageContext.request.contextPath}/upload/${meeting.imagename}" class="image" />
                            </div>
                        </div>
                    </a>
                </div>
            </c:forEach>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
