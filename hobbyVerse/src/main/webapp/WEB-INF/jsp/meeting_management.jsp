<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>모임 관리</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
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
    <jsp:include page="/WEB-INF/jsp/adminNavber.jsp"/>

    <div class="container mt-5">
        <h2 class="text-center">📅 모임 관리</h2>
        <table class="table table-hover mt-4">
            <thead class="table-dark">
                <tr>
                    <th>ID</th>
                    <th>모임 이름</th>
                    <th>주최자</th>
                    <th>날짜</th>
                    <th>관리</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="meeting" items="${meetList}">
                    <tr>
                        <td>${meeting.m_id}</td>
                        <td>${meeting.title}</td>
                        <td>${meeting.w_id}</td>
                        <td>${meeting.w_date}</td>
                        <td>
                            <a href="/api/admin/meeting/edit/form/${meeting.m_id}" class="btn btn-warning btn-sm">✏ 수정</a>
                            <a href="/admin/meeting/delete/${meeting.m_id}" class="btn btn-danger btn-sm" onclick="return confirm('삭제할까요?')">🗑 삭제</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
