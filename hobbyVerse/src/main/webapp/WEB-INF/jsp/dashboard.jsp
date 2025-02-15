<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>관리자 대시보드</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        .gradient-bg {
            background: linear-gradient(135deg, #6a11cb, #2575fc);
        }
        .dashboard-card {
            background: linear-gradient(135deg, #ff7eb3, #ff758c);
            color: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 3px 3px 15px rgba(0, 0, 0, 0.2);
            text-align: center;
            cursor: pointer;
            transition: transform 0.2s;
        }
        .dashboard-card:hover {
            transform: scale(1.05);
        }
        .emoji {
            font-size: 2rem;
        }
    </style>
</head>
<body>
    <!-- 관리자 네비게이션 바 포함 -->
    <jsp:include page="/WEB-INF/jsp/adminNavber.jsp"/>

    <div class="container mt-5">
        <h2 class="text-center">📊 관리자 대시보드</h2>
        <div class="row mt-4">
            <div class="col-md-4">
                <div class="dashboard-card" onclick="location.href='/api/admin/users'">
                    <div class="emoji">👥</div>
                    <h3>총 회원 수</h3>
                    <p>${totalUsers} 명</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="dashboard-card" onclick="location.href='/api/admin/meetings'">
                    <div class="emoji">📅</div>
                    <h3>총 모임 수</h3>
                    <p>${totalMeet} 개</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="dashboard-card" onclick="location.href='#'">
                    <div class="emoji">📩</div>
                    <h3>문의 사항</h3>
                    <p>${totalInquiries} 건</p>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
