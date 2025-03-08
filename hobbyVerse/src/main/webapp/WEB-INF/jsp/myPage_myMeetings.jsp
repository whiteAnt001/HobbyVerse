<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="UTF-8">
<head>
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

        /* 페이지 컨테이너 */
        .container-lg {
            max-width: 900px;
            margin-top: 50px;
        }

        /* 타이틀 스타일 */
        h2 {
            font-size: 2rem;
            color: #2575fc;
            text-align: center;
            font-weight: bold;
            margin-bottom: 30px;
        }

        /* 카드 마진 */
        .card {
            margin-bottom: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            transition: transform 0.2s;
        }

        .card:hover {
            transform: translateY(-5px);
        }

        /* 모임 리스트 제목 */
        .card-title {
            font-weight: bold;
            font-size: 1.2rem;
            color: #333;
        }

        /* 모임 날짜 */
        .card-subtitle {
            font-size: 0.9rem;
            color: #777;
        }

        /* 버튼 스타일 */
        .btn-primary {
            background-color: #2575fc;
            border-color: #2575fc;
        }

        /* 네비게이션 바 */
        .gradient-bg {
            background: linear-gradient(135deg, #6a11cb, #2575fc);
        }

        /* 모임이 없을 때 메시지 */
        .no-meetup-message {
            text-align: center;
            font-size: 1.5rem;
            font-weight: bold;
            color: #2575fc;
            margin-top: 50px;
        }

        /* 링크 밑줄 제거 */
        .card-title a {
            text-decoration: none;
        }

    </style>
</head>
<body>

    <jsp:include page="/WEB-INF/jsp/navbar.jsp" />

    <div class="container mt-5">
        <h2>내가 만든 모임</h2>

        <!-- 모임이 있을 때 리스트 -->
        <c:if test="${not empty createdMeetings}">
            <div class="row">
                <c:forEach var="meeting" items="${createdMeetings}">
                    <div class="col-md-4">
                        <div class="card">
                        <a href="/meetup/detail.html?id=${meeting.m_id}" style="text-decoration: none;">
                            <div class="card-body">
                                <h5 class="card-title">
                                     <h5 class="text-decoration-none text-dark">모임 제목: ${meeting.title}</h5>
                                </h5>
                                <!-- 모임 작성일 -->
                                <h6 class="card-subtitle mb-2 text-muted">모임 작성일: ${meeting.formattedW_date}</h6>
                            </div>
                            </a>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:if>

        <!-- 모임이 없을 때 -->
        <c:if test="${empty createdMeetings}">
            <div class="no-meetup-message">
                <p>아직 모임을 만들지 않았습니다.</p>
            </div>
        </c:if>
    </div>

</body>
</html>
